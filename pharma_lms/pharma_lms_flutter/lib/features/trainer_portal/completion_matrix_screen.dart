// ═══════════════════════════════════════════════════════════════════════════════
// COMPLETION MATRIX — employees × courses (CSV + on-screen grid)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/reports/completion-matrix
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';
import 'widgets/trainer_page_scaffold.dart';

class CompletionMatrixScreen extends ConsumerStatefulWidget {
  const CompletionMatrixScreen({super.key});

  @override
  ConsumerState<CompletionMatrixScreen> createState() =>
      _CompletionMatrixScreenState();
}

class _CompletionMatrixScreenState
    extends ConsumerState<CompletionMatrixScreen> {
  bool _loading = false;
  String? _error;
  List<List<String>>? _grid;
  bool _exporting = false;

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      final csv = await client.analytics.exportCompletionMatrixCsv(
        organizationId: user?.organizationId,
      );
      final rows = const CsvToListConverter().convert(csv);
      final grid = rows
          .map((r) => r.map((c) => c.toString()).toList())
          .toList();
      if (mounted) {
        setState(() {
          _grid = grid;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = '$e';
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveFile() async {
    final user = await ref.read(currentUserProvider.future);
    setState(() => _exporting = true);
    try {
      final csv = await client.analytics.exportCompletionMatrixCsv(
        organizationId: user?.organizationId,
      );
      final bytes = Uint8List.fromList(utf8.encode(csv));
      await saveBytesToFile(bytes, 'completion_matrix.csv');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved completion_matrix.csv')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/trainer/reports'),
              icon: const Icon(Icons.arrow_back, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Completion matrix',
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Employees × courses — enrollment status per cell',
                    style: PharmaTypography.body
                        .copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
            ),
            OutlinedButton.icon(
              onPressed: _loading ? null : _load,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: _exporting ? null : _saveFile,
              icon: _exporting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: PharmaColors.cardBg,
                      ),
                    )
                  : const Icon(Icons.download, size: 18),
              label: const Text('Save CSV'),
              style:
                  FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (_loading)
          const TrainerPageLoading(cardCount: 3)
        else if (_error != null)
          TrainerPageError(message: _error!, onRetry: _load)
        else if (_grid == null || _grid!.isEmpty)
          Text('No data.', style: PharmaTypography.body)
        else
          Container(
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(color: PharmaColors.borderLight),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 40,
                  dataRowMinHeight: 36,
                  dataRowMaxHeight: 44,
                  columnSpacing: 12,
                  columns: _grid!.first
                      .map(
                        (h) => DataColumn(
                          label: Text(
                            h,
                            style: PharmaTypography.labelMedium.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  rows: _grid!.skip(1).take(40).map((cells) {
                    return DataRow(
                      cells: cells
                          .map(
                            (c) => DataCell(
                              Text(
                                c,
                                style: PharmaTypography.caption.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        if (_grid != null && _grid!.length > 41)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Showing first 40 employees — full list in CSV export.',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary),
            ),
          ),
      ],
    );
  }
}
