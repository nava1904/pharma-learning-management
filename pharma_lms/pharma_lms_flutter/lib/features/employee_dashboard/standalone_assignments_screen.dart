import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import 'widgets/employee_page_scaffold.dart';

final _myStandaloneRecipientsProvider =
    FutureProvider.autoDispose<List<StandaloneAssignmentRecipient>>((ref) async {
  return client.standaloneAssignment.listMyStandaloneAssignmentRecipients();
});

/// Employee list: standalone assignment tasks (not course training assignments).
class EmployeeStandaloneAssignmentsScreen extends ConsumerWidget {
  const EmployeeStandaloneAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_myStandaloneRecipientsProvider);

    return async.when(
      loading: () => const EmployeePageLoading(cardCount: 4),
      error: (e, _) => EmployeePageError(
        message: '$e',
        onRetry: () => ref.invalidate(_myStandaloneRecipientsProvider),
      ),
      data: (rows) {
        if (rows.isEmpty) {
          return const EmployeePageEmpty(
            title: 'No standalone assignments yet',
            subtitle: 'When a trainer assigns you a task here, it will appear in this list.',
            icon: Icons.task_alt,
          );
        }
        return EmployeePageScaffold(
          title: 'Assignments',
          subtitle: '${rows.length} task${rows.length == 1 ? '' : 's'}',
          icon: Icons.task_alt_rounded,
          onRefresh: () async => ref.invalidate(_myStandaloneRecipientsProvider),
          scrollable: false,
          child: ListView.separated(
              padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
              itemCount: rows.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final r = rows[i];
                final a = r.assignment;
                final title = a?.title ?? 'Assignment #${r.assignmentId}';
                final due = a?.dueAt;
                final overdue =
                    due != null && due.isBefore(DateTime.now()) && r.status == 'pending';
                return Card(
                  margin: EdgeInsets.zero,
                  color: PharmaColors.cardBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: PharmaRadius.cardRadius,
                    side: BorderSide(color: PharmaColors.borderLight),
                  ),
                  child: ListTile(
                    title: Text(title, style: PharmaTypography.bodyMedium),
                    subtitle: Text(
                      [
                        if (due != null)
                          'Due ${DateFormat.yMMMd().format(due)}${overdue ? ' (overdue)' : ''}',
                        'Status: ${r.status}',
                      ].join(' · '),
                      style: PharmaTypography.caption,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      if (r.id != null) {
                        context.push('/employee/standalone-assignments/${r.id}');
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      );
  }
}

/// Detail + submit response for one recipient row.
class EmployeeStandaloneAssignmentDetailScreen extends ConsumerStatefulWidget {
  const EmployeeStandaloneAssignmentDetailScreen({super.key, required this.recipientId});

  final int recipientId;

  @override
  ConsumerState<EmployeeStandaloneAssignmentDetailScreen> createState() =>
      _EmployeeStandaloneAssignmentDetailScreenState();
}

class _EmployeeStandaloneAssignmentDetailScreenState
    extends ConsumerState<EmployeeStandaloneAssignmentDetailScreen> {
  final _responseCtrl = TextEditingController();
  bool _loading = true;
  bool _submitting = false;
  StandaloneAssignmentRecipient? _row;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _responseCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final r = await client.standaloneAssignment.getStandaloneAssignmentRecipient(
        widget.recipientId,
      );
      if (!mounted) return;
      if (r == null) {
        setState(() {
          _loading = false;
          _error = 'Assignment not found';
        });
        return;
      }
      if (r.responseJson != null && r.responseJson!.isNotEmpty) {
        try {
          final map = jsonDecode(r.responseJson!) as Map<String, dynamic>?;
          final t = map?['text']?.toString();
          if (t != null) _responseCtrl.text = t;
        } catch (_) {}
      }
      setState(() {
        _row = r;
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = '$e';
        });
      }
    }
  }

  Future<void> _submit() async {
    if (_row?.id == null) return;
    final text = _responseCtrl.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your response')),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      final payload = jsonEncode({'text': text});
      await client.standaloneAssignment.submitStandaloneAssignment(
        _row!.id!,
        responseJson: payload,
      );
      if (!mounted) return;
      ref.invalidate(_myStandaloneRecipientsProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted')),
      );
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const EmployeePageLoading(cardCount: 2);
    }
    if (_error != null) {
      return EmployeePageError(
        message: _error!,
        onRetry: _load,
      );
    }
    final r = _row!;
    final a = r.assignment;

    final submitted = r.status == 'submitted';
    final due = a?.dueAt;

    return EmployeePageScaffold(
      title: a?.title ?? 'Assignment',
      subtitle: submitted ? 'Submitted' : 'Pending response',
      icon: Icons.task_alt_rounded,
      actions: [
        TextButton.icon(
          onPressed: () => context.go('/employee/standalone-assignments'),
          icon: const Icon(Icons.arrow_back_rounded, size: 18),
          label: const Text('Back to list'),
        ),
      ],
      scrollable: false,
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          if (due != null)
            Text(
              'Due ${DateFormat.yMMMd().format(due)}',
              style: PharmaTypography.bodyMedium.copyWith(
                color: due.isBefore(DateTime.now()) && !submitted
                    ? PharmaColors.danger
                    : null,
              ),
            ),
          const SizedBox(height: 8),
          if (a?.instructions != null && a!.instructions!.isNotEmpty) ...[
            Text('Instructions', style: PharmaTypography.caption),
            const SizedBox(height: 4),
            Text(a.instructions!, style: PharmaTypography.body),
            const SizedBox(height: 16),
          ],
          Text(
            'Type: ${a?.contentKind ?? '—'}',
            style: PharmaTypography.caption,
          ),
          if (a?.questionBank != null) ...[
            const SizedBox(height: 8),
            Text(
              'Linked question bank: ${a!.questionBank!.name}',
              style: PharmaTypography.caption,
            ),
          ],
          const SizedBox(height: 24),
          Text('Your response', style: PharmaTypography.headingSmall),
          const SizedBox(height: 8),
          TextField(
            controller: _responseCtrl,
            maxLines: 8,
            readOnly: submitted,
            decoration: InputDecoration(
              hintText: submitted
                  ? null
                  : 'Enter your answer or notes. For MCQ campaigns, summarize completion or paste key results.',
              border: const OutlineInputBorder(),
              filled: submitted,
              fillColor: submitted ? PharmaColors.pageBg : null,
            ),
          ),
          const SizedBox(height: 20),
          if (!submitted)
            FilledButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Submit'),
            )
          else
            Text('Submitted', style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.emerald600)),
        ],
      ),
    );
  }
}
