#!/usr/bin/env python3
"""
Ẑelkova Landing Server — Serveur minimaliste
==============================================

Sert :
  • GET  /           → landing/index.html
  • GET  /app        → Redirige vers la PWA Flutter (build/web/)
  • POST /api/feedback → Crée une issue GitHub (comme UPassport)
  • Fichiers statiques (assets landing)

Usage :
    python server.py
    # ou avec uvicorn :
    uvicorn server:app --host 0.0.0.0 --port 8080 --reload

Variables d'environnement (.env) :
    GITHUB_TOKEN    = ghp_xxxxxxxx    (token GitHub, scope: repo)
    GITHUB_REPO     = papiche/zelkova (org/repo pour les issues)
    ZELKOVA_APP_URL = https://zelkova.astroport.one  (URL de la PWA)
    PORT            = 8080

Nécessite : pip install fastapi uvicorn python-dotenv httpx aiofiles
"""

import os
import json
import logging
from pathlib import Path
from datetime import datetime
from typing import Optional

import httpx
from dotenv import load_dotenv
from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import HTMLResponse, FileResponse, RedirectResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

# ── Chargement .env ───────────────────────────────────────────────────────────
load_dotenv()
load_dotenv(Path(__file__).parent.parent / ".env")   # Zelkova root .env

GITHUB_TOKEN   = os.getenv("GITHUB_TOKEN", "")
GITHUB_REPO    = os.getenv("GITHUB_REPO", "papiche/zelkova")
ZELKOVA_APP_URL = os.getenv("ZELKOVA_APP_URL", "")
UPASSPORT_URL  = os.getenv("UPASSPORT_URL", "https://u.copylaradio.com")

LANDING_DIR = Path(__file__).parent          # zelkova/landing/
ROOT_DIR    = LANDING_DIR.parent             # zelkova/
APP_DIR     = ROOT_DIR / "build" / "web"    # Flutter PWA

# ── Logging ───────────────────────────────────────────────────────────────────
logging.basicConfig(level=logging.INFO, format="%(asctime)s  %(levelname)s  %(message)s")
logger = logging.getLogger("zelkova-landing")

# ── FastAPI ───────────────────────────────────────────────────────────────────
app = FastAPI(
    title="Ẑelkova Landing",
    description="Serveur landing + /api/feedback pour Ẑelkova",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["GET", "POST", "OPTIONS"],
    allow_headers=["*"],
)

# ── Statiques landing (CSS, images…) ─────────────────────────────────────────
if (LANDING_DIR / "static").exists():
    app.mount("/static", StaticFiles(directory=LANDING_DIR / "static"), name="static")

# ── PWA Flutter (si buildée) ──────────────────────────────────────────────────
if APP_DIR.exists():
    app.mount("/app", StaticFiles(directory=APP_DIR, html=True), name="pwa")

# ── Modèle feedback ───────────────────────────────────────────────────────────
class FeedbackPayload(BaseModel):
    type: str          # bug | feature | feedback | question
    title: str
    description: str
    platform: Optional[str]    = "web"
    app_version: Optional[str] = "zelkova"
    user_g1pub: Optional[str]  = ""
    user_npub: Optional[str]   = ""
    user_npub_bech32: Optional[str] = ""
    user_display_name: Optional[str] = "Anonyme"
    # email omis volontairement côté landing


# ── Routes ────────────────────────────────────────────────────────────────────

@app.get("/", response_class=HTMLResponse)
async def landing():
    """Page de présentation Ẑelkova."""
    index = LANDING_DIR / "index.html"
    if not index.exists():
        return HTMLResponse("<h1>Ẑelkova</h1><p>Page de landing manquante.</p>")
    return HTMLResponse(index.read_text(encoding="utf-8"))


@app.get("/app")
async def redirect_to_pwa():
    """Redirige vers la PWA Flutter ou l'URL externe."""
    if APP_DIR.exists():
        return RedirectResponse(url="/app/")
    if ZELKOVA_APP_URL:
        return RedirectResponse(url=ZELKOVA_APP_URL)
    return JSONResponse({"error": "PWA non déployée"}, status_code=404)


@app.get("/health")
async def health():
    return {"status": "ok", "app": "zelkova-landing", "time": datetime.utcnow().isoformat()}


@app.post("/api/feedback")
async def create_feedback(payload: FeedbackPayload, request: Request):
    """
    Crée une issue GitHub depuis le formulaire de feedback.

    Équivalent light de l'endpoint /api/feedback d'UPassport.
    - Si GITHUB_TOKEN est configuré → crée une issue GitHub directement
    - Sinon → relaie vers UPASSPORT_URL/api/feedback (fallback)
    """
    logger.info(f"[feedback] type={payload.type} title={payload.title[:60]}")

    # ── Construire le corps de l'issue ────────────────────────────────────────
    body = _build_issue_body(payload, request)

    # ── Tentative GitHub direct ───────────────────────────────────────────────
    if GITHUB_TOKEN:
        result = await _create_github_issue(payload, body)
        if result.get("success"):
            return JSONResponse(result, status_code=201)
        # Si GitHub échoue, on passe au fallback UPassport
        logger.warning(f"[feedback] GitHub failed: {result.get('error')}, trying UPassport fallback")

    # ── Fallback : relai vers UPassport ──────────────────────────────────────
    if UPASSPORT_URL:
        result = await _relay_to_upassport(payload, body)
        if result.get("success"):
            return JSONResponse(result, status_code=201)

    # ── Erreur finale ─────────────────────────────────────────────────────────
    logger.error("[feedback] all channels failed")
    raise HTTPException(
        status_code=502,
        detail="Impossible de soumettre le feedback. Configurez GITHUB_TOKEN ou UPASSPORT_URL.",
    )


# ── Helpers ───────────────────────────────────────────────────────────────────

def _build_issue_body(p: FeedbackPayload, request: Request) -> str:
    """Construit le corps Markdown de l'issue."""
    type_emoji = {"bug": "🐛", "feature": "✨", "question": "❓", "praise": "👍"}.get(p.type, "📝")
    lines = [
        f"## {type_emoji} {p.title}",
        "",
        "---",
        "### Identifiants utilisateur",
        f"- **G1PUB**: `{p.user_g1pub or 'anonyme'}`",
        f"- **NOSTR npub (hex)**: `{p.user_npub or 'N/A'}`",
        f"- **NOSTR npub (bech32)**: `{p.user_npub_bech32 or 'N/A'}`",
        f"- **Nom**: {p.user_display_name or 'Anonyme'}",
        "---",
        "",
        "### Description",
        p.description,
        "",
        "---",
        "### Métadonnées",
        f"- **Type**: `{p.type}`",
        f"- **Plateforme**: `{p.platform}`",
        f"- **Version**: `{p.app_version}`",
        f"- **IP**: `{request.client.host if request.client else 'N/A'}`",
        f"- **Date**: `{datetime.utcnow().isoformat()}Z`",
        "",
        "*Soumis via Ẑelkova landing — [github.com/papiche/zelkova](https://github.com/papiche/zelkova)*",
    ]
    return "\n".join(lines)


async def _create_github_issue(p: FeedbackPayload, body: str) -> dict:
    """Crée une issue dans le dépôt GitHub via l'API."""
    url = f"https://api.github.com/repos/{GITHUB_REPO}/issues"
    labels = ["feedback", p.type]
    payload = {
        "title": f"[{p.type.upper()}] {p.title[:100]}",
        "body": body,
        "labels": labels,
    }
    headers = {
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    try:
        async with httpx.AsyncClient(timeout=15) as client:
            resp = await client.post(url, json=payload, headers=headers)

        if resp.status_code in (200, 201):
            data = resp.json()
            logger.info(f"[feedback] GitHub issue #{data.get('number')} created")
            return {
                "success": True,
                "issue_number": data.get("number"),
                "issue_url": data.get("html_url"),
                "message": f"Issue #{data.get('number')} créée sur GitHub",
            }
        else:
            err = resp.json().get("message", resp.text[:200])
            logger.error(f"[feedback] GitHub API error {resp.status_code}: {err}")
            return {"success": False, "error": f"GitHub {resp.status_code}: {err}"}

    except Exception as exc:
        logger.error(f"[feedback] GitHub exception: {exc}")
        return {"success": False, "error": str(exc)}


async def _relay_to_upassport(p: FeedbackPayload, body: str) -> dict:
    """Relaie le feedback vers l'endpoint /api/feedback d'UPassport."""
    url = f"{UPASSPORT_URL}/api/feedback"
    relay_payload = {
        "type": p.type,
        "title": p.title,
        "description": body,          # version enrichie
        "email": "anonymous",
        "app_version": p.app_version,
        "platform": p.platform,
        "user_g1pub": p.user_g1pub,
        "user_npub": p.user_npub,
        "user_npub_bech32": p.user_npub_bech32,
        "user_display_name": p.user_display_name,
    }
    try:
        async with httpx.AsyncClient(timeout=15) as client:
            resp = await client.post(url, json=relay_payload)

        if resp.status_code in (200, 201):
            data = resp.json()
            logger.info(f"[feedback] relayed to UPassport: {data}")
            return {
                "success": True,
                "issue_number": data.get("issue_number"),
                "issue_url": data.get("issue_url"),
                "message": data.get("message", "Feedback transmis via UPassport"),
            }
        else:
            return {"success": False, "error": f"UPassport {resp.status_code}"}

    except Exception as exc:
        logger.error(f"[feedback] UPassport relay exception: {exc}")
        return {"success": False, "error": str(exc)}


# ── Entrée principale ─────────────────────────────────────────────────────────
if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", 8080))
    logger.info(f"🌳 Ẑelkova Landing → http://0.0.0.0:{port}")
    logger.info(f"   GitHub repo : {GITHUB_REPO}")
    logger.info(f"   UPassport   : {UPASSPORT_URL}")
    logger.info(f"   PWA builded : {APP_DIR.exists()}")
    uvicorn.run("server:app", host="0.0.0.0", port=port, reload=True)
