import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import 'widgets/trainer_page_scaffold.dart';

class GradingScreen extends ConsumerStatefulWidget {
  const GradingScreen({super.key, required this.assessmentId});

  final int assessmentId;

  @override
  ConsumerState<GradingScreen> createState() => _GradingScreenState();
}

class _GradingScreenState extends ConsumerState<GradingScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<AssessmentResult> _ungradedResults = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final results = await client.assessment.listUngradedResults(
        assessmentId: widget.assessmentId,
      );
      if (!mounted) return;
      setState(() {
        _ungradedResults = results;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _gradeResult(
    AssessmentResult result, {
    required bool correct,
    int? manualScore,
  }) async {
    try {
      await client.assessment.gradeResult(
        resultId: result.id!,
        correct: correct,
        manualScore: manualScore,
      );
      _showSnackBar('Response graded successfully');
      _loadData();
    } catch (e) {
      _showSnackBar('Grading failed: $e', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? PharmaColors.danger : PharmaColors.emerald600,
      ),
    );
  }

  void _showGradeDialog(AssessmentResult result) {
    final scoreController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Grade Response'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question',
                style: PharmaTypography.labelMedium
                    .copyWith(color: PharmaColors.textTertiary),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PharmaColors.gray50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  result.question?.text ?? 'Unknown question',
                  style: PharmaTypography.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Type',
                style: PharmaTypography.labelMedium
                    .copyWith(color: PharmaColors.textTertiary),
              ),
              const SizedBox(height: 4),
              Chip(
                label: Text(
                  result.question?.questionType ?? 'unknown',
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: PharmaColors.info.withAlpha(30),
              ),
              const SizedBox(height: 16),
              Text(
                'Learner\'s Answer',
                style: PharmaTypography.labelMedium
                    .copyWith(color: PharmaColors.textTertiary),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: SelectableText(
                  result.answer,
                  style: PharmaTypography.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: scoreController,
                decoration: const InputDecoration(
                  labelText: 'Score (optional)',
                  hintText: 'e.g. 8 out of 10',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _gradeResult(
                result,
                correct: false,
                manualScore: int.tryParse(scoreController.text),
              );
            },
            icon: const Icon(Icons.close, size: 16),
            label: const Text('Incorrect'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PharmaColors.danger,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _gradeResult(
                result,
                correct: true,
                manualScore: int.tryParse(scoreController.text),
              );
            },
            icon: const Icon(Icons.check, size: 16),
            label: const Text('Correct'),
            style: ElevatedButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TrainerPageScaffold(
      title: 'Grading Queue',
      icon: Icons.grading_rounded,
      scrollable: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _loadData,
          tooltip: 'Refresh',
        ),
      ],
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const TrainerPageLoading(cardCount: 3);
    }
    if (_errorMessage != null) {
      return TrainerPageError(
        message: _errorMessage!,
        onRetry: _loadData,
      );
    }
    if (_ungradedResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline,
                color: PharmaColors.emerald600, size: 64),
            const SizedBox(height: 16),
            Text('All caught up!', style: PharmaTypography.headingSmall),
            const SizedBox(height: 8),
            Text(
              'No open-ended or short-answer responses need grading.',
              style: PharmaTypography.bodyMedium
                  .copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _ungradedResults.length,
      itemBuilder: (context, index) {
        final result = _ungradedResults[index];
        return _buildResultCard(result, index);
      },
    );
  }

  Widget _buildResultCard(AssessmentResult result, int index) {
    final question = result.question;
    final attempt = result.attempt;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PharmaColors.info.withAlpha(25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '#${index + 1}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: PharmaColors.info,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    question?.questionType ?? 'unknown',
                    style: const TextStyle(fontSize: 11),
                  ),
                  backgroundColor: question?.questionType == 'open_ended'
                      ? Colors.purple.shade50
                      : Colors.orange.shade50,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                const Spacer(),
                if (attempt != null)
                  Text(
                    'User #${attempt.userId}',
                    style: TextStyle(
                      fontSize: 12,
                      color: PharmaColors.textTertiary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question?.text ?? 'Unknown question',
              style: PharmaTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learner\'s Response:',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    result.answer,
                    style: PharmaTypography.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _gradeResult(result, correct: false),
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Incorrect'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.danger,
                    side: BorderSide(color: PharmaColors.danger),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _showGradeDialog(result),
                  icon: const Icon(Icons.grading, size: 16),
                  label: const Text('Review & Grade'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PharmaColors.info,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _gradeResult(result, correct: true),
                  icon: const Icon(Icons.check, size: 16),
                  label: const Text('Correct'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
