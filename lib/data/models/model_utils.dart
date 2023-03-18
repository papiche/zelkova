import 'dart:typed_data';

Uint8List uIntFromList(List<int> list) => Uint8List.fromList(list);

List<int> uIntToList(Uint8List? uInt8List) =>
    uInt8List != null ? uInt8List.toList() : <int>[];
