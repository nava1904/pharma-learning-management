// Non-web: save bytes via FilePicker (iOS, Android, Desktop).
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

/// Saves [bytes] with suggested [fileName]. Returns true if user saved, false if cancelled.
Future<bool> saveBytesToFile(Uint8List bytes, String fileName) async {
  final ext = fileName.contains('.') ? [fileName.split('.').last] : <String>[];
  final path = await FilePicker.platform.saveFile(
    bytes: bytes,
    fileName: fileName,
    type: ext.isEmpty ? FileType.any : FileType.custom,
    allowedExtensions: ext,
  );
  return path != null && path.isNotEmpty;
}
