// Platform-aware file download: web uses Blob/download, others use FilePicker.
import 'dart:typed_data';

import 'file_download_stub.dart'
    if (dart.library.html) 'file_download_web.dart' as impl;

/// Saves [bytes] with suggested [fileName].
/// On web: triggers browser download.
/// On iOS/Android/Desktop: opens save dialog via FilePicker.
/// Returns true if save was triggered/completed, false if cancelled (non-web only).
Future<bool> saveBytesToFile(Uint8List bytes, String fileName) async {
  return impl.saveBytesToFile(bytes, fileName);
}
