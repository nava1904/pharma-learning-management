import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' as pharma;
import 'package:serverpod_client/serverpod_client.dart';

import '../../core/client.dart';
import '../../core/file_io.dart';
import '../../design_system/colors.dart';
import '../../design_system/spacing.dart';

/// Max file size before warning (100MB).
const _maxFileSizeBytes = 100 * 1024 * 1024;

/// Material upload: drag-drop zone, type chips, preview thumbnail.
class MaterialUploadScreen extends StatefulWidget {
  const MaterialUploadScreen({
    super.key,
    this.organizationId = 1,
  });

  final int organizationId;

  @override
  State<MaterialUploadScreen> createState() => _MaterialUploadScreenState();
}

class _MaterialUploadScreenState extends State<MaterialUploadScreen> {
  List<pharma.Material> _materials = [];
  bool _loading = true;
  String? _error;
  String _selectedType = 'pdf';
  PlatformFile? _previewFile;

  static const _allowedExtensions = ['pdf', 'doc', 'docx', 'mp4', 'webm', 'zip'];
  static const _typeChips = ['PDF', 'Video', 'SCORM'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final materials = await client.material.listMaterials(
        organizationId: widget.organizationId,
      );
      setState(() {
        _materials = materials;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  String _typeToExtension() {
    switch (_selectedType.toLowerCase()) {
      case 'video':
        return 'mp4';
      case 'scorm':
        return 'zip';
      default:
        return 'pdf';
    }
  }

  List<String> _extensionsForType() {
    switch (_selectedType.toLowerCase()) {
      case 'video':
        return ['mp4', 'webm'];
      case 'scorm':
        return ['zip'];
      default:
        return ['pdf', 'doc', 'docx'];
    }
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _extensionsForType(),
      withData: false,
      withReadStream: kIsWeb,
    );
    if (result == null || result.files.isEmpty || !mounted) return;
    final file = result.files.first;
    if (file.size > _maxFileSizeBytes && mounted) {
      final proceed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Large file'),
          content: Text(
            'This file is ${(file.size / (1024 * 1024)).toStringAsFixed(1)} MB. '
            'Uploading files over 100MB may be slow or cause issues. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
      if (proceed != true || !mounted) return;
    }
    await _processFile(file);
  }

  Future<void> _processFile(PlatformFile file) async {
    setState(() => _previewFile = file);

    final title = file.name;
    try {
      final material = await client.material.createMaterial(
        title: title,
        materialType: _selectedType.toLowerCase(),
        organizationId: widget.organizationId,
      );
      if (!mounted) return;
      await _uploadFile(material, file, file.extension ?? _typeToExtension());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _uploadFile(
    pharma.Material material,
    PlatformFile file,
    String ext,
  ) async {
    final path = 'materials/${material.id}/v1.$ext';
    try {
      final desc = await client.material.getUploadDescription(path);
      if (desc == null) throw Exception('No upload description');
      final uploader = FileUploader(desc);

      bool success;
      if (kIsWeb && file.readStream != null) {
        success = await uploader.upload(
          file.readStream!,
          file.size,
        );
      } else if (!kIsWeb && file.path != null) {
        final stream = openReadStream(file.path!);
        if (stream != null) {
          success = await uploader.upload(stream, file.size);
        } else {
          final bytes = await readFileBytes(file.path!);
          success = await uploader.uploadByteData(
            ByteData.sublistView(Uint8List.fromList(bytes)),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not read file for upload')),
          );
        }
        return;
      }

      if (!success) throw Exception('Upload failed');
      await client.material.verifyUpload(path);
      await client.material.createMaterialVersion(
        materialId: material.id!,
        storageKey: path,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload complete')),
        );
        setState(() => _previewFile = null);
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    }
  }

  Future<void> _uploadExisting(pharma.Material material) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      withData: false,
      withReadStream: kIsWeb,
    );
    if (result == null || result.files.isEmpty || !mounted) return;
    final file = result.files.first;
    await _uploadFile(material, file, file.extension ?? 'bin');
  }

  Widget _buildPreviewThumbnail() {
    if (_previewFile == null) return const SizedBox.shrink();
    final ext = (_previewFile!.extension ?? '').toLowerCase();
    final isVideo = ['mp4', 'webm'].contains(ext);
    final isPdf = ext == 'pdf';

    return Container(
      width: 120,
      height: 90,
      margin: const EdgeInsets.only(top: DesignSpacing.md),
      decoration: BoxDecoration(
        color: DesignColors.neutral100,
        borderRadius: BorderRadius.circular(DesignSpacing.sm),
        border: Border.all(color: DesignColors.neutral300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignSpacing.sm),
        child: isVideo
            ? Icon(Icons.videocam, size: 40, color: DesignColors.primary)
            : isPdf
                ? Icon(Icons.picture_as_pdf, size: 40, color: DesignColors.danger)
                : Icon(Icons.folder_zip, size: 40, color: DesignColors.warning),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Materials'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!),
                      const SizedBox(height: DesignSpacing.md),
                      FilledButton(
                        onPressed: _load,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(DesignSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Type selector chips
                        Text(
                          'Material Type',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: DesignColors.neutral600,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: DesignSpacing.sm),
                        Row(
                          children: _typeChips.map((label) {
                            final type = label.toLowerCase();
                            final isSelected = _selectedType == type;
                            return Padding(
                              padding: const EdgeInsets.only(right: DesignSpacing.sm),
                              child: FilterChip(
                                label: Text(label),
                                selected: isSelected,
                                onSelected: (_) => setState(() => _selectedType = type),
                                selectedColor: DesignColors.primary.withValues(alpha: 0.2),
                                checkmarkColor: DesignColors.primary,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: DesignSpacing.lg),
                        // Drop zone (tap to open file picker; drag-drop supported via platform)
                        GestureDetector(
                          onTap: _pickAndUpload,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              vertical: DesignSpacing.xl,
                              horizontal: DesignSpacing.lg,
                            ),
                            decoration: BoxDecoration(
                              color: DesignColors.neutral50,
                              borderRadius: BorderRadius.circular(DesignSpacing.md),
                              border: Border.all(
                                color: DesignColors.neutral300,
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 48,
                                  color: DesignColors.neutral400,
                                ),
                                const SizedBox(height: DesignSpacing.md),
                                Text(
                                  'Drag files here or tap to browse',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: DesignColors.neutral600,
                                      ),
                                ),
                                Text(
                                  _extensionsForType().join(', '),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: DesignColors.neutral500,
                                      ),
                                ),
                                _buildPreviewThumbnail(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: DesignSpacing.xl),
                        // Material list
                        Text(
                          'Materials',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: DesignSpacing.md),
                        ..._materials.map((m) => Card(
                              margin: const EdgeInsets.only(bottom: DesignSpacing.sm),
                              child: ListTile(
                                leading: Icon(
                                  _iconForType(m.materialType),
                                  color: DesignColors.primary,
                                ),
                                title: Text(m.title),
                                subtitle: Text(
                                  '${m.materialType} • ${m.storageKey ?? "No file"}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: m.storageKey == null
                                    ? FilledButton.tonal(
                                        onPressed: () => _uploadExisting(m),
                                        child: const Text('Upload'),
                                      )
                                    : null,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
    );
  }

  IconData _iconForType(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icons.videocam;
      case 'scorm':
        return Icons.quiz;
      default:
        return Icons.picture_as_pdf;
    }
  }
}
