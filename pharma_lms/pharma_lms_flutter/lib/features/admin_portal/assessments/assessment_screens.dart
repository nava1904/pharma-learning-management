import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show QuestionBank, Question;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// QUESTION BANK SCREEN - Real data from backend
// ═══════════════════════════════════════════════════════════════════════════════

class AdminQuestionBankScreen extends ConsumerStatefulWidget {
  const AdminQuestionBankScreen({super.key});

  @override
  ConsumerState<AdminQuestionBankScreen> createState() => _AdminQuestionBankScreenState();
}

class _AdminQuestionBankScreenState extends ConsumerState<AdminQuestionBankScreen> {
  int? _expandedBankId;

  @override
  Widget build(BuildContext context) {
    final questionBanksAsync = ref.watch(adminQuestionBanksProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(context),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Question Banks Grid
          questionBanksAsync.when(
            data: (banks) => _buildQuestionBanksGrid(banks),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question Bank', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Manage centralized assessment questions and tags',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => _showCreateBankDialog(context),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Bank'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionBanksGrid(List<QuestionBank> banks) {
    if (banks.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.quiz_outlined, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No question banks found',
                style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textTertiary),
              ),
              SizedBox(height: PharmaSpacing.md),
              ElevatedButton.icon(
                onPressed: () => _showCreateBankDialog(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create First Bank'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: banks.map((bank) => _buildQuestionBankCard(bank)).toList(),
    );
  }

  Widget _buildQuestionBankCard(QuestionBank bank) {
    final isExpanded = _expandedBankId == bank.id;
    
    return Container(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: isExpanded ? PharmaColors.emerald500 : PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        children: [
          // Bank Header
          InkWell(
            onTap: () => setState(() {
              _expandedBankId = isExpanded ? null : bank.id;
            }),
            borderRadius: BorderRadius.circular(PharmaRadius.md),
            child: Padding(
              padding: EdgeInsets.all(PharmaSpacing.cardPadding),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald50,
                      borderRadius: BorderRadius.circular(PharmaRadius.sm),
                    ),
                    child: Icon(Icons.quiz_outlined, color: PharmaColors.emerald600, size: 24),
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bank.name, style: PharmaTypography.headingSmall),
                        SizedBox(height: PharmaSpacing.xs),
                        Row(
                          children: [
                            _buildTagChip('Organization #${bank.organizationId}'),
                            if (bank.tagsJson != null) ...[
                              SizedBox(width: PharmaSpacing.sm),
                              _buildTagChip(bank.tagsJson!),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: PharmaColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
          
          // Expanded Questions List
          if (isExpanded && bank.id != null)
            _buildQuestionsSection(bank.id!),
        ],
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: PharmaColors.gray100,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(tag, style: PharmaTypography.caption),
    );
  }

  Widget _buildQuestionsSection(int bankId) {
    final questionsAsync = ref.watch(adminQuestionsProvider(bankId));
    
    return questionsAsync.when(
      data: (questions) => _buildQuestionsList(questions, bankId),
      loading: () => Padding(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => Padding(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Text('Error loading questions: $e'),
      ),
    );
  }

  Widget _buildQuestionsList(List<Question> questions, int bankId) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.gray50,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(PharmaRadius.md)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${questions.length} Questions',
                style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showImportQuestionsDialog(bankId),
                    icon: const Icon(Icons.upload_file, size: 16),
                    label: const Text('Import'),
                  ),
                  SizedBox(width: PharmaSpacing.sm),
                  ElevatedButton.icon(
                    onPressed: () => _showAddQuestionDialog(bankId),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PharmaColors.emerald600,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          if (questions.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(PharmaSpacing.lg),
                child: Text(
                  'No questions in this bank yet',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                ),
              ),
            )
          else
            ...questions.take(10).map((q) => _buildQuestionRow(q)),
          if (questions.length > 10)
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to full questions view
                },
                child: Text('View all ${questions.length} questions'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(Question question) {
    final qType = question.questionType;
    
    return Container(
      margin: EdgeInsets.only(bottom: PharmaSpacing.sm),
      padding: EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _getQuestionTypeColor(qType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(
              _getQuestionTypeIcon(qType),
              size: 16,
              color: _getQuestionTypeColor(qType),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.text,
                  style: PharmaTypography.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: PharmaSpacing.xs),
                Row(
                  children: [
                    _buildTagChip(qType.toUpperCase()),
                    if (question.difficulty != null) ...[
                      SizedBox(width: PharmaSpacing.sm),
                      _buildTagChip(question.difficulty!),
                    ],
                    if (question.regulatoryTag != null) ...[
                      SizedBox(width: PharmaSpacing.sm),
                      _buildTagChip(question.regulatoryTag!),
                    ],
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18),
            onPressed: () {},
            tooltip: 'Edit Question',
          ),
        ],
      ),
    );
  }

  IconData _getQuestionTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'mcq':
      case 'multiple_choice':
        return Icons.radio_button_checked;
      case 'true_false':
        return Icons.check_box;
      case 'fill_blank':
        return Icons.text_fields;
      case 'essay':
        return Icons.notes;
      default:
        return Icons.help_outline;
    }
  }

  Color _getQuestionTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'mcq':
      case 'multiple_choice':
        return PharmaColors.info;
      case 'true_false':
        return PharmaColors.success;
      case 'fill_blank':
        return PharmaColors.warning;
      case 'essay':
        return PharmaColors.purple;
      default:
        return PharmaColors.textTertiary;
    }
  }

  void _showCreateBankDialog(BuildContext context) {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Question Bank'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Bank Name',
            hintText: 'e.g., GMP Fundamentals Questions',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Call create endpoint
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Creating question bank: ${nameController.text}')),
              );
              ref.invalidate(adminQuestionBanksProvider);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showImportQuestionsDialog(int bankId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Questions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Import questions from CSV or JSON file'),
            SizedBox(height: PharmaSpacing.md),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // TODO: File picker
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Select File'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAddQuestionDialog(int bankId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Question'),
        content: const Text('Question builder coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Failed to load question banks', style: PharmaTypography.bodyMedium),
            Text(error, style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton(
              onPressed: () => ref.invalidate(adminQuestionBanksProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ASSESSMENT LIST SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAssessmentListScreen extends StatelessWidget {
  const AdminAssessmentListScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AssessmentTemplate(
        title: 'Assessments',
        subtitle: 'Track assessment versions and publishing states.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE ASSESSMENT SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAssessmentCreateScreen extends StatelessWidget {
  const AdminAssessmentCreateScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AssessmentTemplate(
        title: 'Create Assessment',
        subtitle: 'Build and approve assessments for courses.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ATTEMPT REVIEW SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAttemptReviewScreen extends StatelessWidget {
  const AdminAttemptReviewScreen({super.key});
  @override
  Widget build(BuildContext context) => const _AssessmentTemplate(
        title: 'Attempt Review',
        subtitle: 'Review learner attempts and manual grading actions.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// PLACEHOLDER TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════════

class _AssessmentTemplate extends StatelessWidget {
  const _AssessmentTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Coming Soon',
            child: AdminPlaceholderTable(
              columns: ['Feature', 'Status', 'ETA'],
              rows: [
                ['Full implementation', 'In Progress', 'Q2 2026'],
              ],
            ),
          ),
        ],
      );
}
