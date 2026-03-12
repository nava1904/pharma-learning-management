import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';

/// ADM-WF-06: Bulk import employees from CSV with column mapping and validation preview.
class BulkImportScreen extends ConsumerStatefulWidget {
  const BulkImportScreen({super.key});

  @override
  ConsumerState<BulkImportScreen> createState() => _BulkImportScreenState();
}

class _BulkImportScreenState extends ConsumerState<BulkImportScreen> {
  List<List<String>> _rows = [];
  List<String> _headers = [];
  Map<String, int?> _columnMapping = {};
  static const _requiredFields = [
    'email',
    'firstName',
    'lastName',
    'departmentId',
    'siteId',
    'organizationId',
    'jobRoleId',
  ];
  bool _importing = false;
  int _assignedById = 1;

  @override
  void initState() {
    super.initState();
    _loadAssignedBy();
  }

  Future<void> _loadAssignedBy() async {
    final user = await client.user.getUserByEmail('admin@pharmacorp.demo');
    if (user?.id != null) {
      setState(() => _assignedById = user!.id!);
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result == null || result.files.isEmpty || !mounted) return;

    final bytes = result.files.first.bytes;
    if (bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read file')));
      return;
    }

    final csv = utf8.decode(bytes);
    final lines = csv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File is empty')));
      return;
    }

    final allRows = <List<String>>[
      for (final l in lines) _parseCsvLine(l),
    ];
    final headers = allRows.first;
    final dataRows = allRows.length > 1 ? allRows.sublist(1) : <List<String>>[];

    final mapping = <String, int?>{};
    for (final f in _requiredFields) {
      final idx = headers.indexWhere(
          (h) => h.trim().toLowerCase() == f.toLowerCase());
      mapping[f] = idx >= 0 ? idx : null;
    }

    setState(() {
      _headers = headers;
      _rows = dataRows;
      _columnMapping = mapping;
    });
  }

  List<String> _parseCsvLine(String line) {
    final result = <String>[];
    var current = '';
    var inQuotes = false;
    for (var i = 0; i < line.length; i++) {
      final c = line[i];
      if (c == '"') {
        inQuotes = !inQuotes;
      } else if ((c == ',' && !inQuotes) || c == '\n' || c == '\r') {
        result.add(current.trim());
        current = '';
        if (c == '\n' || c == '\r') break;
      } else {
        current += c;
      }
    }
    result.add(current.trim());
    return result;
  }

  String? _validateRow(int rowIndex, List<String> row) {
    final emailIdx = _columnMapping['email'];
    final firstIdx = _columnMapping['firstName'];
    final lastIdx = _columnMapping['lastName'];
    final deptIdx = _columnMapping['departmentId'];
    final siteIdx = _columnMapping['siteId'];
    final orgIdx = _columnMapping['organizationId'];
    final jobIdx = _columnMapping['jobRoleId'];

    if (emailIdx == null || emailIdx >= row.length) {
      return 'Missing email column';
    }
    final email = row[emailIdx].trim();
    if (email.isEmpty) return 'Empty email';

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(email)) return 'Invalid email format';

    if (deptIdx == null || siteIdx == null || orgIdx == null || jobIdx == null) {
      return 'Missing required column mapping';
    }
    final orgId = int.tryParse(row[orgIdx].trim());
    final siteId = int.tryParse(row[siteIdx].trim());
    final deptId = int.tryParse(row[deptIdx].trim());
    final jobRoleId = int.tryParse(row[jobIdx].trim());
    if (orgId == null || siteId == null || deptId == null || jobRoleId == null) {
      return 'Invalid org/site/dept/jobRole IDs';
    }

    return null;
  }

  Future<void> _import() async {
    final missing = _requiredFields
        .where((f) => _columnMapping[f] == null)
        .toList();
    if (missing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Map required columns: ${missing.join(", ")}')));
      return;
    }

    if (_rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data rows to import')));
      return;
    }

    final validRows = <List<String>>[];
    for (var i = 0; i < _rows.length; i++) {
      final err = _validateRow(i, _rows[i]);
      if (err == null) validRows.add(_rows[i]);
    }

    if (validRows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No valid rows to import')));
      return;
    }

    setState(() => _importing = true);

    final csvLines = <String>[
      'email,firstName,lastName,departmentId,siteId,organizationId,jobRoleId',
    ];
    for (final row in validRows) {
      final email = _columnMapping['email']! < row.length
          ? row[_columnMapping['email']!].trim()
          : '';
      final first = _columnMapping['firstName'] != null &&
              _columnMapping['firstName']! < row.length
          ? row[_columnMapping['firstName']!].trim()
          : 'User';
      final last = _columnMapping['lastName'] != null &&
              _columnMapping['lastName']! < row.length
          ? row[_columnMapping['lastName']!].trim()
          : '';
      final dept = _columnMapping['departmentId']! < row.length
          ? row[_columnMapping['departmentId']!].trim()
          : '';
      final site = _columnMapping['siteId']! < row.length
          ? row[_columnMapping['siteId']!].trim()
          : '';
      final org = _columnMapping['organizationId']! < row.length
          ? row[_columnMapping['organizationId']!].trim()
          : '';
      final job = _columnMapping['jobRoleId']! < row.length
          ? row[_columnMapping['jobRoleId']!].trim()
          : '';
      csvLines.add('$email,$first,$last,$dept,$site,$org,$job');
    }

    final csv = csvLines.join('\n');
    final csvBase64 = base64Encode(utf8.encode(csv));

    try {
      final res = await client.admin.bulkImportUsers(
        csvBase64: csvBase64,
        assignedById: _assignedById,
        dueDate: DateTime.now().add(const Duration(days: 30)),
      );
      if (mounted) {
        ref.invalidate(departmentComplianceSummaryProvider);
        ref.invalidate(usersProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Imported ${res.imported} users. Errors: ${res.errors.length}')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Import failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Bulk Import Employees',
      icon: Icons.upload_file_rounded,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ADM-WF-06: Bulk Import',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload a CSV with columns: email, firstName, lastName, '
                      'departmentId, siteId, organizationId, jobRoleId. '
                      'Or map your columns below.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.slate600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _importing ? null : _pickFile,
                      icon: const Icon(Icons.upload_file, size: 20),
                      label: Text(_rows.isEmpty ? 'Pick CSV file' : 'Replace file'),
                    ),
                  ],
                ),
              ),
            ),
            if (_headers.isNotEmpty) ...[
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Column mapping',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 16),
                      ..._requiredFields.map((field) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 140,
                                child: Text(field),
                              ),
                              Expanded(
                                child: DropdownButtonFormField<int?>(
                                  value: _columnMapping[field],
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                        value: null, child: Text('-- Not mapped')),
                                    ...List.generate(_headers.length, (i) {
                                      return DropdownMenuItem(
                                        value: i,
                                        child: Text(
                                            'Col ${i + 1}: ${_headers[i]}'),
                                      );
                                    }),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      _columnMapping = Map.from(_columnMapping);
                                      _columnMapping[field] = v;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Validation preview (${_rows.length} rows)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          if (_rows.isNotEmpty)
                            FilledButton.icon(
                              onPressed: _importing ? null : _import,
                              icon: _importing
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : const Icon(Icons.check, size: 18),
                              label: Text(_importing ? 'Importing...' : 'Confirm import'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (_rows.isEmpty)
                        const EmptyState(
                          message: 'No data rows',
                          icon: Icons.table_chart_outlined,
                        )
                      else
                        SizedBox(
                          height: 320,
                          child: PlutoGrid(
                            columns: [
                              ...List.generate(_headers.length, (i) {
                                return PlutoColumn(
                                  title: _headers[i].isEmpty ? 'Col ${i + 1}' : _headers[i],
                                  field: 'col_$i',
                                  type: PlutoColumnType.text(),
                                  width: 120,
                                );
                              }),
                              PlutoColumn(
                                title: 'Validation',
                                field: 'validation',
                                type: PlutoColumnType.text(),
                                width: 200,
                                readOnly: true,
                              ),
                            ],
                            rows: List.generate(_rows.length, (i) {
                              final row = _rows[i];
                              final err = _validateRow(i, row);
                              final cells = <String, PlutoCell>{
                                for (var c = 0; c < _headers.length; c++)
                                  'col_$c': PlutoCell(
                                    value: c < row.length ? row[c] : '',
                                  ),
                                'validation': PlutoCell(
                                  value: err ?? 'OK',
                                ),
                              };
                              return PlutoRow(
                                cells: cells,
                              );
                            }),
                            configuration: PlutoGridConfiguration(
                              style: PlutoGridStyleConfig(
                                gridBorderColor: AppColors.slate200,
                                cellTextStyle: Theme.of(context).textTheme.bodySmall ?? const TextStyle(),
                              ),
                            ),
                            noRowsWidget: const Center(child: Text('No rows')),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
