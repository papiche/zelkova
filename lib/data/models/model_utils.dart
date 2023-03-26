import 'dart:convert';
import 'dart:typed_data';

Uint8List? uIntFromList(dynamic value) {
  if (value is List<int> && value.isNotEmpty) {
    return Uint8List.fromList(value);
  } else if (value is String && value.isNotEmpty) {
    return base64Decode(value);
  } else {
    return null;
  }
}

List<int> uIntToList(Uint8List? uInt8List) =>
    uInt8List != null ? uInt8List.toList() : <int>[];
