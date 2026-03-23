import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';

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
/// first_name,last_name,email,employee_id,phone,department,organization,role,hire_date
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

  Future<void> _selectFile() async {
    // TODO: Use file picker to select CSV
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['csv'],
    // );

    // TEMPORARY: Simulate file selection
    setState(() {
      selectedFileName = 'users_import_20240321.csv';
      previewData = [
        {
          'first_name': 'John',
          'last_name': 'Employee1',
          'email': 'john.e1@pharmatest.com',
          'employee_id': 'EMP101',
          'phone': '+1 (555) 111-1111',
          'department': 'Sales',
          'organization': 'HQ',
          'role': 'EMPLOYEE',
          'hire_date': '2024-03-21',
        },
        {
          'first_name': 'Sarah',
          'last_name': 'Trainer1',
          'email': 'sarah.trainer@pharmatest.com',
          'employee_id': 'EMP102',
          'phone': '+1 (555) 222-2222',
          'department': 'Training',
          'organization': 'Training Center',
          'role': 'TRAINER',
          'hire_date': '2024-03-20',
        },
        {
          'first_name': 'Mike',
          'last_name': 'Employee2',
          'email': 'mike.e2@pharmatest.com',
          'employee_id': 'EMP103',
          'phone': '+1 (555) 333-3333',
          'department': 'Operations',
          'organization': 'HQ',
          'role': 'EMPLOYEE',
          'hire_date': '2024-03-19',
        },
      ];
      showPreview = true;
    });
  }

  Future<void> _confirmImport() async {
    setState(() => isLoading = true);

    try {
      // TODO: Call backend endpoint to bulk import users
      // final result = await ref.read(bulkImportUsersProvider.notifier).importUsers(
      //   csvData: previewData,
      // );

      // TEMPORARY: Simulate import
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        _showImportResults();
      }
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

  void _showImportResults() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Import Completed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultRow('Successful', '3', PharmaColors.success),
            _buildResultRow('Failed', '0', PharmaColors.danger),
            _buildResultRow('Skipped', '0', PharmaColors.warning),
            SizedBox(height: PharmaSpacing.md),
            Text(
              'All users have been imported successfully!',
              style: PharmaTypography.caption,
            ),
          ],
        ),
        actions: [
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
                    'first_name, last_name, email, employee_id, phone, '
                    'department, organization, role, hire_date',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.infoText,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  Text(
                    'All fields except phone are required. Email and employee_id must be unique.',
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
