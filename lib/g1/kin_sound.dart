import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

import 'phi2x.dart';

// ── Constantes audio ──────────────────────────────────────────────────────────

const int _sampleRate = 22050;
const int _durationSec = 7;
const int _numSamples = _sampleRate * _durationSec;

// ── Génération WAV ────────────────────────────────────────────────────────────

/// Génère un WAV PCM mono 16-bit 22050 Hz — signature sonore personnelle.
///
/// Port de AudioOrchestra.playProfile() de audio_orchestra.js :
///   - [weightKg]  : poids de naissance (défaut 3.5 kg)
///   - [polarity]  : 0 = PHI-wave (masculin), 1 = Octave-wave (féminin)
///   - [toneNumber]: numéro de tonalité KIN (1–13), détermine le LFO
///
/// Fréquence fondamentale : phi2xToAudible(phi2xComputeOmegaBio(weight, polarity))
/// LFO : toneNumber × 0.15 Hz (conforme phi2x.js lfoHz = (ti+1)*0.15)
Uint8List generateKinWav(int toneNumber, int polarity, double weightKg) {
  final double omegaBio = phi2xComputeOmegaBio(weightKg, polarity);
  final double freqF    = phi2xToAudible(omegaBio); // root=110.0 Hz (A2)
  final double lfoHz = toneNumber * 0.15;              // phi2x canonique

  final List<int> pcm = List<int>.filled(_numSamples, 0);
  for (int i = 0; i < _numSamples; i++) {
    final double t   = i / _sampleRate;
    final double lfo = 1.0 + 0.28 * sin(2 * pi * lfoHz * t);

    double s = sin(2 * pi * freqF * t) * lfo;

    if (polarity == 0) {
      // PHI-wave (masculin) : fondamentale + PHI + quinte
      s += 0.45 * sin(2 * pi * freqF * phi2xPhi * t) * lfo;
      s += 0.25 * sin(2 * pi * freqF * 1.5 * t);
    } else {
      // Octave-wave (féminin) : fondamentale + octave + double octave
      s += 0.35 * sin(2 * pi * freqF * 2.0 * t) * lfo;
      s += 0.15 * sin(2 * pi * freqF * 4.0 * t);
    }

    // Enveloppe : fade-in 1.5 s, fade-out 1.5 s
    double env = 1.0;
    if (t < 1.5) {
      env = t / 1.5;
    } else if (t > 5.5) {
      env = (7.0 - t) / 1.5;
    }
    if (env < 0.0) {
      env = 0.0;
    }
    if (env > 1.0) {
      env = 1.0;
    }

    pcm[i] = (s * env * 0.28 * 32767).round().clamp(-32768, 32767);
  }

  return _buildWav(pcm);
}

Uint8List _buildWav(List<int> samples) {
  final int dataSize = samples.length * 2;
  final Uint8List buf = Uint8List(44 + dataSize);
  final ByteData bd   = buf.buffer.asByteData();

  // RIFF header
  bd.setUint32(0,  0x52494646);              // "RIFF"
  bd.setUint32(4,  36 + dataSize, Endian.little);
  bd.setUint32(8,  0x57415645);              // "WAVE"
  // fmt chunk
  bd.setUint32(12, 0x666d7420);              // "fmt "
  bd.setUint32(16, 16, Endian.little);
  bd.setUint16(20, 1,  Endian.little);       // PCM
  bd.setUint16(22, 1,  Endian.little);       // mono
  bd.setUint32(24, _sampleRate, Endian.little);
  bd.setUint32(28, _sampleRate * 2, Endian.little);
  bd.setUint16(32, 2,  Endian.little);       // block align
  bd.setUint16(34, 16, Endian.little);       // bits/sample
  // data chunk
  bd.setUint32(36, 0x64617461);              // "data"
  bd.setUint32(40, dataSize, Endian.little);

  int offset = 44;
  for (final int s in samples) {
    bd.setInt16(offset, s, Endian.little);
    offset += 2;
  }
  return buf;
}

// ── Lecteur ───────────────────────────────────────────────────────────────────

/// Joue la signature sonore personnelle du KIN.
/// Retourne l'[AudioPlayer] actif (à disposer après usage).
Future<AudioPlayer> playKinSound(
    int toneNumber, int polarity, double weightKg) async {
  final Uint8List wav = generateKinWav(toneNumber, polarity, weightKg);
  final AudioPlayer player = AudioPlayer();
  await player.play(BytesSource(wav, mimeType: 'audio/wav'));
  return player;
}
