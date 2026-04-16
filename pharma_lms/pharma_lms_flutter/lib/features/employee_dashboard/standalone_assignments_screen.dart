

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import 'widgets/employee_page_scaffold.dart';
import 'utils/inline_question_parser.dart';
import 'widgets/question_response_widgets.dart';
import 'widgets/graded_result_banner.dart';

/// Provider to fetch all standalone assignments for the user, including source info.
final standaloneAssignmentsProvider = FutureProvider.autoDispose<List<StandaloneAssignmentRecipient>>((ref) async {
  // This backend call should return all assignments assigned to the user. If you want to include source info, update the backend to always include it.
  return client.standaloneAssignment.listMyStandaloneAssignmentRecipients();
});

/// Employee list: standalone assignment tasks (from trainer, batch, or admin).
class EmployeeStandaloneAssignmentsScreen extends ConsumerWidget {
  const EmployeeStandaloneAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(standaloneAssignmentsProvider);
    return async.when(
      loading: () => const EmployeePageLoading(cardCount: 4),
      error: (e, _) => EmployeePageError(
        message: '$e',
        onRetry: () => ref.invalidate(standaloneAssignmentsProvider),
      ),
      data: (rows) {
        if (rows.isEmpty) {
          return const EmployeePageEmpty(
            title: 'No assignments yet',
            subtitle: 'Assignments from trainers, batches, or admins will appear here.',
            icon: Icons.task_alt,
          );
        }
        return EmployeePageScaffold(
          title: 'Assignments',
          subtitle: '${rows.length} task${rows.length == 1 ? '' : 's'}',
          icon: Icons.task_alt_rounded,
          onRefresh: () async => ref.invalidate(standaloneAssignmentsProvider),
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
              final overdue = due != null && due.isBefore(DateTime.now()) && r.status == 'pending';
              // Determine source
              String source = '—';
              if (a?.assignedByType == 'trainer') source = 'Trainer';
              else if (a?.assignedByType == 'batch') source = 'Batch';
              else if (a?.assignedByType == 'admin') source = 'Admin';
              return Card(
                margin: EdgeInsets.zero,
                color: PharmaColors.cardBg,
                shape: RoundedRectangleBorder(
                  borderRadius: PharmaRadius.cardRadius,
                  side: BorderSide(color: PharmaColors.borderLight),
                ),
                child: ListTile(
                  title: Text(title, style: PharmaTypography.bodyMedium),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (due != null)
                        Text('Due ${DateFormat.yMMMd().format(due)}${overdue ? ' (overdue)' : ''}', style: PharmaTypography.caption),
                      Text('Status: ${r.status == "graded" ? "Graded (${r.grade}/100)" : r.status}', style: PharmaTypography.caption),
                      Text('Source: $source', style: PharmaTypography.caption),
                    ],
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
  ConsumerState<EmployeeStandaloneAssignmentDetailScreen> createState() => _EmployeeStandaloneAssignmentDetailScreenState();
}

class _EmployeeStandaloneAssignmentDetailScreenState extends ConsumerState<EmployeeStandaloneAssignmentDetailScreen> {
  final Map<int, dynamic> _answers = {};
  final TextEditingController _openEndedCtrl = TextEditingController();
  bool _loading = true;
  bool _submitting = false;
  StandaloneAssignmentRecipient? _row;
  ParsedInstructions? _parsed;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _openEndedCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final r = await client.standaloneAssignment.getStandaloneAssignmentRecipient(widget.recipientId);
      if (!mounted) return;
      if (r == null) {
        setState(() {
          _loading = false;
          _error = 'Assignment not found';
        });
        return;
      }
      _parsed = parseInstructions(r.assignment?.instructions);
      _answers.clear();
      _openEndedCtrl.clear();
      if (r.responseJson != null && r.responseJson!.isNotEmpty) {
        try {
          final map = jsonDecode(r.responseJson!) as Map<String, dynamic>?;
          if (map != null && map['answers'] is List) {
            final answers = map['answers'] as List;
            for (var i = 0; i < answers.length; i++) {
              _answers[i] = answers[i];
            }
          } else if (map != null && map['text'] != null) {
            _openEndedCtrl.text = map['text'].toString();
          }
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
    final hasQuestions = _parsed?.questions.isNotEmpty == true;
    dynamic payload;
    if (hasQuestions) {
      // Validate all questions answered
      for (var i = 0; i < _parsed!.questions.length; i++) {
        final ans = _answers[i];
        if (ans == null || (ans is String && ans.trim().isEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please answer question ${i + 1}')),
          );
          return;
        }
      }
      payload = jsonEncode({'answers': List.generate(_parsed!.questions.length, (i) => _answers[i])});
    } else {
      final text = _openEndedCtrl.text.trim();
      if (text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter your response')),
        );
        return;
      }
      payload = jsonEncode({'text': text});
    }
    setState(() => _submitting = true);
    try {
      await client.standaloneAssignment.submitStandaloneAssignment(
        _row!.id!,
        responseJson: payload,
      );
      if (!mounted) return;
      ref.invalidate(standaloneAssignmentsProvider);
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
    final due = a?.dueAt;
    final graded = r.status == 'graded';
    final submitted = r.status == 'submitted';
    final pending = r.status == 'pending';
    final hasQuestions = _parsed?.questions.isNotEmpty == true;
    return EmployeePageScaffold(
      title: a?.title ?? 'Assignment',
      subtitle: graded
          ? 'Graded'
          : submitted
              ? 'Awaiting review'
              : 'Pending response',
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
                color: due.isBefore(DateTime.now()) && pending ? PharmaColors.danger : null,
              ),
            ),
          const SizedBox(height: 8),
          if (_parsed?.plainText.isNotEmpty == true) ...[
            Text('Instructions', style: PharmaTypography.caption),
            const SizedBox(height: 4),
            Text(_parsed!.plainText, style: PharmaTypography.body),
            const SizedBox(height: 16),
          ],
          Text('Type: ${a?.contentKind ?? '—'}', style: PharmaTypography.caption),
          if (graded)
            GradedResultBanner(
              grade: r.grade,
              feedback: r.feedback,
              gradedAt: r.gradedAt,
            ),
          if (hasQuestions)
            ...List.generate(_parsed!.questions.length, (i) {
              final q = _parsed!.questions[i];
              final answer = _answers[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: buildQuestionWidget(
                  question: q,
                  questionNumber: i + 1,
                  currentAnswer: answer,
                  onChanged: graded || submitted
                      ? (_) {}
                      : (val) => setState(() => _answers[i] = val),
                  readOnly: graded || submitted,
                ),
              );
            }),
          if (!hasQuestions) ...[
            const SizedBox(height: 24),
            Text('Your response', style: PharmaTypography.headingSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _openEndedCtrl,
              maxLines: 8,
              readOnly: graded || submitted,
              decoration: InputDecoration(
                hintText: graded || submitted ? null : 'Enter your answer or notes.',
                border: const OutlineInputBorder(),
                filled: graded || submitted,
                fillColor: graded || submitted ? PharmaColors.pageBg : null,
              ),
            ),
          ],
          const SizedBox(height: 20),
          if (pending)
            FilledButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Submit'),
            ),
          if (submitted && !graded)
            Text('Submitted, awaiting review', style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.emerald600)),
          if (graded)
            Text('Graded', style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.emerald600)),
        ],
      ),
    );
  }
}
