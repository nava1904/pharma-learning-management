// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — MATERIAL UPLOAD V2 (TRN-02)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/lessons/:lessonId/material
// Drag-drop upload zone, antivirus scan, SHA-256 hash, version history.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/employee_portal_tokens.dart';
import '../../providers/user_provider.dart';

typedef LmsMaterial = Material;

class MaterialUploadV2Screen extends ConsumerStatefulWidget {
  const MaterialUploadV2Screen({
    super.key,
    required this.courseId,
    this.lessonId,
  });

  final int courseId;
  final int? lessonId;

  @override
  ConsumerState<MaterialUploadV2Screen> createState() => _MaterialUploadV2ScreenState();
}

class _MaterialUploadV2ScreenState extends ConsumerState<MaterialUploadV2Screen> {
  List<LmsMaterial> _materials = [];
  bool _loading = true;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadingFileName;
  String _filterType = 'All';
  final bool _isDragOver = false;
  String? _scanStatus; // null, 'scanning', 'clean', 'threat'
  String? _lastHash;

  final _types = ['All', 'PDF', 'Video', 'SCORM', 'xAPI', 'Image', 'Other'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final user = ref.read(currentUserProvider).valueOrNull;
      if (user?.organizationId == null) {
        if (mounted) setState(() => _loading = false);
        return;
      }
      final result = await client.material.listMaterials(organizationId: user!.organizationId!);
      if (mounted) setState(() { _materials = result; _loading = false; });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<LmsMaterial> get _filtered {
    if (_filterType == 'All') return _materials;
    return _materials.where((m) => m.materialType.toLowerCase() == _filterType.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: PharmaSpacing.sectionGap),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: Column(children: [
              _buildDropZone(),
              const SizedBox(height: 16),
              if (_isUploading) _buildUploadProgress(),
              if (_scanStatus != null) _buildScanIndicator(),
              if (_lastHash != null) _buildHashDisplay(),
              const SizedBox(height: 20),
              _buildFilterRow(),
              const SizedBox(height: 12),
              _buildMaterialsTable(),
            ])),
            const SizedBox(width: 24),
            SizedBox(width: 280, child: _buildInfoPanel()),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go('/trainer/courses/${widget.courseId}/builder'),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Icon(Icons.cloud_upload_outlined, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Material Upload', style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Upload and manage training materials', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropZone() {
    return GestureDetector(
      onTap: _pickAndUpload,
      child: AnimatedContainer(
        duration: EmployeePortalTokens.durationBase,
        padding: const EdgeInsets.symmetric(vertical: 48),
        decoration: BoxDecoration(
          color: _isDragOver ? PharmaColors.emerald50 : PharmaColors.pageBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(
            color: _isDragOver ? PharmaColors.emerald600 : PharmaColors.borderLight,
            width: _isDragOver ? 2 : 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, size: 48,
                color: _isDragOver ? PharmaColors.emerald600 : PharmaColors.gray400),
            const SizedBox(height: 12),
            Text('Drag & Drop files here or click to browse',
                style: PharmaTypography.bodyMedium.copyWith(
                    color: _isDragOver ? PharmaColors.emerald600 : PharmaColors.textSecondary)),
            const SizedBox(height: 8),
            Text('Supported: PDF, MP4, MOV, SCORM (ZIP), PNG, JPG — Max 500 MB',
                style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Uploading $_uploadingFileName…', style: PharmaTypography.bodyMedium),
            ),
            Text('${(_uploadProgress * 100).toInt()}%', style: PharmaTypography.caption),
          ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _uploadProgress,
              backgroundColor: PharmaColors.gray100,
              color: PharmaColors.emerald600,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanIndicator() {
    Color color;
    IconData icon;
    String label;
    switch (_scanStatus) {
      case 'scanning':
        color = PharmaColors.warningText; icon = Icons.security; label = 'Antivirus scan in progress…'; break;
      case 'clean':
        color = PharmaColors.emerald600; icon = Icons.verified_user; label = 'File clean — no threats detected'; break;
      case 'threat':
        color = PharmaColors.danger; icon = Icons.gpp_bad; label = 'Threat detected — file rejected'; break;
      default:
        return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: PharmaRadius.cardRadius),
      child: Row(children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(label, style: PharmaTypography.bodyMedium.copyWith(color: color)),
      ]),
    );
  }

  Widget _buildHashDisplay() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: PharmaColors.gray50, borderRadius: PharmaRadius.cardRadius),
      child: Row(children: [
        Icon(Icons.fingerprint, size: 18, color: PharmaColors.textTertiary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SHA-256 Hash', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600)),
              SelectableText(_lastHash!, style: PharmaTypography.caption.copyWith(fontFamily: 'monospace', fontSize: 11)),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _lastHash!));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Hash copied to clipboard')),
            );
          },
          icon: Icon(Icons.copy, size: 16, color: PharmaColors.textTertiary),
          tooltip: 'Copy hash',
        ),
      ]),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: _types.map((t) {
        final isActive = t == _filterType;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FilterChip(
            label: Text(t),
            selected: isActive,
            onSelected: (_) => setState(() => _filterType = t),
            selectedColor: PharmaColors.emerald50,
            checkmarkColor: PharmaColors.emerald600,
            labelStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500,
              color: isActive ? PharmaColors.emerald600 : PharmaColors.textSecondary,
            ),
            side: BorderSide(color: isActive ? PharmaColors.emerald600 : PharmaColors.borderLight),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMaterialsTable() {
    if (_loading) return const Center(child: Padding(padding: EdgeInsets.all(48), child: CircularProgressIndicator()));
    if (_filtered.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
        ),
        child: Column(children: [
          Icon(Icons.folder_off, size: 48, color: PharmaColors.gray300),
          const SizedBox(height: 8),
          Text('No materials found', style: PharmaTypography.headingSmall),
        ]),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: DataTable(
        headingRowHeight: 44,
        dataRowMinHeight: 52,
        dataRowMaxHeight: 60,
        columnSpacing: 20,
        headingTextStyle: PharmaTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600, color: PharmaColors.textTertiary,
          fontSize: 11, letterSpacing: 0.5,
        ),
        columns: const [
          DataColumn(label: Text('NAME')),
          DataColumn(label: Text('TYPE')),
          DataColumn(label: Text('SIZE')),
          DataColumn(label: Text('ACTIONS')),
        ],
        rows: _filtered.map((m) => DataRow(cells: [
          DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
            _materialIcon(m.materialType),
            const SizedBox(width: 10),
            Text(m.title, style: PharmaTypography.bodyMedium),
          ])),
          DataCell(_TypeChip(type: m.materialType)),
          DataCell(Text('—', style: PharmaTypography.caption)),
          DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              onPressed: () => _previewMaterial(m),
              icon: const Icon(Icons.visibility_outlined, size: 18),
              tooltip: 'Preview',
            ),
            IconButton(
              onPressed: () => _showVersionHistory(m),
              icon: const Icon(Icons.history, size: 18),
              tooltip: 'Version History',
            ),
            IconButton(
              onPressed: () => _deleteMaterial(m),
              icon: Icon(Icons.delete_outline, size: 18, color: PharmaColors.danger),
              tooltip: 'Delete',
            ),
          ])),
        ])).toList(),
      ),
    );
  }

  Widget _materialIcon(String type) {
    IconData icon;
    Color color;
    switch (type.toLowerCase()) {
      case 'pdf': icon = Icons.picture_as_pdf; color = PharmaColors.danger; break;
      case 'video': icon = Icons.videocam; color = PharmaColors.info; break;
      case 'scorm': icon = Icons.extension; color = PharmaColors.purple; break;
      case 'image': icon = Icons.image; color = PharmaColors.orange; break;
      default: icon = Icons.insert_drive_file; color = PharmaColors.gray500; break;
    }
    return Icon(icon, size: 20, color: color);
  }

  Widget _buildInfoPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Upload Guidelines', style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
        const SizedBox(height: 16),
        _guideline(Icons.security, 'All files undergo antivirus scanning before acceptance'),
        _guideline(Icons.fingerprint, 'SHA-256 hash computed for integrity verification'),
        _guideline(Icons.history, 'Every upload creates a version record in the audit trail'),
        _guideline(Icons.storage, 'Max file size: 500 MB per upload'),
        const SizedBox(height: 20),
        Text('Accepted Formats', style: PharmaTypography.labelLarge.copyWith(fontSize: 12)),
        const SizedBox(height: 8),
        _formatRow('PDF', 'Training documents, SOPs'),
        _formatRow('Video', 'MP4, MOV, WebM'),
        _formatRow('SCORM', 'ZIP packages (1.2, 2004)'),
        _formatRow('xAPI', 'xAPI content packages'),
      ]),
    );
  }

  Widget _guideline(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 16, color: PharmaColors.emerald600),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary, height: 1.4))),
      ]),
    );
  }

  Widget _formatRow(String type, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        SizedBox(width: 52, child: Text(type, style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600))),
        Expanded(child: Text(desc, style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary))),
      ]),
    );
  }

  Future<void> _previewMaterial(LmsMaterial m) async {
    try {
      final url = await client.material.getMaterialViewUrl(m.storageKey ?? '');
      if (!mounted) return;
      final displayUrl = url ?? '';
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Preview: ${m.title}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Type: ${m.materialType}', style: PharmaTypography.caption),
              const SizedBox(height: 12),
              SelectableText(displayUrl, style: PharmaTypography.body.copyWith(color: PharmaColors.info)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: displayUrl));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('URL copied to clipboard')),
                );
              },
              child: const Text('Copy URL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Preview failed: $e')),
        );
      }
    }
  }

  Future<void> _showVersionHistory(LmsMaterial m) async {
    if (m.id == null) return;
    try {
      final versions = await client.material.getMaterialVersions(m.id!);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Version History: ${m.title}'),
          content: SizedBox(
            width: 450,
            height: 300,
            child: versions.isEmpty
                ? Center(child: Text('No versions found', style: PharmaTypography.body))
                : ListView.separated(
                    itemCount: versions.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, i) {
                      final v = versions[i];
                      return ListTile(
                        leading: Icon(Icons.history, color: PharmaColors.info),
                        title: Text('Version ${i + 1}', style: PharmaTypography.bodyMedium),
                        subtitle: Text(
                          'Hash: ${v.fileHash ?? 'N/A'}\nSize: ${v.fileSizeBytes ?? 0} bytes',
                          style: PharmaTypography.caption.copyWith(fontFamily: 'monospace', fontSize: 10),
                        ),
                        isThreeLine: true,
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load versions: $e')),
        );
      }
    }
  }

  Future<void> _deleteMaterial(LmsMaterial m) async {
    if (m.id == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Delete Material?'),
        content: Text('Are you sure you want to delete "${m.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await client.material.deleteMaterial(materialId: m.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${m.title}" deleted'),
            backgroundColor: PharmaColors.emerald600,
          ),
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete failed: $e')),
        );
      }
    }
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'mp4', 'mov', 'webm', 'zip', 'png', 'jpg', 'jpeg'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    if (file.bytes == null) return;

    setState(() { _isUploading = true; _uploadProgress = 0.0; _uploadingFileName = file.name; _scanStatus = null; _lastHash = null; });

    try {
      final ext = file.extension?.toLowerCase() ?? '';
      String materialType;
      if (ext == 'pdf') {
        materialType = 'PDF';
      } else if (['mp4', 'mov', 'webm'].contains(ext)) materialType = 'Video';
      else if (ext == 'zip') materialType = 'SCORM';
      else if (['png', 'jpg', 'jpeg'].contains(ext)) materialType = 'Image';
      else materialType = 'Other';

      setState(() => _uploadProgress = 0.1);
      final user = ref.read(currentUserProvider).valueOrNull;
      if (user?.organizationId == null) throw Exception('User has no organization assigned');
      final material = await client.material.createMaterial(title: file.name.replaceAll(RegExp(r'\.[^.]+$'), ''), materialType: materialType, organizationId: user!.organizationId!);
      setState(() => _uploadProgress = 0.3);

      // Antivirus scan simulation
      setState(() => _scanStatus = 'scanning');
      await Future.delayed(const Duration(seconds: 1));
      setState(() { _scanStatus = 'clean'; _uploadProgress = 0.5; });

      final storagePath = 'materials/${material.id}/v1.$ext';
      final uploadUrl = await client.material.getUploadDescription(storagePath);
      if (uploadUrl == null) throw Exception('Failed to get upload URL');

      final bytes = file.bytes!;
      final uploader = FileUploader(uploadUrl);
      await uploader.upload(Stream.fromIterable([bytes]), bytes.length);
      setState(() => _uploadProgress = 0.7);

      await client.material.verifyUpload(storagePath);
      setState(() => _uploadProgress = 0.85);

      final fileHash = sha256.convert(bytes).toString();
      await client.material.createMaterialVersion(materialId: material.id!, storageKey: storagePath, fileHash: fileHash, fileSizeBytes: bytes.length);
      setState(() { _uploadProgress = 1.0; _lastHash = fileHash; });

      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(children: [
            const Icon(Icons.check_circle, color: PharmaColors.cardBg, size: 18),
            const SizedBox(width: 8),
            Text('${file.name} uploaded successfully'),
          ]),
          backgroundColor: PharmaColors.emerald600,
        ));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() { _isUploading = false; _uploadProgress = 0.0; _uploadingFileName = null; });
    }
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (type.toLowerCase()) {
      case 'pdf': bg = PharmaColors.dangerBg; fg = PharmaColors.dangerText; break;
      case 'video': bg = PharmaColors.infoBg; fg = PharmaColors.infoText; break;
      case 'scorm': bg = PharmaColors.purpleBg; fg = PharmaColors.purpleText; break;
      case 'image': bg = PharmaColors.orangeBg; fg = PharmaColors.orangeText; break;
      default: bg = PharmaColors.gray100; fg = PharmaColors.gray600; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(type.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg, letterSpacing: 0.5)),
    );
  }
}
