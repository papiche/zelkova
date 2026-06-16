import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

// ── Résultat sélection ────────────────────────────────────────────────────────

class LocationPickerResult {
  const LocationPickerResult({
    required this.lat,
    required this.lon,
    required this.name,
  });
  final double lat;
  final double lon;
  final String name;

  String get a4lCode =>
      '${lat.toStringAsFixed(2)}_${lon.toStringAsFixed(2)}';
}

// ── Entrée publique ───────────────────────────────────────────────────────────

/// Ouvre le sélecteur de position en bottom sheet.
/// Retourne null si annulé.
Future<LocationPickerResult?> showLocationPicker({
  required BuildContext context,
  double initialLat = 46.5,
  double initialLon = 2.0,
  String title = 'Choisir une position',
}) {
  return showModalBottomSheet<LocationPickerResult>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext ctx) => SizedBox(
      height: MediaQuery.of(ctx).size.height * 0.88,
      child: _LocationPickerSheet(
        initialLat: initialLat,
        initialLon: initialLon,
        title: title,
      ),
    ),
  );
}

// ── Widget interne ────────────────────────────────────────────────────────────

class _LocationPickerSheet extends StatefulWidget {
  const _LocationPickerSheet({
    required this.initialLat,
    required this.initialLon,
    required this.title,
  });

  final double initialLat;
  final double initialLon;
  final String title;

  @override
  State<_LocationPickerSheet> createState() => _LocationPickerSheetState();
}

class _LocationPickerSheetState extends State<_LocationPickerSheet> {
  late double _lat;
  late double _lon;
  String _name = '';
  bool _searchLoading = false;
  bool _reverseLoading = false;
  final TextEditingController _searchCtrl = TextEditingController();
  final MapController _mapCtrl = MapController();
  List<_SearchResult> _suggestions = <_SearchResult>[];

  @override
  void initState() {
    super.initState();
    final bool hasInitial =
        widget.initialLat != 0.0 || widget.initialLon != 0.0;
    _lat = hasInitial ? widget.initialLat : 46.5;
    _lon = hasInitial ? widget.initialLon : 2.0;
    if (hasInitial) _reverseGeocode(_lat, _lon);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ── A4L helpers ────────────────────────────────────────────────────────────

  double get _lat2d => ((_lat * 100).round()) / 100.0;
  double get _lon2d => ((_lon * 100).round()) / 100.0;
  String get _a4lCode =>
      '${_lat2d.toStringAsFixed(2)}_${_lon2d.toStringAsFixed(2)}';

  List<LatLng> get _a4lCell => <LatLng>[
        LatLng(_lat2d, _lon2d),
        LatLng(_lat2d + 0.01, _lon2d),
        LatLng(_lat2d + 0.01, _lon2d + 0.01),
        LatLng(_lat2d, _lon2d + 0.01),
      ];

  // ── Geocoding ──────────────────────────────────────────────────────────────

  Future<void> _reverseGeocode(double lat, double lon) async {
    if (!mounted) return;
    setState(() => _reverseLoading = true);
    try {
      final Uri uri = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse'
        '?lat=$lat&lon=$lon&format=json&accept-language=fr',
      );
      final http.Response r = await http.get(uri, headers: <String, String>{
        'User-Agent': 'Zelkova/1.0 UPlanet support@qo-op.com',
      }).timeout(const Duration(seconds: 5));
      if (r.statusCode == 200 && mounted) {
        final Map<String, dynamic> data =
            jsonDecode(r.body) as Map<String, dynamic>;
        final String raw = data['display_name'] as String? ?? '';
        final List<String> parts = raw.split(', ');
        setState(() => _name = parts.take(3).join(', '));
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _reverseLoading = false);
    }
  }

  Future<void> _search(String query) async {
    if (query.trim().length < 3) {
      setState(() => _suggestions = <_SearchResult>[]);
      return;
    }
    setState(() => _searchLoading = true);
    try {
      final Uri uri = Uri.parse(
        'https://nominatim.openstreetmap.org/search'
        '?q=${Uri.encodeComponent(query.trim())}'
        '&format=json&limit=5&accept-language=fr',
      );
      final http.Response r = await http.get(uri, headers: <String, String>{
        'User-Agent': 'Zelkova/1.0 UPlanet support@qo-op.com',
      }).timeout(const Duration(seconds: 6));
      if (r.statusCode == 200 && mounted) {
        final List<dynamic> data = jsonDecode(r.body) as List<dynamic>;
        setState(() {
          _suggestions = data.map((dynamic e) {
            final Map<String, dynamic> m = e as Map<String, dynamic>;
            final List<String> parts =
                (m['display_name'] as String).split(', ');
            return _SearchResult(
              name: parts.take(3).join(', '),
              lat: double.parse(m['lat'] as String),
              lon: double.parse(m['lon'] as String),
            );
          }).toList();
        });
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _searchLoading = false);
    }
  }

  void _selectResult(_SearchResult result) {
    setState(() {
      _lat = result.lat;
      _lon = result.lon;
      _name = result.name;
      _suggestions = <_SearchResult>[];
      _searchCtrl.text = result.name;
    });
    _mapCtrl.move(LatLng(_lat, _lon), 13);
    FocusScope.of(context).unfocus();
  }

  void _onMapTap(TapPosition _, LatLng latlng) {
    setState(() {
      _lat = latlng.latitude;
      _lon = latlng.longitude;
      _name = '';
      _suggestions = <_SearchResult>[];
    });
    _reverseGeocode(_lat, _lon);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Column(
      children: <Widget>[
        // ── Poignée ──────────────────────────────────────────────────────────
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: cs.onSurface.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // ── Titre ────────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),

        // ── Barre de recherche ────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Rechercher une ville…',
                  prefixIcon: _searchLoading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _suggestions = <_SearchResult>[]);
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: _search,
              ),
              // ── Suggestions ───────────────────────────────────────────────
              if (_suggestions.isNotEmpty)
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _suggestions.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 16),
                    itemBuilder: (BuildContext ctx, int i) {
                      final _SearchResult r = _suggestions[i];
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.place_outlined, size: 18),
                        title: Text(r.name,
                            style: const TextStyle(fontSize: 13)),
                        subtitle: Text(
                          '${r.lat.toStringAsFixed(2)}°, '
                          '${r.lon.toStringAsFixed(2)}°',
                          style: const TextStyle(fontSize: 11),
                        ),
                        onTap: () => _selectResult(r),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),

        // ── Carte ─────────────────────────────────────────────────────────────
        Expanded(
          child: Stack(
            children: <Widget>[
              FlutterMap(
                mapController: _mapCtrl,
                options: MapOptions(
                  initialCenter: LatLng(_lat, _lon),
                  initialZoom:
                      (_lat == 46.5 && _lon == 2.0) ? 5.0 : 12.0,
                  onTap: _onMapTap,
                ),
                children: <Widget>[
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.zelkova.app',
                  ),
                  // Cellule A4L (0.01° × 0.01°)
                  PolygonLayer(
                    polygons: <Polygon>[
                      Polygon(
                        points: _a4lCell,
                        color: Colors.green.withValues(alpha: 0.18),
                        borderStrokeWidth: 2.5,
                        borderColor: Colors.green.shade700,
                      ),
                    ],
                  ),
                  // Marqueur position
                  MarkerLayer(
                    markers: <Marker>[
                      Marker(
                        point: LatLng(_lat, _lon),
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 38,
                          shadows: <Shadow>[
                            Shadow(blurRadius: 4, color: Colors.black38),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Badge A4L
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '⬡ $_a4lCode',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              // Coordonnées brutes
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${_lat.toStringAsFixed(4)}°N  '
                    '${_lon.toStringAsFixed(4)}°E',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),

              // Indicateur reverse geocode
              if (_reverseLoading)
                const Positioned(
                  top: 8,
                  left: 8,
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),

        // ── Résumé + bouton confirmer ─────────────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(
              16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_name.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.place, size: 15, color: cs.primary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _name,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(
                  LocationPickerResult(
                    lat: _lat2d,
                    lon: _lon2d,
                    name: _name.isNotEmpty
                        ? _name
                        : '${_lat2d.toStringAsFixed(2)}°, '
                            '${_lon2d.toStringAsFixed(2)}°',
                  ),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Confirmer cette position'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Données internes ──────────────────────────────────────────────────────────

class _SearchResult {
  const _SearchResult({required this.name, required this.lat, required this.lon});
  final String name;
  final double lat;
  final double lon;
}
