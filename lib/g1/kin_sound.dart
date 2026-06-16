import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

import 'kin_calculator.dart';

// ── Constantes ────────────────────────────────────────────────────────────────

const double _phi  = 1.6180339887;
const int _sampleRate = 22050;
const int _durationSec = 7;

// ── Génération WAV ────────────────────────────────────────────────────────────

/// Génère un fichier WAV PCM mono 16-bit 22050 Hz.
/// Signature sonore personnelle basée sur le KIN tone et la polarité.
/// Port de `AudioOrchestra.playProfile()` de audio_orchestra.js.
Uint8List generateKinWav(int kinTone, int polarity) {
  final double omegaBio  = computeOmegaBio(kinTone, polarity);
  final double lfoHz     = kinTone / 13.0;
  const int numSamples   = _sampleRate * _durationSec;

  final List<int> pcm = List<int>.filled(numSamples, 0);
  for (int i = 0; i < numSamples; i++) {
    final double t   = i / _sampleRate;
    final double lfo = 1.0 + 0.28 * sin(2 * pi * lfoHz * t);

    double s = sin(2 * pi * omegaBio * t) * lfo;

    if (polarity == 0) {
      // Onde Phi (masculin) : fondamentale + PHI + quinte
      s += 0.45 * sin(2 * pi * omegaBio * _phi * t) * lfo;
      s += 0.25 * sin(2 * pi * omegaBio * 1.5 * t);
    } else {
      // Onde octave (féminin) : fondamentale + octave + double octave
      s += 0.35 * sin(2 * pi * omegaBio * 2.0 * t) * lfo;
      s += 0.15 * sin(2 * pi * omegaBio * 4.0 * t);
    }

    // Enveloppe : fade-in 1.5 s, fade-out 1.5 s
    final double env = _clamp((t < 1.5) ? t / 1.5 : (t > 5.5) ? (7.0 - t) / 1.5 : 1.0);
    pcm[i] = (s * env * 0.28 * 32767).round().clamp(-32768, 32767);
  }

  return _buildWav(pcm);
}

double _clamp(double v) => v < 0.0 ? 0.0 : (v > 1.0 ? 1.0 : v);

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
Future<AudioPlayer> playKinSound(int kinTone, int polarity) async {
  final Uint8List wav = generateKinWav(kinTone, polarity);
  final AudioPlayer player = AudioPlayer();
  await player.play(BytesSource(wav, mimeType: 'audio/wav'));
  return player;
}
