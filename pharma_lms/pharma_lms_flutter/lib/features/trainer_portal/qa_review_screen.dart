import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';

/// Where this screen is shown: trainer workflow vs QA sign-off in the QA Portal shell.
enum CourseQaReviewMode {
  /// Trainer Portal: submit for QA, validation — no approve/reject checklist.
  trainer,
  /// QA Portal shell: full checklist and approval actions.
  qa,
}

class QAReviewScreen extends ConsumerStatefulWidget {
  const QAReviewScreen({
    super.key,
    required this.courseId,
    this.mode = CourseQaReviewMode.trainer,
  });

  final int courseId;
  final CourseQaReviewMode mode;

  @override
  ConsumerState<QAReviewScreen> createState() => _QAReviewScreenState();
}

class _QAReviewScreenState extends ConsumerState<QAReviewScreen> {
  bool _materialsAccurate = false;
  bool _mediaWorks = false;
  bool _assessmentsValid = false;
  final _commentsController = TextEditingController();
  final _rejectionReasonController = TextEditingController();

  bool _isLoading = true;
  String? _error;
  bool _isSubmitting = false;

  Course? _course;
  List<CourseVersion> _versions = [];
  CourseVersion? _latestVersion;
  List<Module> _modules = [];
  Map<int, List<Lesson>> _lessonsByModule = {};
  int _totalLessons = 0;
  Assessment? _assessment;
  int _questionCount = 0;
  QaValidationResult? _validationResult;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _commentsController.dispose();
    _rejectionReasonController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final course = await client.course.getCourse(widget.courseId);
      if (course == null) {
        setState(() {
          _error = 'Course not found (ID: ${widget.courseId})';
          _isLoading = false;
        });
        return;
      }

      final versions = await client.course.getCourseVersions(widget.courseId);
      versions.sort((a, b) => b.version.compareTo(a.version));

      CourseVersion? latest;
      if (versions.isNotEmpty) {
        latest = versions.firstWhere(
          (v) => v.status != 'obsolete',
          orElse: () => versions.first,
        );
      }

      List<Module> modules = [];
      Map<int, List<Lesson>> lessonsByModule = {};
      int totalLessons = 0;
      Assessment? assessment;
      int questionCount = 0;
      QaValidationResult? validationResult;

      if (latest?.id != null) {
        final futures = await Future.wait([
          client.course.getModulesForCourseVersion(latest!.id!),
          client.assessment.getAssessmentForCourse(latest.id!),
          client.courseBuilder.validateForQaSubmission(courseVersionId: latest.id!),
        ]);

        modules = futures[0] as List<Module>;
        assessment = futures[1] as Assessment?;
        validationResult = futures[2] as QaValidationResult;

        final lessonFutures = await Future.wait(
          modules
              .where((m) => m.id != null)
              .map((m) => client.course.getLessonsForModule(m.id!)),
        );

        for (int i = 0; i < modules.length; i++) {
          if (modules[i].id != null && i < lessonFutures.length) {
            final lessons = lessonFutures[i];
            lessonsByModule[modules[i].id!] = lessons;
            totalLessons += lessons.length;
          }
        }

        if (assessment != null) {
          final questions =
              await client.assessment.getQuestions(assessment.questionBankId);
          questionCount = questions.length;
        }
      }

      if (!mounted) return;

      setState(() {
        _course = course;
        _versions = versions;
        _latestVersion = latest;
        _modules = modules;
        _lessonsByModule = lessonsByModule;
        _totalLessons = totalLessons;
        _assessment = assessment;
        _questionCount = questionCount;
        _validationResult = validationResult;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load course data: $e';
        _isLoading = false;
      });
    }
  }

  String get _currentStatus => _latestVersion?.status ?? 'draft';

  bool get _canSubmit =>
      _currentStatus == 'draft' || _currentStatus == 'needs_revision';

  bool get _isUnderReview =>
      _currentStatus == 'under_review' ||
      _currentStatus == 'pending_qa' ||
      _currentStatus == 'pending_approval';

  bool get _allChecked =>
      _materialsAccurate && _mediaWorks && _assessmentsValid;

  bool get _validationPassed {
    if (_validationResult == null) return false;
    return _validationResult!.allPassed;
  }

  List<String> get _validationErrors {
    if (_validationResult == null) return [];
    return _validationResult!.validationResults
        .where((r) => !r.passed)
        .map((r) => '${r.rule}: ${r.detail}')
        .toList();
  }

  Future<void> _submitForReview() async {
    if (_latestVersion?.id == null) return;

    setState(() => _isSubmitting = true);
    try {
      final updated =
          await client.courseBuilder.submitForQaReview(courseVersionId: _latestVersion!.id!);
      if (!mounted) return;
      setState(() {
        _latestVersion = updated;
        final idx = _versions.indexWhere((v) => v.id == updated.id);
        if (idx >= 0) {
          _versions[idx] = updated;
        }
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Course submitted for QA review'),
          backgroundColor: PharmaColors.emerald600,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submission failed: $e'),
          backgroundColor: PharmaColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
              const SizedBox(height: 16),
              Text(_error!,
                  style: PharmaTypography.body, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry'),
                style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600),
              ),
            ],
          ),
        ),
      );
    }

    if (_course == null || _latestVersion == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open, size: 48, color: PharmaColors.gray400),
            const SizedBox(height: 16),
            Text(
              'No course version found for this course.',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () =>
                  context.go('/trainer/courses/${widget.courseId}/builder'),
              child: const Text('Go to Course Builder'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(),
          const SizedBox(height: PharmaSpacing.sectionGap),
          _buildStepper(),
          const SizedBox(height: PharmaSpacing.sectionGap),
          if (_canSubmit && widget.mode == CourseQaReviewMode.trainer) ...[
            _buildStatusBanner(),
            const SizedBox(height: PharmaSpacing.sectionGap),
          ],
          _buildPreSubmissionChecklist(),
          const SizedBox(height: PharmaSpacing.sectionGap),
          _buildContentBreakdown(),
          const SizedBox(height: PharmaSpacing.sectionGap),
          LayoutBuilder(
            builder: (context, constraints) {
              final rightPanel = widget.mode == CourseQaReviewMode.qa
                  ? _buildQAReviewPanel()
                  : _buildTrainerQaPortalNotice();
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildVersionHistoryPanel()),
                    const SizedBox(width: PharmaSpacing.gridGap),
                    Expanded(flex: 2, child: rightPanel),
                  ],
                );
              }
              return Column(
                children: [
                  _buildVersionHistoryPanel(),
                  const SizedBox(height: PharmaSpacing.sectionGap),
                  rightPanel,
                ],
              );
            },
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),
          if (_canSubmit && widget.mode == CourseQaReviewMode.trainer) _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTrainerQaPortalNotice() {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: PharmaColors.info),
                const SizedBox(width: 8),
                Text(
                  'QA approval',
                  style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Formal QA sign-off (review checklist, request changes, approve, or reject) '
              'is performed in the QA Portal by authorized reviewers.',
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => context.go('/qa/dashboard'),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Open QA Command Center'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.info,
                side: BorderSide(color: PharmaColors.info.withValues(alpha: 0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (widget.mode == CourseQaReviewMode.qa) {
              context.go('/qa/dashboard');
            } else {
              context.go('/trainer/courses/${widget.courseId}/builder');
            }
          },
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _course!.title,
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  if (_course!.sopNumber != null) ...[
                    Text(_course!.sopNumber!, style: PharmaTypography.caption),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    'v${_latestVersion!.version}',
                    style: PharmaTypography.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PharmaColors.info,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _StatusChip(status: _currentStatus),
        if (_latestVersion?.id != null) ...[
          const SizedBox(width: 4),
          IconButton(
            tooltip: 'QA discussion thread',
            onPressed: () => openCourseQaThreadForVersion(
              context,
              courseVersionId: _latestVersion!.id!,
              courseTitle: _course!.title,
            ),
            icon: const Icon(Icons.forum_outlined),
          ),
        ],
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            // "Preview as Employee" should show the employee portal course viewer UI.
            // QA review is done per latest course version, so we navigate with that version id.
            final versionId = _latestVersion?.id;
            if (versionId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Unable to resolve latest course version for preview'),
                  backgroundColor: PharmaColors.danger,
                ),
              );
              return;
            }

            context.go(
              '/employee/course/${widget.courseId}',
              extra: <String, dynamic>{'courseVersionId': versionId},
            );
          },
          icon: const Icon(Icons.visibility, size: 16),
          label: const Text('Preview as Employee'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.emerald700,
            side: BorderSide(color: PharmaColors.emerald200),
          ),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    final status = _currentStatus;
    final isUnderReview = status == 'under_review' ||
        status == 'pending_qa' ||
        status == 'pending_approval';
    final isApproved = status == 'approved' || status == 'effective';
    final isRejected = status == 'rejected';
    final isNeedsRevision = status == 'needs_revision';

    final pastReview = isApproved;
    final pastDraft =
        isUnderReview || isApproved || isRejected || isNeedsRevision;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: PharmaSpacing.lg,
        horizontal: PharmaSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ReviewStepperDot(
            label: isNeedsRevision ? 'NEEDS REVISION' : 'DRAFT',
            icon: isNeedsRevision
                ? Icons.edit_rounded
                : Icons.edit_note_rounded,
            isActive: status == 'draft' || isNeedsRevision,
            isCompleted: pastDraft && !isNeedsRevision,
            color:
                isNeedsRevision ? PharmaColors.warning : PharmaColors.gray500,
          ),
          _StepLine(isCompleted: pastDraft),
          _ReviewStepperDot(
            label: isRejected ? 'REJECTED' : 'UNDER REVIEW',
            icon: isRejected
                ? Icons.cancel_rounded
                : Icons.person_search_rounded,
            isActive: isUnderReview,
            isCompleted: pastReview,
            color: isRejected ? PharmaColors.danger : PharmaColors.warning,
          ),
          _StepLine(isCompleted: isApproved),
          _ReviewStepperDot(
            label: 'QA APPROVED',
            icon: Icons.verified_rounded,
            isActive: isApproved,
            isCompleted: false,
            color: PharmaColors.emerald600,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    final message = _currentStatus == 'needs_revision'
        ? 'This version was sent back for revision. Address the feedback and re-submit when ready.'
        : 'You will not be able to edit course content after submitting for review.';

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.warningBg,
        borderRadius: PharmaRadius.cardRadius,
        border:
            Border.all(color: PharmaColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: PharmaColors.warning, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: PharmaTypography.body
                  .copyWith(color: PharmaColors.warningText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreSubmissionChecklist() {
    final hasModules = _modules.isNotEmpty;
    final hasLessons = _totalLessons > 0;
    final hasAssessment = _assessment != null;
    final hasQuestions = _questionCount > 0;
    final errors = _validationErrors;

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.checklist_rounded,
                    size: 18, color: PharmaColors.info),
                const SizedBox(width: 8),
                Text('Pre-Submission Checklist',
                    style:
                        PharmaTypography.headingSmall.copyWith(fontSize: 15)),
                const Spacer(),
                _validationPassed
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PharmaColors.successBg,
                          borderRadius: PharmaRadius.pillRadius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle,
                                size: 14, color: PharmaColors.successText),
                            const SizedBox(width: 4),
                            Text(
                              'READY',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: PharmaColors.successText,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PharmaColors.warningBg,
                          borderRadius: PharmaRadius.pillRadius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.warning_amber,
                                size: 14, color: PharmaColors.warningText),
                            const SizedBox(width: 4),
                            Text(
                              'INCOMPLETE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: PharmaColors.warningText,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Column(
              children: [
                _ChecklistRow(
                  icon: Icons.view_module,
                  label: 'Modules',
                  value: '${_modules.length}',
                  passed: hasModules,
                ),
                const SizedBox(height: 10),
                _ChecklistRow(
                  icon: Icons.article,
                  label: 'Lessons',
                  value:
                      '$_totalLessons across ${_modules.length} module${_modules.length == 1 ? '' : 's'}',
                  passed: hasLessons,
                ),
                const SizedBox(height: 10),
                _ChecklistRow(
                  icon: Icons.quiz,
                  label: 'Assessment',
                  value: hasAssessment
                      ? 'Configured (pass: ${_assessment!.passingScore}%)'
                      : 'Not configured',
                  passed: hasAssessment,
                ),
                const SizedBox(height: 10),
                _ChecklistRow(
                  icon: Icons.help_outline,
                  label: 'Questions',
                  value: hasQuestions ? '$_questionCount questions' : 'None',
                  passed: hasQuestions,
                ),
                if (_assessment != null &&
                    _assessment!.timeLimitMinutes != null) ...[
                  const SizedBox(height: 10),
                  _ChecklistRow(
                    icon: Icons.timer,
                    label: 'Time Limit',
                    value: '${_assessment!.timeLimitMinutes} minutes',
                    passed: true,
                  ),
                ],
                if (_assessment != null &&
                    _assessment!.maxAttempts != null) ...[
                  const SizedBox(height: 10),
                  _ChecklistRow(
                    icon: Icons.replay,
                    label: 'Max Attempts',
                    value: _assessment!.maxAttempts == 0
                        ? 'Unlimited'
                        : '${_assessment!.maxAttempts}',
                    passed: true,
                  ),
                ],
                if (errors.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PharmaColors.dangerBg,
                      borderRadius: PharmaRadius.cardRadius,
                      border: Border.all(
                          color: PharmaColors.danger.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VALIDATION ERRORS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: PharmaColors.dangerText,
                            letterSpacing: 0.7,
                          ),
                        ),
                        const SizedBox(height: 6),
                        for (final err in errors)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.close,
                                    size: 14, color: PharmaColors.danger),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    err,
                                    style: PharmaTypography.caption.copyWith(
                                        color: PharmaColors.dangerText),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentBreakdown() {
    if (_modules.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.account_tree_rounded,
                    size: 18, color: PharmaColors.emerald600),
                const SizedBox(width: 8),
                Text('Content Breakdown',
                    style:
                        PharmaTypography.headingSmall.copyWith(fontSize: 15)),
                const Spacer(),
                Text(
                  '${_modules.length} module${_modules.length == 1 ? '' : 's'} · $_totalLessons lesson${_totalLessons == 1 ? '' : 's'}',
                  style: PharmaTypography.caption,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          for (int i = 0; i < _modules.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PharmaSpacing.lg,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: PharmaColors.emerald700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _modules[i].title,
                      style: PharmaTypography.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${_lessonsByModule[_modules[i].id]?.length ?? 0} lesson${(_lessonsByModule[_modules[i].id]?.length ?? 0) == 1 ? '' : 's'}',
                    style: PharmaTypography.caption,
                  ),
                ],
              ),
            ),
            if (i < _modules.length - 1)
              Divider(
                height: 1,
                color: PharmaColors.borderLight,
                indent: PharmaSpacing.lg,
                endIndent: PharmaSpacing.lg,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildVersionHistoryPanel() {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.history, size: 18, color: PharmaColors.info),
                const SizedBox(width: 8),
                Text('Version History',
                    style:
                        PharmaTypography.headingSmall.copyWith(fontSize: 15)),
                const Spacer(),
                Text(
                  '${_versions.length} version${_versions.length == 1 ? '' : 's'}',
                  style: PharmaTypography.caption,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          if (_versions.isEmpty)
            Padding(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              child: Text('No versions yet.', style: PharmaTypography.body),
            )
          else
            for (final version in _versions)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.lg,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: version.id == _latestVersion?.id
                            ? PharmaColors.infoBg
                            : PharmaColors.gray100,
                        borderRadius: PharmaRadius.pillRadius,
                      ),
                      child: Text(
                        'v${version.version}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: version.id == _latestVersion?.id
                              ? PharmaColors.infoText
                              : PharmaColors.gray600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            version.changeSummary ?? 'Initial version',
                            style: PharmaTypography.body,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (version.effectiveDate != null)
                            Text(
                              'Effective: ${_formatDate(version.effectiveDate!)}',
                              style: PharmaTypography.caption,
                            ),
                          if (version.obsoleteDate != null)
                            Text(
                              'Obsolete: ${_formatDate(version.obsoleteDate!)}',
                              style: PharmaTypography.caption.copyWith(
                                  color: PharmaColors.danger),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _StatusChip(status: version.status),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildQAReviewPanel() {
    final userAsync = ref.watch(currentUserProvider);
    final currentUser = userAsync.valueOrNull;

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.fact_check,
                    size: 18, color: PharmaColors.emerald600),
                const SizedBox(width: 8),
                Text('QA Review',
                    style:
                        PharmaTypography.headingSmall.copyWith(fontSize: 15)),
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          Padding(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: PharmaColors.emerald100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          currentUser != null
                              ? '${currentUser.firstName[0]}${currentUser.lastName[0]}'
                              : 'QA',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: PharmaColors.emerald700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser != null
                              ? '${currentUser.firstName} ${currentUser.lastName}'
                              : 'QA Reviewer',
                          style: PharmaTypography.bodyMedium,
                        ),
                        Text(
                          currentUser?.jobRole?.name ?? 'Reviewer',
                          style: PharmaTypography.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: PharmaSpacing.lg),
                Text(
                  'REVIEW CHECKLIST',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: PharmaColors.textQuaternary,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 8),
                _ChecklistItem(
                  label: 'All course materials are accurate and up-to-date',
                  checked: _materialsAccurate,
                  onChanged: _isUnderReview
                      ? (v) => setState(() => _materialsAccurate = v ?? false)
                      : null,
                ),
                _ChecklistItem(
                  label: 'Audio/video materials play correctly without issue',
                  checked: _mediaWorks,
                  onChanged: _isUnderReview
                      ? (v) => setState(() => _mediaWorks = v ?? false)
                      : null,
                ),
                _ChecklistItem(
                  label:
                      'Assessments have correct answers and valid passing criteria',
                  checked: _assessmentsValid,
                  onChanged: _isUnderReview
                      ? (v) =>
                          setState(() => _assessmentsValid = v ?? false)
                      : null,
                ),
                const SizedBox(height: PharmaSpacing.lg),
                Text(
                  'QA COMMENTS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: PharmaColors.textQuaternary,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _commentsController,
                  maxLines: 4,
                  enabled: _isUnderReview,
                  decoration: InputDecoration(
                    hintText: _isUnderReview
                        ? 'Add review comments...'
                        : 'Review comments disabled until course is under review',
                    hintStyle: PharmaTypography.body
                        .copyWith(color: PharmaColors.textQuaternary),
                    filled: true,
                    fillColor: PharmaColors.pageBg,
                    border: OutlineInputBorder(
                      borderRadius: PharmaRadius.inputRadius,
                      borderSide:
                          BorderSide(color: PharmaColors.borderLight),
                    ),
                  ),
                  style: PharmaTypography.body,
                ),
                const SizedBox(height: PharmaSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isUnderReview
                            ? () => _showRequestChangesDialog()
                            : null,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PharmaColors.warning,
                          side: BorderSide(color: PharmaColors.warning),
                          padding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Request Changes'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed:
                            _allChecked && _isUnderReview
                                ? () => _showESignatureDialog()
                                : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: PharmaColors.emerald600,
                          padding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Approve'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed:
                        _isUnderReview ? () => _showRejectionDialog() : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PharmaColors.danger,
                      side: BorderSide(color: PharmaColors.danger),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: FilledButton.icon(
        onPressed:
            _validationPassed && !_isSubmitting ? _submitForReview : null,
        icon: _isSubmitting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: PharmaColors.cardBg,
                ),
              )
            : const Icon(Icons.send, size: 18),
        label:
            Text(_isSubmitting ? 'Submitting...' : 'Submit for QA Review'),
        style: FilledButton.styleFrom(
          backgroundColor: PharmaColors.emerald600,
          padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: PharmaTypography.button.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  void _showRequestChangesDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Row(
          children: [
            Icon(Icons.edit_note, color: PharmaColors.warning),
            const SizedBox(width: 8),
            const Text('Return for Changes'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Describe the changes required before this course can be approved.',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Comments for trainer...',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.dispose();
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final comments = controller.text;
              controller.dispose();
              Navigator.pop(ctx);
              try {
                await client.qa.returnCourseForChanges(
                  courseVersionId: _latestVersion!.id!,
                  comments: comments,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Course returned for changes'),
                    backgroundColor: PharmaColors.warning,
                  ),
                );
                _loadData();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed: $e')),
                );
              }
            },
            style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.warning),
            child: const Text('Return for Changes'),
          ),
        ],
      ),
    );
  }

  void _showESignatureDialog() {
    final userAsync = ref.read(currentUserProvider);
    final currentUser = userAsync.valueOrNull;
    final passwordController = TextEditingController();
    final meaningController = TextEditingController(
        text: 'I have reviewed and approve this course');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Row(
          children: [
            Icon(Icons.verified, color: PharmaColors.emerald600),
            const SizedBox(width: 8),
            const Text('E-Signature Required'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By signing, you confirm this course version meets all quality requirements under 21 CFR Part 11.',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PharmaColors.emerald50,
                borderRadius: PharmaRadius.cardRadius,
                border: Border.all(color: PharmaColors.emerald200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentUser != null
                        ? '${currentUser.firstName} ${currentUser.lastName}'
                        : 'QA Reviewer',
                    style: PharmaTypography.bodyMedium,
                  ),
                  Text(
                    currentUser?.jobRole?.name ?? 'Reviewer',
                    style: PharmaTypography.caption,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Course: ${_course!.title} v${_latestVersion!.version}',
                    style: PharmaTypography.caption,
                  ),
                  Text(
                    'Reviewed on ${_formatDate(DateTime.now())}',
                    style: PharmaTypography.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: meaningController,
              decoration: InputDecoration(
                labelText: 'Signature Meaning',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              passwordController.dispose();
              meaningController.dispose();
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (passwordController.text.isEmpty) return;
              final password = passwordController.text;
              final meaning = meaningController.text;
              passwordController.dispose();
              meaningController.dispose();
              Navigator.pop(ctx);
              try {
                await client.qa.approveCourseVersion(
                  courseVersionId: _latestVersion!.id!,
                  passwordPlaintext: password,
                  signatureMeaning: meaning,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Course approved successfully'),
                    backgroundColor: PharmaColors.emerald600,
                  ),
                );
                _loadData();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Approval failed: $e')),
                );
              }
            },
            style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600),
            child: const Text('Sign & Approve'),
          ),
        ],
      ),
    );
  }

  void _showRejectionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: Row(
          children: [
            Icon(Icons.cancel, color: PharmaColors.danger),
            const SizedBox(width: 8),
            const Text('Reject Course'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please provide a mandatory reason for rejection.',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rejectionReasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Rejection reason (required)...',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (_rejectionReasonController.text.trim().isEmpty) return;
              final reason = _rejectionReasonController.text;
              Navigator.pop(ctx);
              _rejectionReasonController.clear();
              try {
                await client.qa.rejectCourseVersion(
                  courseVersionId: _latestVersion!.id!,
                  reason: reason,
                  returnForChanges: false,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Course rejected'),
                    backgroundColor: PharmaColors.danger,
                  ),
                );
                _loadData();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed: $e')),
                );
              }
            },
            style:
                FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: Text('Reject',
                style: TextStyle(color: PharmaColors.cardBg)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({
    required this.label,
    required this.checked,
    required this.onChanged,
  });

  final String label;
  final bool checked;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: checked,
              onChanged: onChanged,
              activeColor: PharmaColors.emerald600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: PharmaTypography.body.copyWith(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.passed,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          passed ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 18,
          color: passed ? PharmaColors.success : PharmaColors.gray400,
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 16, color: PharmaColors.textTertiary),
        const SizedBox(width: 6),
        Text(label, style: PharmaTypography.bodyMedium),
        const Spacer(),
        Text(value, style: PharmaTypography.caption),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case 'under_review':
      case 'pending_qa':
      case 'pending_approval':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        label = 'UNDER REVIEW';
      case 'approved':
      case 'effective':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'QA APPROVED';
      case 'rejected':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.dangerText;
        label = 'REJECTED';
      case 'needs_revision':
        bg = PharmaColors.orangeBg;
        fg = PharmaColors.orangeText;
        label = 'NEEDS REVISION';
      case 'obsolete':
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = 'OBSOLETE';
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = 'DRAFT';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        label,
        style:
            TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}

class _ReviewStepperDot extends StatelessWidget {
  const _ReviewStepperDot({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.isCompleted,
    required this.color,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final bool isCompleted;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        isActive || isCompleted ? color : PharmaColors.gray300;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive
                ? effectiveColor
                : isCompleted
                    ? PharmaColors.emerald600
                    : PharmaColors.gray100,
            shape: BoxShape.circle,
            border:
                isActive ? null : Border.all(color: effectiveColor, width: 2),
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            size: 16,
            color: isActive || isCompleted ? PharmaColors.cardBg : effectiveColor,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? effectiveColor : PharmaColors.gray400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: isCompleted ? PharmaColors.emerald500 : PharmaColors.gray200,
    );
  }
}
