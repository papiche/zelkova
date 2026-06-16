import 'dart:math';

import 'package:flutter/material.dart';

// ── Données géométriques (calculées une fois au premier accès) ────────────────

class _GeoData {
  const _GeoData(this.verts, this.edges);
  final List<List<double>> verts; // vertices normalisés [x,y,z]
  final List<List<int>> edges;    // paires d'indices
}

// Icosaèdre normalisé sur la sphère unité — 12 sommets
const List<List<double>> _icoV = <List<double>>[
  <double>[ 0.000,  0.000,  1.000],
  <double>[ 0.894,  0.000,  0.447],
  <double>[ 0.276,  0.851,  0.447],
  <double>[-0.724,  0.526,  0.447],
  <double>[-0.724, -0.526,  0.447],
  <double>[ 0.276, -0.851,  0.447],
  <double>[ 0.724,  0.526, -0.447],
  <double>[-0.276,  0.851, -0.447],
  <double>[-0.894,  0.000, -0.447],
  <double>[-0.276, -0.851, -0.447],
  <double>[ 0.724, -0.526, -0.447],
  <double>[ 0.000,  0.000, -1.000],
];

// 20 faces de l'icosaèdre (indices de sommets)
const List<List<int>> _icoF = <List<int>>[
  <int>[0, 1, 2], <int>[0, 2, 3], <int>[0, 3, 4], <int>[0, 4, 5], <int>[0, 5, 1],
  <int>[1, 6, 2], <int>[2, 6, 7], <int>[2, 7, 3], <int>[3, 7, 8], <int>[3, 8, 4],
  <int>[4, 8, 9], <int>[4, 9, 5], <int>[5, 9,10], <int>[5,10, 1], <int>[1,10, 6],
  <int>[11,7, 6], <int>[11,8, 7], <int>[11,9, 8], <int>[11,10,9], <int>[11,6,10],
];

/// Construit la sphère géodésique de fréquence 2 :
/// chaque arête de l'icosaèdre est divisée par son milieu normalisé sur la sphère.
/// Résultat : 42 sommets, 120 arêtes — aspect "Goldberg GP(1,1)".
_GeoData _buildGeodesic() {
  final List<List<double>> verts =
      _icoV.map((List<double> v) => List<double>.from(v)).toList();
  final Map<String, int> midCache = <String, int>{};

  int getMid(int a, int b) {
    final String key = a < b ? '${a}_$b' : '${b}_$a';
    if (midCache.containsKey(key)) {
      return midCache[key]!;
    }
    final List<double> m = <double>[
      (verts[a][0] + verts[b][0]) / 2,
      (verts[a][1] + verts[b][1]) / 2,
      (verts[a][2] + verts[b][2]) / 2,
    ];
    final double n = sqrt(m[0] * m[0] + m[1] * m[1] + m[2] * m[2]);
    verts.add(<double>[m[0] / n, m[1] / n, m[2] / n]);
    return midCache[key] = verts.length - 1;
  }

  final Set<String> edgeSet = <String>{};
  void addEdge(int a, int b) {
    if (a > b) {
      final int t = a;
      a = b;
      b = t;
    }
    edgeSet.add('${a}_$b');
  }

  for (final List<int> f in _icoF) {
    final int ab = getMid(f[0], f[1]);
    final int bc = getMid(f[1], f[2]);
    final int ca = getMid(f[2], f[0]);
    addEdge(f[0], ab); addEdge(ab, f[1]);
    addEdge(f[1], bc); addEdge(bc, f[2]);
    addEdge(f[2], ca); addEdge(ca, f[0]);
    addEdge(ab, bc); addEdge(bc, ca); addEdge(ca, ab);
  }

  final List<List<int>> edges = edgeSet.map((String k) {
    final List<String> parts = k.split('_');
    return <int>[int.parse(parts[0]), int.parse(parts[1])];
  }).toList();

  return _GeoData(verts, edges);
}

// Instance unique, initialisée paresseusement
final _GeoData _geo = _buildGeodesic();

// ── Widget public ─────────────────────────────────────────────────────────────

/// Sphère de Goldberg animée (wireframe 3D, rendu CustomPainter).
/// Les 12 sommets originaux de l'icosaèdre correspondent aux 12 pentagones
/// du polyèdre de Goldberg — identiques à phi2xPentagonsGps de phi2x.dart.
class GoldbergSphere extends StatefulWidget {
  const GoldbergSphere({
    super.key,
    this.size = 220,
    this.color,
    this.durationSeconds = 18,
  });

  final double size;
  final Color? color;
  final int durationSeconds;

  @override
  State<GoldbergSphere> createState() => _GoldbergSphereState();
}

class _GoldbergSphereState extends State<GoldbergSphere>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color c =
        widget.color ?? Theme.of(context).colorScheme.primary;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _GoldbergPainter(t: _ctrl.value, primaryColor: c),
      ),
    );
  }
}

// ── Painter ───────────────────────────────────────────────────────────────────

class _GoldbergPainter extends CustomPainter {
  _GoldbergPainter({required this.t, required this.primaryColor});

  final double t;
  final Color primaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r  = size.shortestSide * 0.44;

    // Angles de rotation
    final double ry = t * 2 * pi;                // spin Y continu
    const double rx = 0.35;                      // inclinaison fixe ~20°
    final double rz = sin(t * pi * 0.4) * 0.12; // léger tangage Z

    final double cY = cos(ry), sY = sin(ry);
    final double cX = cos(rx), sX = sin(rx);
    final double cZ = cos(rz), sZ = sin(rz);

    // Projection perspective de chaque sommet
    final List<List<double>> proj =
        _geo.verts.map((List<double> v) {
      final double x = v[0], y = v[1], z = v[2];

      // Rotation Y
      final double x1 =  x * cY + z * sY;
      final double z1 = -x * sY + z * cY;

      // Rotation X
      final double y2 =  y * cX - z1 * sX;
      final double z2 =  y * sX + z1 * cX;

      // Rotation Z (wobble)
      final double x3 =  x1 * cZ - y2 * sZ;
      final double y3 =  x1 * sZ + y2 * cZ;

      // Projection perspective (fov=3)
      const double fov   = 3.0;
      final double scale = fov / (fov + z2 + 0.1);

      return <double>[x3 * r * scale + cx, y3 * r * scale + cy, z2];
    }).toList();

    // Tri des arêtes du fond vers l'avant pour le painter's algorithm
    final List<List<int>> sorted = List<List<int>>.from(_geo.edges)
      ..sort((List<int> a, List<int> b) {
        final double za = (proj[a[0]][2] + proj[a[1]][2]) / 2;
        final double zb = (proj[b[0]][2] + proj[b[1]][2]) / 2;
        return za.compareTo(zb); // back first
      });

    final Paint linePaint = Paint()..style = PaintingStyle.stroke;

    for (final List<int> e in sorted) {
      final List<double> a = proj[e[0]];
      final List<double> b = proj[e[1]];
      final double depth = ((a[2] + b[2]) / 2 + 1) / 2; // [0,1]

      linePaint
        ..color = primaryColor.withValues(alpha: 0.06 + depth * 0.74)
        ..strokeWidth = 0.35 + depth * 0.9;

      canvas.drawLine(Offset(a[0], a[1]), Offset(b[0], b[1]), linePaint);
    }

    // Sommets — les 12 pentagones (sommets originaux de l'icosaèdre) en relief
    final Paint dotPaint = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < 12; i++) {
      final List<double> p = proj[i];
      final double depth = (p[2] + 1) / 2;
      if (depth < 0.15) {
        continue; // face arrière invisible
      }
      dotPaint.color = primaryColor.withValues(alpha: depth * 0.85);
      canvas.drawCircle(Offset(p[0], p[1]), 1.0 + depth * 2.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_GoldbergPainter old) => old.t != t || old.primaryColor != primaryColor;
}

// ── Écran de chargement complet ───────────────────────────────────────────────

/// Splash plein écran affiché pendant l'initialisation de l'application.
class GoldbergSplash extends StatelessWidget {
  const GoldbergSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs  = Theme.of(context).colorScheme;
    final Size screen     = MediaQuery.sizeOf(context);
    final double sphereD  = (screen.shortestSide * 0.62).clamp(180, 340);

    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GoldbergSphere(
              size: sphereD,
              color: cs.primary,
            ),
            const SizedBox(height: 28),
            Text(
              'Ẑelkova',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: cs.onSurface.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                backgroundColor: cs.onSurface.withValues(alpha: 0.08),
                color: cs.primary.withValues(alpha: 0.5),
                minHeight: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
