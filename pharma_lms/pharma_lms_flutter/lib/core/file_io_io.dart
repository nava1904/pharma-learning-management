import 'dart:io';

Future<List<int>> readFileBytes(String path) async {
  return File(path).readAsBytes();
}

Stream<List<int>> openReadStream(String path) {
  return File(path).openRead();
}
