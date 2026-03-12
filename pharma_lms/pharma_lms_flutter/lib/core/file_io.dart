import 'file_io_stub.dart'
    if (dart.library.io) 'file_io_io.dart' as impl;

Future<List<int>> readFileBytes(String path) => impl.readFileBytes(path);

/// Returns a stream for reading file in chunks (mobile/desktop only).
/// On web, returns null - use PlatformFile.readStream instead.
Stream<List<int>>? openReadStream(String path) => impl.openReadStream(path);
