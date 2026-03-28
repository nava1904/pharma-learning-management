import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/core/file_download.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import 'dart:convert';
import 'dart:typed_data';


/// User Bulk Import Screen
/// 
/// Module 1: User & Identity Management
/// Screen 6/8: Bulk Import Users
/// 
/// Allows admins to import multiple users via CSV file:
/// - Upload CSV file
/// - Preview data before import
/// - Validate email uniqueness
/// - Validate employee ID uniqueness
/// - Show import progress
/// - Display results (success/failures)
/// 
/// CSV Format:
/// employeeId,email,firstName,lastName,organizationId,siteId,departmentId,jobRoleId,role
class UserBulkImportScreen extends ConsumerStatefulWidget {
  const UserBulkImportScreen({super.key});

  @override
  ConsumerState<UserBulkImportScreen> createState() =>
      _UserBulkImportScreenState();
}

class _UserBulkImportScreenState extends ConsumerState<UserBulkImportScreen> {
  bool isLoading = false;
  String? selectedFileName;
  List<Map<String, String>> previewData = [];
  bool showPreview = false;
  Uint8List? _csvBytes;

  Future<void> _selectFile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    if (res == null || res.files.isEmpty) return;

    final file = res.files.first;
    final bytes = file.bytes;
    if (bytes == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to read CSV bytes'),
          backgroundColor: PharmaColors.danger,
        ),
      );
      return;
    }

    final parsed = _parseCsvPreview(bytes);
    setState(() {
      selectedFileName = file.name;
      _csvBytes = bytes;
      previewData = parsed;
      showPreview = true;
    });
  }

  Future<void> _confirmImport() async {
    setState(() => isLoading = true);

    try {
      final bytes = _csvBytes;
      if (bytes == null) throw Exception('No CSV selected');

      final me = await ref.read(currentUserProvider.future);
      if (me?.id == null) throw Exception('Not authenticated');

      final result = await client.admin.bulkImportUsers(
        csvBase64: base64Encode(bytes),
        assignedById: me!.id!,
      );

      if (!mounted) return;
      _showImportResults(imported: result.imported, errors: result.errors);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error importing users: $e'),
            backgroundColor: PharmaColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  List<Map<String, String>> _parseCsvPreview(Uint8List bytes) {
    final csv = utf8.decode(bytes);
    final lines = csv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isEmpty) return [];

    final headers = lines.first
        .split(',')
        .map((s) => s.trim().replaceAll('"', ''))
        .toList();

    final out = <Map<String, String>>[];
    for (var i = 1; i < lines.length && out.length < 20; i++) {
      final cols = lines[i].split(',').map((s) => s.trim().replaceAll('"', '')).toList();
      final row = <String, String>{};
      for (var c = 0; c < headers.length; c++) {
        row[headers[c]] = c < cols.length ? cols[c] : '';
      }
      out.add(row);
    }
    return out;
  }

  void _showImportResults({required int imported, required List<String> errors}) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Import Completed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultRow('Imported', '$imported', PharmaColors.success),
            _buildResultRow('Errors', '${errors.length}', errors.isEmpty ? PharmaColors.success : PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text(
              errors.isEmpty
                  ? 'All rows imported successfully.'
                  : 'Some rows failed validation. You can download the error report.',
              style: PharmaTypography.caption,
            ),
          ],
        ),
        actions: [
          if (errors.isNotEmpty)
            TextButton(
              onPressed: () async {
                final bytes = Uint8List.fromList(utf8.encode(errors.join('\n')));
                await saveBytesToFile(bytes, 'user_bulk_import_errors.txt');
              },
              child: const Text('Download Errors'),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String count, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PharmaSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: PharmaTypography.bodyMedium),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: PharmaSpacing.sm,
              vertical: PharmaSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PharmaSpacing.sm),
            ),
            child: Text(
              count,
              style: PharmaTypography.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Import Users'),
        elevation: 0,
        backgroundColor: PharmaColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Container(
              padding: EdgeInsets.all(PharmaSpacing.md),
              decoration: BoxDecoration(
                color: PharmaColors.infoBg,
                borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                border: Border.all(color: PharmaColors.info),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CSV Format',
                    style: PharmaTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PharmaColors.infoText,
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.sm),
                  Text(
                    'employeeId, email, firstName, lastName, organizationId, '
                    'siteId, departmentId, jobRoleId, role',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.infoText,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  Text(
                    'All fields are required. IDs must be valid integers. Role must exist (e.g. admin, trainer, employee, qa_manager...).',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.infoText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: PharmaSpacing.lg),

            if (!showPreview) ...[
              // File Upload Section
              Text(
                'Select CSV File',
                style: PharmaTypography.headingMedium.copyWith(
                  color: PharmaColors.primary,
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: PharmaColors.borderMedium,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                        color: PharmaColors.gray50,
                      ),
                      child: InkWell(
                        onTap: _selectFile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              size: 64,
                              color: PharmaColors.primary,
                            ),
                            SizedBox(height: PharmaSpacing.md),
                            Text(
                              'Click to select CSV',
                              style: PharmaTypography.bodyMedium.copyWith(
                                color: PharmaColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: PharmaSpacing.lg),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.folder_open),
                      label: const Text('Browse Files'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PharmaColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _selectFile,
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Preview Section
              Text(
                'Preview Data',
                style: PharmaTypography.headingMedium.copyWith(
                  color: PharmaColors.primary,
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              Container(
                padding: EdgeInsets.all(PharmaSpacing.md),
                decoration: BoxDecoration(
                  color: PharmaColors.gray50,
                  borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  border: Border.all(color: PharmaColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'File: $selectedFileName',
                          style: PharmaTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${previewData.length} records',
                          style: PharmaTypography.caption,
                        ),
                      ],
                    ),
                    SizedBox(height: PharmaSpacing.md),
                    SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Employee ID')),
                            DataColumn(label: Text('Role')),
                          ],
                          rows: previewData
                              .map(
                                (row) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        '${row['first_name']} ${row['last_name']}',
                                        style: PharmaTypography.caption,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        row['email'] ?? '',
                                        style: PharmaTypography.caption,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        row['employee_id'] ?? '',
                                        style: PharmaTypography.caption,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        row['role'] ?? '',
                                        style: PharmaTypography.caption,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: PharmaSpacing.lg),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PharmaColors.background,
                    foregroundColor: PharmaColors.textPrimary,
                    side: BorderSide(color: PharmaColors.border),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (showPreview) {
                            setState(() => showPreview = false);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Cancel'),
                  ),
                ),
                if (showPreview) ...[
                  SizedBox(width: PharmaSpacing.md),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PharmaColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isLoading ? null : _confirmImport,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Confirm Import'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
