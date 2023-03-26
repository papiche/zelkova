import 'dart:typed_data';

Uint8List? uIntFromList(dynamic value) {
  if (value is List<int> && value.isNotEmpty) {
    return Uint8List.fromList(value);
  } else if (value is List<dynamic> && value.isNotEmpty) {
    return Uint8List.fromList(value.map((dynamic e) => e as int).toList());
  } else {
    return null;
  }
}

List<int> uIntToList(Uint8List? uInt8List) =>
    uInt8List != null ? uInt8List.toList() : <int>[];
