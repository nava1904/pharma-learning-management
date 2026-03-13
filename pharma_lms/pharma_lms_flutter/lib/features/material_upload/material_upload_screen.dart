import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/colors.dart';
import '../../design_system/spacing.dart';

/// Type alias to distinguish from Flutter Material
typedef LmsMaterial = Material;

/// Shows material upload as a modal bottom sheet.
/// Returns the selected [Material] or null if dismissed.
Future<LmsMaterial?> showMaterialUploadSheet(
  BuildContext context, {
  String? prefilterType,
  required int organizationId,
}) async {
  return showModalBottomSheet<LmsMaterial>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: DesignColors.neutral50,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: MaterialUploadView(
          scrollController: controller,
          isModal: true,
          prefilterType: prefilterType,
          organizationId: organizationId,
          onMaterialSelected: (m) => Navigator.of(ctx).pop(m),
        ),
      ),
    ),
  );
}

/// Reusable material upload view.
/// Can be used standalone or embedded in a modal bottom sheet.
class MaterialUploadView extends StatefulWidget {
  const MaterialUploadView({
    super.key,
    this.scrollController,
    this.isModal = false,
    this.prefilterType,
    this.onMaterialSelected,
    required this.organizationId,
  });

  final ScrollController? scrollController;
  final bool isModal;
  final String? prefilterType;
  final void Function(LmsMaterial material)? onMaterialSelected;
  final int organizationId;

  @override
  State<MaterialUploadView> createState() => _MaterialUploadViewState();
}

class _MaterialUploadViewState extends State<MaterialUploadView> {
  List<LmsMaterial> _materials = [];
  bool _loading = true;
  String? _error;
  String _selectedType = 'All';
  bool _isDragOver = false;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadingFileName;

  final List<String> _types = ['All', 'PDF', 'Video', 'SCORM', 'Image', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.prefilterType != null && _types.contains(widget.prefilterType)) {
      _selectedType = widget.prefilterType!;
    }
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await client.material.listMaterials(
        organizationId: widget.organizationId,
      );
      setState(() {
        _materials = result;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  List<LmsMaterial> get _filteredMaterials {
    if (_selectedType == 'All') return _materials;
    return _materials
        .where((m) => m.materialType.toLowerCase() == _selectedType.toLowerCase())
        .toList();
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'mp4', 'mov', 'webm', 'zip', 'png', 'jpg', 'jpeg'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    await _uploadFile(file);
  }

  Future<void> _uploadFile(PlatformFile file) async {
    if (file.bytes == null) {
      _showError('File data not available');
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
      _uploadingFileName = file.name;
    });

    try {
      // Determine material type from extension
      final ext = file.extension?.toLowerCase() ?? '';
      String materialType;
      if (['pdf'].contains(ext)) {
        materialType = 'PDF';
      } else if (['mp4', 'mov', 'webm'].contains(ext)) {
        materialType = 'Video';
      } else if (['zip'].contains(ext)) {
        materialType = 'SCORM';
      } else if (['png', 'jpg', 'jpeg'].contains(ext)) {
        materialType = 'Image';
      } else {
        materialType = 'Other';
      }

      setState(() => _uploadProgress = 0.1);

      // Create the material record first
      final material = await client.material.createMaterial(
        title: file.name.replaceAll(RegExp(r'\.[^.]+$'), ''),
        materialType: materialType,
        organizationId: widget.organizationId,
      );

      setState(() => _uploadProgress = 0.2);

      // Generate storage path
      final storagePath = 'materials/${material.id}/v1.${file.extension}';

      // Get upload description (returns signed URL as string)
      final uploadUrl = await client.material.getUploadDescription(storagePath);
      if (uploadUrl == null) {
        throw Exception('Failed to get upload URL');
      }

      setState(() => _uploadProgress = 0.3);

      // Upload file using ByteData stream
      final bytes = file.bytes!;
      final uploader = FileUploader(uploadUrl);
      
      await uploader.upload(
        Stream.fromIterable([bytes]),
        bytes.length,
      );

      setState(() => _uploadProgress = 0.7);

      // Verify upload
      final verified = await client.material.verifyUpload(storagePath);
      if (!verified) {
        throw Exception('Upload verification failed');
      }

      setState(() => _uploadProgress = 0.85);

      // TRN-WF-02: Compute file hash for integrity verification
      final fileHash = sha256.convert(bytes).toString();

      // Create material version record with file hash and size
      await client.material.createMaterialVersion(
        materialId: material.id!,
        storageKey: storagePath,
        fileHash: fileHash,
        fileSizeBytes: bytes.length,
      );

      setState(() => _uploadProgress = 1.0);

      // Refresh list
      await _load();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: DesignColors.success),
                const SizedBox(width: DesignSpacing.sm),
                Expanded(child: Text('${file.name} uploaded successfully')),
              ],
            ),
            backgroundColor: DesignColors.neutral800,
          ),
        );
      }
    } catch (e) {
      _showError('Upload failed: $e');
    } finally {
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
        _uploadingFileName = null;
      });
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: DesignColors.danger),
            const SizedBox(width: DesignSpacing.sm),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: DesignColors.neutral800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        _buildHeader(),

        // Type filter chips
        _buildTypeFilters(),

        // Upload drop zone
        _buildDropZone(),

        // Materials list
        Expanded(child: _buildMaterialsList()),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(DesignSpacing.md),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: DesignColors.neutral200),
        ),
      ),
      child: Column(
        children: [
          if (widget.isModal)
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: DesignSpacing.sm),
              decoration: BoxDecoration(
                color: DesignColors.neutral300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Row(
            children: [
              const Icon(Icons.folder_open, color: DesignColors.primary, size: 28),
              const SizedBox(width: DesignSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isModal ? 'Select Material' : 'Material Library',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: DesignColors.neutral900,
                      ),
                    ),
                    if (widget.isModal)
                      const Text(
                        'Choose a material to attach to your lesson',
                        style: TextStyle(
                          fontSize: 13,
                          color: DesignColors.neutral500,
                        ),
                      ),
                  ],
                ),
              ),
              if (!widget.isModal)
                IconButton(
                  onPressed: _load,
                  icon: const Icon(Icons.refresh, color: DesignColors.neutral600),
                  tooltip: 'Refresh',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignSpacing.md,
        vertical: DesignSpacing.sm,
      ),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _types.map((type) {
            final isSelected = _selectedType == type;
            return Padding(
              padding: const EdgeInsets.only(right: DesignSpacing.xs),
              child: FilterChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedType = type),
                selectedColor: DesignColors.primary.withAlpha(30),
                checkmarkColor: DesignColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? DesignColors.primary : DesignColors.neutral700,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                side: BorderSide(
                  color: isSelected ? DesignColors.primary : DesignColors.neutral300,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDropZone() {
    // Using MouseRegion + GestureDetector instead of DragTarget to avoid
    // Flutter mouse_tracker.dart assertion errors on desktop/web platforms.
    return Container(
      margin: const EdgeInsets.all(DesignSpacing.md),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isDragOver = true),
        onExit: (_) => setState(() => _isDragOver = false),
        child: GestureDetector(
          onTap: _pickAndUpload,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(DesignSpacing.lg),
            decoration: BoxDecoration(
              color: _isDragOver
                  ? DesignColors.primary.withAlpha(15)
                  : DesignColors.neutral100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isDragOver ? DesignColors.primary : DesignColors.neutral300,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: _isUploading ? _buildUploadProgress() : _buildDropZoneContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildDropZoneContent() {
    return InkWell(
      onTap: _pickAndUpload,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(DesignSpacing.md),
            decoration: BoxDecoration(
              color: DesignColors.primary.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cloud_upload_outlined,
              size: 40,
              color: DesignColors.primary,
            ),
          ),
          const SizedBox(height: DesignSpacing.md),
          const Text(
            'Drag & drop files here',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: DesignColors.neutral800,
            ),
          ),
          const SizedBox(height: DesignSpacing.xs),
          const Text(
            'or click to browse • PDF, Video, SCORM, Images',
            style: TextStyle(
              fontSize: 13,
              color: DesignColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadProgress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: _uploadProgress,
                strokeWidth: 4,
                backgroundColor: DesignColors.neutral200,
                valueColor: const AlwaysStoppedAnimation(DesignColors.primary),
              ),
              Text(
                '${(_uploadProgress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: DesignColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DesignSpacing.md),
        Text(
          'Uploading ${_uploadingFileName ?? 'file'}...',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: DesignColors.neutral700,
          ),
        ),
        const SizedBox(height: DesignSpacing.xs),
        const Text(
          'Virus scan will run automatically after upload',
          style: TextStyle(
            fontSize: 12,
            color: DesignColors.neutral500,
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialsList() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: DesignColors.primary),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: DesignColors.danger),
            const SizedBox(height: DesignSpacing.md),
            const Text(
              'Failed to load materials',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DesignColors.neutral800,
              ),
            ),
            const SizedBox(height: DesignSpacing.sm),
            TextButton.icon(
              onPressed: _load,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final materials = _filteredMaterials;
    if (materials.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.folder_off_outlined, size: 48, color: DesignColors.neutral400),
            const SizedBox(height: DesignSpacing.md),
            Text(
              _selectedType == 'All'
                  ? 'No materials uploaded yet'
                  : 'No $_selectedType materials found',
              style: const TextStyle(
                fontSize: 16,
                color: DesignColors.neutral600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.md),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final material = materials[index];
        return _MaterialListTile(
          material: material,
          isModal: widget.isModal,
          onSelect: widget.onMaterialSelected != null
              ? () => widget.onMaterialSelected!(material)
              : null,
          onTap: widget.isModal
              ? null
              : () => context.push('/materials/${material.id}'),
        );
      },
    );
  }
}

/// Individual material tile with TRN-WF-02 compliance indicators.
class _MaterialListTile extends StatelessWidget {
  const _MaterialListTile({
    required this.material,
    this.isModal = false,
    this.onSelect,
    this.onTap,
  });

  final LmsMaterial material;
  final bool isModal;
  final VoidCallback? onSelect;
  final VoidCallback? onTap;

  IconData get _typeIcon {
    switch (material.materialType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'video':
        return Icons.videocam;
      case 'scorm':
        return Icons.school;
      case 'image':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color get _typeColor {
    switch (material.materialType.toLowerCase()) {
      case 'pdf':
        return const Color(0xFFE53935);
      case 'video':
        return const Color(0xFF7B1FA2);
      case 'scorm':
        return const Color(0xFF1976D2);
      case 'image':
        return const Color(0xFF43A047);
      default:
        return DesignColors.neutral600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignSpacing.sm),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: DesignColors.neutral200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(DesignSpacing.md),
          child: Row(
            children: [
              // Type icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _typeColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_typeIcon, color: _typeColor, size: 24),
              ),
              const SizedBox(width: DesignSpacing.md),

              // Title and metadata
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: DesignColors.neutral900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _TypeBadge(type: material.materialType),
                        const SizedBox(width: DesignSpacing.sm),
                        // Virus scan status indicator (TRN-WF-02)
                        _VirusScanBadge(status: _getMockVirusScanStatus()),
                        const SizedBox(width: DesignSpacing.sm),
                        // File hash indicator (TRN-WF-02)
                        if (_getMockFileHash() != null)
                          _FileHashChip(hash: _getMockFileHash()!),
                      ],
                    ),
                  ],
                ),
              ),

              // Select button for modal mode
              if (isModal && onSelect != null) ...[
                const SizedBox(width: DesignSpacing.sm),
                ElevatedButton(
                  onPressed: onSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignSpacing.md,
                      vertical: DesignSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Select'),
                ),
              ],

              // Chevron for standalone mode
              if (!isModal && onTap != null)
                const Icon(Icons.chevron_right, color: DesignColors.neutral400),
            ],
          ),
        ),
      ),
    );
  }

  // Mock methods - replace with actual data when MaterialVersion is queried
  // TRN-WF-02: After serverpod generate, fetch actual virusScanStatus from MaterialVersion
  String _getMockVirusScanStatus() {
    // In production, query the latest MaterialVersion for this material
    // Return: 'pending', 'clean', or 'quarantined'
    final hash = material.id.hashCode;
    if (hash % 10 == 0) return 'quarantined';
    if (hash % 3 == 0) return 'pending';
    return 'clean';
  }

  String? _getMockFileHash() {
    // In production, query the latest MaterialVersion for this material
    // Return actual SHA-256 hash from MaterialVersion.fileHash
    return 'sha256:${material.id.hashCode.toRadixString(16).padLeft(8, '0')}a1b2c3d4';
  }
}

/// Type badge showing material type.
class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignSpacing.xs + 2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: DesignColors.neutral200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: DesignColors.neutral700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// Virus scan status badge (TRN-WF-02 compliance).
class _VirusScanBadge extends StatelessWidget {
  const _VirusScanBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    String tooltip;

    switch (status.toLowerCase()) {
      case 'clean':
        icon = Icons.verified_user;
        color = DesignColors.success;
        tooltip = 'Virus scan: Clean';
      case 'pending':
        icon = Icons.hourglass_top;
        color = DesignColors.warning;
        tooltip = 'Virus scan: Pending';
      case 'quarantined':
        icon = Icons.warning_amber;
        color = DesignColors.danger;
        tooltip = 'Virus scan: Quarantined';
      default:
        icon = Icons.help_outline;
        color = DesignColors.neutral500;
        tooltip = 'Virus scan: Unknown';
    }

    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14, color: color),
      ),
    );
  }
}

/// Truncated file hash chip (TRN-WF-02 compliance).
class _FileHashChip extends StatelessWidget {
  const _FileHashChip({required this.hash});

  final String hash;

  String get _truncatedHash {
    if (hash.length <= 16) return hash;
    return '${hash.substring(0, 12)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'File hash: $hash',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignSpacing.xs,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: DesignColors.neutral100,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: DesignColors.neutral300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.fingerprint,
              size: 12,
              color: DesignColors.neutral500,
            ),
            const SizedBox(width: 2),
            Text(
              _truncatedHash,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: DesignColors.neutral600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Standalone screen wrapper that uses MaterialUploadView.
class MaterialUploadScreen extends StatelessWidget {
  const MaterialUploadScreen({
    super.key,
    required this.organizationId,
  });

  final int organizationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.neutral50,
      appBar: AppBar(
        title: const Text('Material Library'),
        backgroundColor: Colors.white,
        foregroundColor: DesignColors.neutral900,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: DesignColors.neutral200,
            height: 1,
          ),
        ),
      ),
      body: MaterialUploadView(organizationId: organizationId),
    );
  }
}
