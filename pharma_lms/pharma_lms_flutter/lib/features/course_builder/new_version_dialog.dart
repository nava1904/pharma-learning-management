import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// TRN-WF-05: Create New Version Dialog
/// Triggered when trainer wants to update a published/rejected course.
/// Requires a mandatory change summary describing what changed and why.
/// Returns the new CourseVersion if successful, null if cancelled.
class NewVersionDialog extends StatefulWidget {
  const NewVersionDialog({
    super.key,
    required this.existingVersion,
    required this.courseTitle,
    this.createdById,
  });

  final CourseVersion existingVersion;
  final String courseTitle;
  final int? createdById;

  /// Show the dialog and return the result map or null
  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    required CourseVersion existingVersion,
    required String courseTitle,
    int? createdById,
  }) async {
    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => NewVersionDialog(
        existingVersion: existingVersion,
        courseTitle: courseTitle,
        createdById: createdById,
      ),
    );
  }

  @override
  State<NewVersionDialog> createState() => _NewVersionDialogState();
}

class _NewVersionDialogState extends State<NewVersionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _changeSummaryController = TextEditingController();

  bool _isMajorVersion = false;
  bool _saving = false;
  String? _error;

  String get _previewNewVersion {
    final current = widget.existingVersion.version;
    final parts = current.split('.');
    if (parts.length != 2) return _isMajorVersion ? '2.0' : '1.1';
    final major = int.tryParse(parts[0]) ?? 1;
    final minor = int.tryParse(parts[1]) ?? 0;
    return _isMajorVersion ? '${major + 1}.0' : '$major.${minor + 1}';
  }

  @override
  void dispose() {
    _changeSummaryController.dispose();
    super.dispose();
  }

  Future<void> _createNewVersion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      // TRN-WF-05: Create new version with content copy
      final result = await client.courseBuilder.createNewVersionFromExisting(
        existingVersionId: widget.existingVersion.id!,
        changeSummary: _changeSummaryController.text.trim(),
        isMajorVersion: _isMajorVersion,
        createdById: widget.createdById,
      );

      if (mounted) {
        Navigator.of(context).pop(result);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEffective = widget.existingVersion.status == 'effective';
    final isRejected = widget.existingVersion.status == 'rejected';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 520,
        constraints: const BoxConstraints(maxHeight: 650),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.indigo600,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.upgrade,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create New Version',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TRN-WF-05 • ${widget.courseTitle}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _saving ? null : () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Form
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Error banner
                      if (_error != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.destructive.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.destructive.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline,
                                  color: AppColors.destructive, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: TextStyle(
                                    color: AppColors.destructive,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Current Version Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.slate100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Version',
                                  style: TextStyle(
                                    color: AppColors.slate600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'v${widget.existingVersion.version}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.slate900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.arrow_forward, color: AppColors.slate400),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New Version',
                                  style: TextStyle(
                                    color: AppColors.slate600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'v$_previewNewVersion',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.indigo600,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isEffective
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : isRejected
                                        ? AppColors.destructive.withValues(alpha: 0.1)
                                        : AppColors.slate200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.existingVersion.status.toUpperCase(),
                                style: TextStyle(
                                  color: isEffective
                                      ? AppColors.success
                                      : isRejected
                                          ? AppColors.destructive
                                          : AppColors.slate600,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Version Type Toggle
                      Text(
                        'Version Type',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _VersionTypeCard(
                              title: 'Minor Update',
                              subtitle: 'Small corrections, typos, clarifications',
                              example: '${widget.existingVersion.version} → ${_getMinorVersion()}',
                              isSelected: !_isMajorVersion,
                              onTap: () => setState(() => _isMajorVersion = false),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _VersionTypeCard(
                              title: 'Major Update',
                              subtitle: 'Significant content changes, new modules',
                              example: '${widget.existingVersion.version} → ${_getMajorVersion()}',
                              isSelected: _isMajorVersion,
                              onTap: () => setState(() => _isMajorVersion = true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Change Summary (MANDATORY)
                      Row(
                        children: [
                          Text(
                            'Change Summary *',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.destructive.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'REQUIRED',
                              style: TextStyle(
                                color: AppColors.destructive,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _changeSummaryController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                              'Describe what changed and why (for audit trail)...\n\nExample: Updated Section 3.2 to reflect revised FDA guidance on equipment cleaning validation procedures.',
                          hintStyle: TextStyle(
                            color: AppColors.slate400,
                            fontSize: 13,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Change summary is required for 21 CFR 11 compliance';
                          }
                          if (v.trim().length < 20) {
                            return 'Please provide a more detailed summary (min 20 characters)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Info box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.amber600.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.amber600.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline,
                                color: AppColors.amber600, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'What will be copied?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.slate800,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '• All modules and their order\n'
                                    '• All lessons with material links\n'
                                    '• Assessment configuration\n'
                                    '• Existing enrollments remain on v${widget.existingVersion.version}',
                                    style: TextStyle(
                                      color: AppColors.slate700,
                                      fontSize: 12,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                border: Border(
                  top: BorderSide(color: AppColors.slate200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _saving ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _saving ? null : _createNewVersion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.indigo600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: _saving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.upgrade, size: 18),
                    label: Text(_saving ? 'Creating...' : 'Create v$_previewNewVersion'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMinorVersion() {
    final parts = widget.existingVersion.version.split('.');
    if (parts.length != 2) return '1.1';
    final major = int.tryParse(parts[0]) ?? 1;
    final minor = int.tryParse(parts[1]) ?? 0;
    return '$major.${minor + 1}';
  }

  String _getMajorVersion() {
    final parts = widget.existingVersion.version.split('.');
    if (parts.length != 2) return '2.0';
    final major = int.tryParse(parts[0]) ?? 1;
    return '${major + 1}.0';
  }
}

class _VersionTypeCard extends StatelessWidget {
  const _VersionTypeCard({
    required this.title,
    required this.subtitle,
    required this.example,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String example;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.indigo50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.indigo600 : AppColors.slate300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? AppColors.indigo600 : AppColors.slate400,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.indigo800 : AppColors.slate700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.slate600,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.slate200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                example,
                style: TextStyle(
                  color: AppColors.slate700,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
