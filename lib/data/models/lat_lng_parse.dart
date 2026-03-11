import 'package:latlong2/latlong.dart';

extension LatLngParsing on LatLng {
  static LatLng parse(String latLngString) {
    final String cleanedString =
        latLngString.replaceAll('(', '').replaceAll(')', '');
    final List<String> parts = cleanedString.split(',');

    final double latitude = double.parse(parts[0].trim());
    final double longitude = double.parse(parts[1].trim());
    return LatLng(latitude, longitude);
  }
}
