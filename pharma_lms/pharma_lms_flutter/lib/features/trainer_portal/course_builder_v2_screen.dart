// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE BUILDER V2 (TRN-01)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/builder
// Layout: LEFT (module tree) + CENTRE (lesson editor) + RIGHT (context panel)
//
// Principles:
//  - Drag-and-drop module/lesson ordering
//  - DRAFT → UNDER REVIEW → QA APPROVED stepper always visible
//  - Preview as Employee button (analytics live under /trainer/analytics)
//  - Auto-save every 60 seconds
//  - Version history in right sidebar
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/video_url_parser.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../shared/communication_sheets.dart';

/// Full-height bottom sheet: org materials with search; returns selected [Material.id].
Future<int?> showOrganizationMaterialPicker(
  BuildContext context, {
  required int organizationId,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final h = MediaQuery.sizeOf(ctx).height * 0.88;
      return Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: MediaQuery.paddingOf(ctx).bottom + 8,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(PharmaRadius.xl)),
            child: Container(
              height: h,
              color: PharmaColors.cardBg,
              child: _MaterialPickerSheet(organizationId: organizationId),
            ),
          ),
        ),
      );
    },
  );
}

class _MaterialPickerSheet extends StatefulWidget {
  const _MaterialPickerSheet({required this.organizationId});

  final int organizationId;

  @override
  State<_MaterialPickerSheet> createState() => _MaterialPickerSheetState();
}

class _MaterialPickerSheetState extends State<_MaterialPickerSheet> {
  final _search = TextEditingController();
  List<Material> _all = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list =
          await client.material.listMaterials(organizationId: widget.organizationId);
      if (mounted) {
        setState(() {
          _all = list;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  List<Material> get _filtered {
    final q = _search.text.trim().toLowerCase();
    if (q.isEmpty) return _all;
    return _all
        .where((m) =>
            m.title.toLowerCase().contains(q) ||
            m.materialType.toLowerCase().contains(q))
        .toList();
  }

  IconData _iconForType(String t) {
    final lower = t.toLowerCase();
    if (lower == 'pdf') return Icons.picture_as_pdf;
    if (lower.contains('video')) return Icons.videocam;
    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Link material from library',
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: 'Search by title or type…',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: PharmaColors.pageBg,
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (_loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (_error != null)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_error!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(onPressed: _load, child: const Text('Retry')),
                  ],
                ),
              ),
            ),
          )
        else if (_filtered.isEmpty)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  _all.isEmpty
                      ? 'No materials in this organization. Upload files in the trainer materials flow first.'
                      : 'No matches. Try a different search.',
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _filtered.length,
              separatorBuilder: (_, _) => Divider(height: 1, color: PharmaColors.borderLight),
              itemBuilder: (context, i) {
                final m = _filtered[i];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  leading: Icon(
                    _iconForType(m.materialType),
                    color: PharmaColors.emerald600,
                  ),
                  title: Text(
                    m.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(m.materialType),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pop(context, m.id),
                );
              },
            ),
          ),
      ],
    );
  }
}

class CourseBuilderV2Screen extends StatefulWidget {
  const CourseBuilderV2Screen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseBuilderV2Screen> createState() => _CourseBuilderV2ScreenState();
}

class _CourseBuilderV2ScreenState extends State<CourseBuilderV2Screen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Course? _course;
  List<CourseVersion> _versions = [];
  CourseVersion? _selectedVersion;
  List<Module> _modules = [];
  Map<int, List<Lesson>> _lessonsByModule = {};
  int? _selectedModuleId;
  int? _selectedLessonId;
  bool _loading = true;
  String? _error;
  bool _saving = false;
  DateTime? _lastSaved;
  int _autoSaveCount = 0;
  Timer? _autoSaveTimer;

  /// Whether the current version is editable (only draft / needs_revision).
  bool get _isEditable {
    final status = _selectedVersion?.status ?? 'draft';
    return status == 'draft' || status == 'needs_revision';
  }

  /// Whether the current version is approved / effective (read-only).
  bool get _isApproved {
    final status = _selectedVersion?.status ?? 'draft';
    return status == 'approved' || status == 'effective';
  }

  /// Whether the current version is rejected / needs revision.
  bool get _isRejectedOrNeedsRevision {
    final status = _selectedVersion?.status ?? 'draft';
    return status == 'rejected' || status == 'needs_revision';
  }

  /// QA reviews loaded for the current version (to show rejection comments).
  List<CourseReview> _qaReviews = [];
  bool _creatingNewVersion = false;

  // Inline controllers
  final _lessonTitleController = TextEditingController();
  final _lessonDurationController = TextEditingController();
  final _lessonMinEngagementController = TextEditingController();
  final _googleUrlController = TextEditingController();
  final _searchController = TextEditingController();
  String _lessonType = 'PDF';
  String _searchQuery = '';

  // Settings tab controllers
  final _settingsTitleController = TextEditingController();
  final _settingsDescController = TextEditingController();
  final _settingsSopController = TextEditingController();
  final _settingsImageUrlController = TextEditingController();
  final _settingsVideoUrlController = TextEditingController();
  final _settingsTagsController = TextEditingController();
  String? _settingsCategory;
  bool _settingsDisableSelfEnrollment = false;
  bool _settingsFeatured = false;
  bool _settingsLoaded = false;

  // Block editor state
  List<LessonBlock> _blocks = [];
  bool _blocksLoading = false;

  /// Quiz linked to the editable course version (from API).
  Assessment? _linkedAssessment;
  bool _assessmentRefreshing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(_onTabChanged);
    _load();
    _startAutoSave();
  }

  void _onTabChanged() {
    if (!mounted || _tabController.indexIsChanging) return;
    if (_tabController.index == 2) {
      _refreshLinkedAssessment();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _autoSaveTimer?.cancel();
    _lessonTitleController.dispose();
    _lessonDurationController.dispose();
    _lessonMinEngagementController.dispose();
    _googleUrlController.dispose();
    _searchController.dispose();
    _settingsTitleController.dispose();
    _settingsDescController.dispose();
    _settingsSopController.dispose();
    _settingsImageUrlController.dispose();
    _settingsVideoUrlController.dispose();
    _settingsTagsController.dispose();
    super.dispose();
  }

  void _startAutoSave() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      if (mounted && !_saving && _selectedVersion != null && _isEditable) {
        _saveDraft();
        setState(() => _autoSaveCount++);
      }
    });
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final course = await client.course.getCourse(widget.courseId);
      if (course == null) throw Exception('Course not found');

      final versions = await client.course.getCourseVersions(widget.courseId);
      // Prefer a draft/needs_revision version, then fall back to latest
      final draft = versions.where((v) => v.status == 'draft' || v.status == 'needs_revision').firstOrNull;
      final editable = draft ?? (versions.isNotEmpty ? versions.first : null);

      List<Module> modules = [];
      Map<int, List<Lesson>> lessonsByModule = {};

      if (editable != null) {
        modules = await client.course.getModulesForCourseVersion(editable.id!);
        for (final m in modules) {
          lessonsByModule[m.id!] = await client.course.getLessonsForModule(m.id!);
        }
      }

      Assessment? linkedAssessment;
      if (editable?.id != null) {
        try {
          linkedAssessment =
              await client.assessment.getAssessmentForCourse(editable!.id!);
        } catch (_) {
          linkedAssessment = null;
        }
      }

      // Load QA reviews for this version (to show rejection comments)
      List<CourseReview> qaReviews = [];
      if (editable?.id != null) {
        try {
          qaReviews = await client.qa.getCourseReviewsForTrainer(
            courseVersionId: editable!.id!,
          );
        } catch (_) {
          // Not critical
        }
      }

      if (mounted) {
        setState(() {
          _course = course;
          _versions = versions;
          _selectedVersion = editable;
          _modules = modules;
          _lessonsByModule = lessonsByModule;
          _linkedAssessment = linkedAssessment;
          _qaReviews = qaReviews;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveGoogleWorkspaceMaterial() async {
    final url = _googleUrlController.text.trim();
    if (url.isEmpty) return;

    final lesson = _selectedLessonId != null
        ? _lessonsByModule.values.expand((l) => l).where((l) => l.id == _selectedLessonId).firstOrNull
        : null;
    if (lesson == null) return;

    try {
      setState(() => _saving = true);
      final orgId = _course?.organizationId ?? 0;
      final material = await client.material.createMaterial(
        title: '${_lessonType == 'google_doc' ? 'Google Doc' : _lessonType == 'google_sheet' ? 'Google Sheet' : 'Google Slides'}: ${lesson.title}',
        materialType: _lessonType,
        organizationId: orgId,
        contentUrl: url,
      );
      await client.courseBuilder.updateLesson(
        lessonId: lesson.id!,
        title: lesson.title,
        materialId: material.id!,
      );
      setState(() {
        lesson.materialId = material.id!;
        _saving = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Workspace content linked')),
        );
      }
    } catch (e) {
      setState(() => _saving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text(_error!, style: PharmaTypography.body),
            const SizedBox(height: 12),
            FilledButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildHeaderBar(),
        _buildWorkflowStepper(),
        if (_versions.any((v) =>
                v.status == 'effective' ||
                v.status == 'approved' ||
                v.status == 'published') &&
            (_selectedVersion?.status == 'draft'))
          _buildDraftVersionAuditBanner(),
        // Approved course lock banner
        if (_isApproved) _buildApprovedLockBanner(),
        // Rejected/needs revision banner with QA comments
        if (_isRejectedOrNeedsRevision) _buildRejectionBanner(),
        // ── TAB BAR ──
        Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: PharmaColors.emerald700,
            unselectedLabelColor: PharmaColors.textSecondary,
            indicatorColor: PharmaColors.emerald600,
            indicatorWeight: 2,
            labelStyle: PharmaTypography.bodyMedium.copyWith(fontSize: 13),
            unselectedLabelStyle: PharmaTypography.body.copyWith(fontSize: 13),
            tabs: const [
              Tab(icon: Icon(Icons.settings_outlined, size: 18), text: 'Settings'),
              Tab(icon: Icon(Icons.menu_book_outlined, size: 18), text: 'Curriculum'),
              Tab(icon: Icon(Icons.quiz_outlined, size: 18), text: 'Assessment'),
            ],
          ),
        ),
        // ── TAB VIEWS ──
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildSettingsTab(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildModuleTree(),
                  Expanded(child: _buildLessonEditor()),
                  _buildContextPanel(),
                ],
              ),
              _buildAssessmentTab(),
            ],
          ),
        ),
      ],
    );
  }

  // ── HEADER BAR ──
  Widget _buildHeaderBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 10),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/trainer/courses'),
            icon: const Icon(Icons.arrow_back, size: 20),
            color: PharmaColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Text(
                  _course?.title ?? 'Course Builder',
                  style: PharmaTypography.headingMedium.copyWith(fontSize: 16),
                ),
                const SizedBox(width: 8),
                _WorkflowChip(status: _selectedVersion?.status ?? 'draft'),
              ],
            ),
          ),
          // Search
          SizedBox(
            width: 200,
            height: 32,
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search lessons...',
                hintStyle: PharmaTypography.caption,
                prefixIcon: const Icon(Icons.search, size: 16),
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              style: PharmaTypography.caption,
            ),
          ),
          const SizedBox(width: 12),
          // Preview as Employee
          Tooltip(
            message: _selectedVersion == null
                ? 'Select a course version in the sidebar first'
                : 'Open this version in the employee course viewer',
            child: OutlinedButton.icon(
              onPressed: _selectedVersion == null
                  ? null
                  : () {
                      context.push(
                        '/trainer/preview-course/${widget.courseId}',
                        extra: <String, dynamic>{
                          'courseVersionId': _selectedVersion!.id!,
                        },
                      );
                    },
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('Preview as Employee'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.emerald700,
                side: BorderSide(color: PharmaColors.emerald200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Tooltip(
            message: _selectedVersion == null
                ? 'Select a course version in the sidebar first'
                : 'Open QA review thread for this version',
            child: IconButton(
              onPressed: _selectedVersion == null
                  ? null
                  : () => openCourseQaThreadForVersion(
                        context,
                        courseVersionId: _selectedVersion!.id!,
                        courseTitle: _course?.title ?? 'Course',
                      ),
              icon: const Icon(Icons.forum_outlined),
              color: PharmaColors.textSecondary,
            ),
          ),
          // Version History
          OutlinedButton.icon(
            onPressed: () => context.go('/trainer/courses/${widget.courseId}/versions'),
            icon: const Icon(Icons.history, size: 16),
            label: const Text('Versions'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PharmaColors.textSecondary,
              side: BorderSide(color: PharmaColors.borderLight),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
            ),
          ),
        ],
      ),
    );
  }

  // ── WORKFLOW STEPPER ──
  Widget _buildWorkflowStepper() {
    final status = _selectedVersion?.status ?? 'draft';
    final isUnderReview = status == 'under_review' || status == 'pending_qa' || status == 'pending_approval';
    final isApproved = status == 'approved' || status == 'effective' || status == 'published';
    final isRejected = status == 'rejected';
    final isNeedsRevision = status == 'needs_revision';
    final pastDraft = isUnderReview || isApproved || isRejected || isNeedsRevision;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 8),
      decoration: BoxDecoration(
        color: PharmaColors.pageBg,
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StepperDot(
            label: isNeedsRevision ? 'NEEDS REVISION' : 'DRAFT',
            isActive: status == 'draft' || isNeedsRevision,
            isCompleted: pastDraft && !isNeedsRevision,
          ),
          _StepperLine(isCompleted: pastDraft),
          _StepperDot(
            label: isRejected ? 'REJECTED' : 'UNDER REVIEW',
            isActive: isUnderReview,
            isCompleted: isApproved,
          ),
          _StepperLine(isCompleted: isApproved),
          _StepperDot(
            label: 'QA APPROVED',
            isActive: isApproved,
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDraftVersionAuditBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 10),
      decoration: BoxDecoration(
        color: PharmaColors.infoBg,
        border: Border(bottom: BorderSide(color: PharmaColors.info.withValues(alpha: 0.25))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20, color: PharmaColors.infoText),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'You are editing a draft version while a published version exists. '
              'Edits are blocked on live content by design. Changes on this draft are logged for '
              'Admin → Audit (lesson / lesson_block / course_version). Submit through QA when ready to publish.',
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.infoText,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Banner shown when the selected version is approved/effective — read-only mode.
  Widget _buildApprovedLockBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 12),
      decoration: BoxDecoration(
        color: PharmaColors.successBg,
        border: Border(bottom: BorderSide(color: PharmaColors.success.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_rounded, size: 20, color: PharmaColors.successText),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This course version is QA-approved and locked for editing.',
                  style: PharmaTypography.bodyMedium.copyWith(
                    color: PharmaColors.successText,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'To make changes, create a new draft version below. It will be sent to QA for review.',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.successText,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: _creatingNewVersion ? null : _createNewVersionFromApproved,
            icon: _creatingNewVersion
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.add_circle_outline, size: 16),
            label: Text(_creatingNewVersion ? 'Creating...' : 'Create New Version'),
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  /// Banner shown when the selected version is rejected / needs_revision — show QA comments.
  Widget _buildRejectionBanner() {
    final isRejected = _selectedVersion?.status == 'rejected';
    final latestReview = _qaReviews.where((r) =>
        r.decision == 'rejected' || r.decision == 'returned_for_changes').firstOrNull;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 12),
      decoration: BoxDecoration(
        color: isRejected ? PharmaColors.dangerBg : PharmaColors.warningBg,
        border: Border(
          bottom: BorderSide(
            color: (isRejected ? PharmaColors.danger : PharmaColors.warning).withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isRejected ? Icons.cancel_rounded : Icons.edit_note_rounded,
            size: 20,
            color: isRejected ? PharmaColors.dangerText : PharmaColors.warningText,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isRejected
                      ? 'This course version was rejected by QA.'
                      : 'This course version needs revision. Address the feedback and re-submit.',
                  style: PharmaTypography.bodyMedium.copyWith(
                    color: isRejected ? PharmaColors.dangerText : PharmaColors.warningText,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                if (latestReview?.comments != null && latestReview!.comments!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PharmaColors.cardBg,
                      borderRadius: PharmaRadius.cardRadius,
                      border: Border.all(color: PharmaColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.format_quote, size: 14, color: PharmaColors.textQuaternary),
                            const SizedBox(width: 4),
                            Text(
                              'QA Reviewer Comment:',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: PharmaColors.textQuaternary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (latestReview.reviewer != null) ...[
                              const Spacer(),
                              Text(
                                '${latestReview.reviewer!.firstName} ${latestReview.reviewer!.lastName}',
                                style: PharmaTypography.caption,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          latestReview.comments!,
                          style: PharmaTypography.body.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
                if (_qaReviews.length > 1) ...[
                  const SizedBox(height: 6),
                  TextButton.icon(
                    onPressed: () => context.go(
                      '/trainer/courses/${widget.courseId}/qa-review',
                    ),
                    icon: Icon(Icons.history, size: 14,
                        color: isRejected ? PharmaColors.dangerText : PharmaColors.warningText),
                    label: Text(
                      'View all ${_qaReviews.length} QA reviews',
                      style: PharmaTypography.caption.copyWith(
                        color: isRejected ? PharmaColors.dangerText : PharmaColors.warningText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Creates a new draft version from the current approved version.
  Future<void> _createNewVersionFromApproved() async {
    if (_selectedVersion?.id == null) return;

    final changeSummary = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl),
          ),
          title: Row(
            children: [
              Icon(Icons.add_circle, color: PharmaColors.emerald600),
              const SizedBox(width: 8),
              const Text('Create New Version'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Describe what you plan to change in this new version. '
                'The current approved content will be cloned and a new draft created.',
                style: PharmaTypography.body,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 3,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Change summary (required)...',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(
                    borderRadius: PharmaRadius.inputRadius,
                  ),
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
              onPressed: () {
                final text = controller.text.trim();
                controller.dispose();
                if (text.isEmpty) return;
                Navigator.pop(ctx, text);
              },
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
              ),
              child: const Text('Create Draft'),
            ),
          ],
        );
      },
    );

    if (changeSummary == null || changeSummary.isEmpty) return;

    setState(() => _creatingNewVersion = true);
    try {
      await client.courseBuilder.createNewVersionFromExisting(
        existingVersionId: _selectedVersion!.id!,
        changeSummary: changeSummary,
        isMajorVersion: false,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('New draft version created — you can now edit'),
          backgroundColor: PharmaColors.emerald600,
        ),
      );
      // Reload to pick up the new draft version
      await _load();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create new version: $e'),
          backgroundColor: PharmaColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _creatingNewVersion = false);
    }
  }

  // ── LEFT PANEL: MODULE TREE ──
  Widget _buildModuleTree() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(right: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Column(
        children: [
          // Module tree header
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: Row(
              children: [
                Text('Curriculum',
                    style: PharmaTypography.headingSmall.copyWith(fontSize: 13)),
                const Spacer(),
                if (_isEditable)
                  IconButton(
                    onPressed: _addModule,
                    icon: const Icon(Icons.add, size: 18),
                    tooltip: 'Add Module',
                    color: PharmaColors.emerald600,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                if (!_isEditable)
                  Tooltip(
                    message: _isApproved
                        ? 'Course is approved — create a new version to edit'
                        : 'Course is under review',
                    child: Icon(Icons.lock_outline, size: 16, color: PharmaColors.gray400),
                  ),
              ],
            ),
          ),
          // Module list
          Expanded(
            child: _modules.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_outlined, size: 40, color: PharmaColors.gray300),
                        const SizedBox(height: 8),
                        Text('No modules yet', style: PharmaTypography.body),
                        const SizedBox(height: 8),
                        if (_isEditable)
                          TextButton.icon(
                            onPressed: _addModule,
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Add Module'),
                          ),
                      ],
                    ),
                  )
                : ReorderableListView(
                    onReorder: _reorderModules,
                    children: [
                      for (int i = 0; i < _modules.length; i++)
                        if (_searchQuery.isEmpty ||
                            _modules[i].title.toLowerCase().contains(_searchQuery) ||
                            (_lessonsByModule[_modules[i].id!] ?? []).any((l) => l.title.toLowerCase().contains(_searchQuery)))
                        _ModuleTreeItem(
                          key: ValueKey(_modules[i].id),
                          module: _modules[i],
                          index: i,
                          lessons: _searchQuery.isEmpty
                              ? (_lessonsByModule[_modules[i].id!] ?? [])
                              : (_lessonsByModule[_modules[i].id!] ?? [])
                                  .where((l) => l.title.toLowerCase().contains(_searchQuery))
                                  .toList(),
                          isSelected: _selectedModuleId == _modules[i].id,
                          selectedLessonId: _selectedLessonId,
                          onModuleTap: () => setState(() {
                            _selectedModuleId = _modules[i].id;
                            _selectedLessonId = null;
                          }),
                          onLessonTap: (lessonId) => _selectLesson(lessonId),
                          onAddLesson: _isEditable ? () => _addLesson(_modules[i].id!) : null,
                          onDeleteModule: _isEditable ? () => _deleteModule(_modules[i].id!) : null,
                          onRenameModule: _isEditable ? () => _renameModule(_modules[i]) : null,
                        ),
                    ],
                  ),
          ),
          // Add Module CTA
          if (_isEditable)
            Container(
              padding: const EdgeInsets.all(PharmaSpacing.md),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: PharmaColors.borderLight)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _addModule,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Module'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.emerald600,
                    side: BorderSide(color: PharmaColors.emerald200),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── CENTRE PANEL: BLOCK-BASED LESSON EDITOR ──
  Widget _buildLessonEditor() {
    if (_selectedLessonId == null) {
      return Container(
        color: PharmaColors.pageBg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app_outlined, size: 56, color: PharmaColors.gray300),
              const SizedBox(height: 16),
              Text(
                'Select a lesson to edit',
                style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.gray500),
              ),
              const SizedBox(height: 8),
              Text(
                'Click on a lesson in the left panel to view and edit its content blocks.',
                style: PharmaTypography.body,
              ),
            ],
          ),
        ),
      );
    }

    Lesson? selectedLesson;
    for (final lessons in _lessonsByModule.values) {
      for (final l in lessons) {
        if (l.id == _selectedLessonId) {
          selectedLesson = l;
          break;
        }
      }
    }

    if (selectedLesson == null) {
      return const Center(child: Text('Lesson not found'));
    }

    return Container(
      color: PharmaColors.pageBg,
      child: Column(
        children: [
          // Lesson header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 10),
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _lessonTitleController,
                        decoration: InputDecoration(
                          hintText: 'Lesson title...',
                          hintStyle: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary),
                          border: InputBorder.none,
                        ),
                        style: PharmaTypography.headingMedium.copyWith(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Delete Lesson'),
                            content: const Text('Are you sure? This cannot be undone.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: Text('Delete', style: TextStyle(color: PharmaColors.danger)),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          try {
                            await client.courseBuilder.deleteLesson(lessonId: _selectedLessonId!);
                            setState(() {
                              for (final entry in _lessonsByModule.entries) {
                                entry.value.removeWhere((l) => l.id == _selectedLessonId);
                              }
                              _selectedLessonId = null;
                              _blocks = [];
                            });
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          }
                        }
                      },
                      icon: Icon(Icons.delete_outline, size: 16, color: PharmaColors.danger),
                      label: Text('Delete', style: TextStyle(color: PharmaColors.danger, fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: PharmaColors.dangerBg),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: _saving ? null : () => _saveLessonChanges(selectedLesson!),
                      icon: const Icon(Icons.save, size: 16),
                      label: Text(_saving ? 'Saving...' : 'Save', style: const TextStyle(fontSize: 12)),
                      style: FilledButton.styleFrom(
                        backgroundColor: PharmaColors.emerald600,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _lessonDurationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Est. duration (min)',
                          isDense: true,
                          filled: true,
                          fillColor: PharmaColors.pageBg,
                          border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                        ),
                        style: PharmaTypography.body.copyWith(fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _lessonMinEngagementController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Min time to complete (min)',
                          isDense: true,
                          filled: true,
                          fillColor: PharmaColors.pageBg,
                          border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                          helperText: 'Used for learner progress & completion',
                        ),
                        style: PharmaTypography.body.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Block list
          Expanded(
            child: _blocksLoading
                ? const Center(child: CircularProgressIndicator())
                : _blocks.isEmpty
                    ? _buildEmptyBlockState()
                    : _buildBlockList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBlockState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard_customize_outlined, size: 48, color: PharmaColors.gray300),
          const SizedBox(height: 12),
          Text('Add your first content block',
              style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.gray500)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _blockTypeOptions().map((opt) => _BlockTypeChip(
              icon: opt.icon,
              label: opt.label,
              color: opt.color,
              onTap: () => _addBlock(opt.type),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      child: Column(
        children: [
          for (int i = 0; i < _blocks.length; i++) ...[
            _BlockEditorWidget(
              key: ValueKey(_blocks[i].id),
              block: _blocks[i],
              onUpdate: (contentJson) => _updateBlock(_blocks[i], contentJson),
              onDelete: () => _deleteBlock(_blocks[i]),
              onMoveUp: i > 0 ? () => _moveBlock(i, i - 1) : null,
              onMoveDown: i < _blocks.length - 1 ? () => _moveBlock(i, i + 1) : null,
              inputDecoration: _inputDecoration,
              onLinkUploadMaterial: _blocks[i].blockType == 'upload'
                  ? () => _handleUploadBlockLinkMaterial(_blocks[i])
                  : null,
            ),
            _AddBlockDivider(onAddBlock: (type) => _insertBlock(type, i + 1)),
          ],
          if (_blocks.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: OutlinedButton.icon(
                onPressed: () => _showBlockTypePicker(_blocks.length),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Block'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PharmaColors.emerald600,
                  side: BorderSide(color: PharmaColors.emerald200),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<_BlockTypeOption> _blockTypeOptions() => const [
    _BlockTypeOption(type: 'text', label: 'Text', icon: Icons.subject, color: PharmaColors.gray600),
    _BlockTypeOption(type: 'heading', label: 'Heading', icon: Icons.title, color: PharmaColors.gray700),
    _BlockTypeOption(type: 'video', label: 'Video', icon: Icons.play_circle_outline, color: PharmaColors.info),
    _BlockTypeOption(type: 'upload', label: 'Upload', icon: Icons.upload_file, color: PharmaColors.emerald600),
    _BlockTypeOption(type: 'quiz', label: 'Quiz', icon: Icons.quiz_outlined, color: PharmaColors.purple),
    _BlockTypeOption(type: 'assignment', label: 'Assignment', icon: Icons.assignment_outlined, color: PharmaColors.orange),
    _BlockTypeOption(type: 'google_doc', label: 'Google Docs', icon: Icons.article_outlined, color: PharmaColors.info),
    _BlockTypeOption(type: 'google_sheet', label: 'Google Sheets', icon: Icons.table_chart_outlined, color: PharmaColors.success),
    _BlockTypeOption(type: 'google_slide', label: 'Google Slides', icon: Icons.slideshow_outlined, color: PharmaColors.orange),
    _BlockTypeOption(type: 'code_sandbox', label: 'CodeSandbox', icon: Icons.code, color: PharmaColors.gray700),
    _BlockTypeOption(type: 'audio', label: 'Audio', icon: Icons.audiotrack, color: PharmaColors.purple),
  ];

  Future<void> _loadBlocks() async {
    if (_selectedLessonId == null) return;
    setState(() => _blocksLoading = true);
    try {
      final blocks = await client.lessonBlock.listBlocks(lessonId: _selectedLessonId!);
      if (mounted) setState(() { _blocks = blocks; _blocksLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _blocksLoading = false);
    }
  }

  Future<void> _addBlock(String blockType) async {
    if (_selectedLessonId == null) return;
    final contentJson = _defaultContentForType(blockType);
    try {
      final block = await client.lessonBlock.createBlock(
        lessonId: _selectedLessonId!,
        blockType: blockType,
        contentJson: jsonEncode(contentJson),
        orderIndex: _blocks.length,
      );
      setState(() => _blocks.add(block));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _insertBlock(String blockType, int index) async {
    if (_selectedLessonId == null) return;
    final contentJson = _defaultContentForType(blockType);
    try {
      final block = await client.lessonBlock.createBlock(
        lessonId: _selectedLessonId!,
        blockType: blockType,
        contentJson: jsonEncode(contentJson),
        orderIndex: index,
      );
      setState(() => _blocks.insert(index, block));
      await _reorderBlocksOnServer();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _updateBlock(LessonBlock block, String contentJson) async {
    try {
      var toSave = contentJson;
      if (block.blockType == 'assignment' && _selectedLessonId != null) {
        final map = jsonDecode(contentJson) as Map<String, dynamic>;
        final title = (map['title'] as String? ?? '').trim();
        final existingId = map['assignmentId'];
        if (title.isNotEmpty && existingId == null) {
          final created = await client.assignment.createAssignment(
            lessonId: _selectedLessonId!,
            title: title,
            instructions: () {
              final i = map['instructions'] as String?;
              if (i == null || i.trim().isEmpty) return null;
              return i.trim();
            }(),
            allowedFileTypes: jsonEncode(map['allowedTypes'] ?? ['pdf', 'doc']),
          );
          map['assignmentId'] = created.id;
          toSave = jsonEncode(map);
        } else if (existingId != null && title.isNotEmpty) {
          final id = existingId is int
              ? existingId
              : int.tryParse(existingId.toString());
          if (id != null) {
            await client.assignment.updateAssignment(
              assignmentId: id,
              title: title,
              instructions: () {
                final i = map['instructions'] as String?;
                if (i == null || i.trim().isEmpty) return null;
                return i.trim();
              }(),
              allowedFileTypes: jsonEncode(map['allowedTypes'] ?? ['pdf', 'doc']),
            );
          }
        }
      }
      await client.lessonBlock.updateBlock(blockId: block.id!, contentJson: toSave);
      if (mounted) setState(() => block.contentJson = toSave);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _deleteBlock(LessonBlock block) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Block'),
        content: const Text('Remove this content block?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete', style: TextStyle(color: PharmaColors.danger)),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await client.lessonBlock.deleteBlock(blockId: block.id!);
      setState(() => _blocks.removeWhere((b) => b.id == block.id));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _moveBlock(int oldIndex, int newIndex) {
    setState(() {
      final block = _blocks.removeAt(oldIndex);
      _blocks.insert(newIndex, block);
    });
    _reorderBlocksOnServer();
  }

  Future<void> _reorderBlocksOnServer() async {
    if (_selectedLessonId == null) return;
    final blockIds = _blocks.where((b) => b.id != null).map((b) => b.id!).toList();
    try {
      await client.lessonBlock.reorderBlocks(lessonId: _selectedLessonId!, blockIds: blockIds);
    } catch (_) {}
  }

  void _showBlockTypePicker(int insertIndex) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Content Block', style: PharmaTypography.headingSmall),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _blockTypeOptions().map((opt) => _BlockTypeChip(
                icon: opt.icon,
                label: opt.label,
                color: opt.color,
                onTap: () {
                  Navigator.pop(ctx);
                  _insertBlock(opt.type, insertIndex);
                },
              )).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _defaultContentForType(String type) {
    switch (type) {
      case 'text': return {'html': ''};
      case 'heading': return {'text': '', 'level': 2};
      case 'video': return {'url': '', 'platform': 'direct'};
      case 'upload': return {'materialId': null, 'materialType': ''};
      case 'quiz': return {'quizId': null, 'quizTitle': ''};
      case 'assignment':
        return {
          'title': '',
          'instructions': '',
          'allowedTypes': ['pdf', 'doc'],
          'assignmentId': null,
        };
      case 'google_doc': return {'url': '', 'embedUrl': ''};
      case 'google_sheet': return {'url': '', 'embedUrl': ''};
      case 'google_slide': return {'url': '', 'embedUrl': ''};
      case 'code_sandbox': return {'url': ''};
      case 'audio': return {'materialId': null, 'fileName': ''};
      default: return {};
    }
  }

  // ── RIGHT PANEL: CONTEXT ──
  Widget _buildContextPanel() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(left: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trainer avatar card
            Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'T',
                        style: PharmaTypography.headingLarge.copyWith(
                          color: PharmaColors.emerald700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Trainer', style: PharmaTypography.bodyMedium),
                  Text('Subject Matter Expert', style: PharmaTypography.caption),
                ],
              ),
            ),

            const SizedBox(height: PharmaSpacing.sectionGap),
            Divider(color: PharmaColors.borderLight),
            const SizedBox(height: PharmaSpacing.lg),

            // Version info
            Text('VERSION', style: _sectionLabelStyle),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PharmaColors.pageBg,
                borderRadius: PharmaRadius.cardRadius,
                border: Border.all(color: PharmaColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'v${_selectedVersion?.version ?? '1.0'}',
                    style: PharmaTypography.bodyMedium.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  _WorkflowChip(status: _selectedVersion?.status ?? 'draft'),
                ],
              ),
            ),

            const SizedBox(height: PharmaSpacing.lg),

            // Version History
            Text('HISTORY', style: _sectionLabelStyle),
            const SizedBox(height: 8),
            ...(_versions.take(5).map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text(
                        'v${v.version}',
                        style: PharmaTypography.caption.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _WorkflowChip(status: v.status),
                    ],
                  ),
                ))),

            const SizedBox(height: PharmaSpacing.sectionGap),
            Divider(color: PharmaColors.borderLight),
            const SizedBox(height: PharmaSpacing.lg),

            // Save Draft CTA
            if (_isEditable)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saving ? null : _saveDraft,
                  icon: const Icon(Icons.save, size: 16),
                  label: Text(_saving ? 'Saving...' : 'Save Draft'),
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

            if (_isApproved)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _creatingNewVersion ? null : _createNewVersionFromApproved,
                  icon: _creatingNewVersion
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.add_circle_outline, size: 16),
                  label: Text(_creatingNewVersion ? 'Creating...' : 'Create New Version'),
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

            const SizedBox(height: 8),

            // Submit for QA
            if (_selectedVersion?.status == 'draft' || _selectedVersion?.status == 'needs_revision')
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showPreSubmissionChecklist(),
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Submit for QA'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.warning,
                    side: BorderSide(color: PharmaColors.warning),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

            const SizedBox(height: PharmaSpacing.lg),

            // Auto-save indicator
            PharmaAutosaveIndicator(
              isSaving: _saving,
              lastSaved: _lastSaved,
            ),
          ],
        ),
      ),
    );
  }

  // ── HELPERS ──

  TextStyle get _sectionLabelStyle => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: PharmaColors.textQuaternary,
        letterSpacing: 0.7,
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary),
        filled: true,
        fillColor: PharmaColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: BorderSide(color: PharmaColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: BorderSide(color: PharmaColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: BorderSide(color: PharmaColors.emerald500),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );

  // ── SETTINGS TAB ──
  Widget _buildSettingsTab() {
    if (_course != null && !_settingsLoaded) {
      _settingsTitleController.text = _course!.title;
      _settingsDescController.text = _course!.description ?? '';
      _settingsSopController.text = _course!.sopNumber ?? '';
      _settingsImageUrlController.text = _course!.imageUrl ?? '';
      _settingsVideoUrlController.text = _course!.previewVideoUrl ?? '';
      _settingsTagsController.text = _course!.tags ?? '';
      _settingsCategory = _course!.category;
      _settingsDisableSelfEnrollment = _course!.disableSelfEnrollment;
      _settingsFeatured = _course!.featured;
      _settingsLoaded = true;
    }

    return Container(
      color: PharmaColors.pageBg,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Course Settings',
                    style: PharmaTypography.headingMedium.copyWith(fontSize: 18)),
                const SizedBox(height: 4),
                Text(
                  'Configure your course metadata, media, and options.',
                  style: PharmaTypography.body,
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                // Basic Info Section
                _SettingsSection(
                  title: 'Basic Information',
                  icon: Icons.info_outline,
                  children: [
                    _FormField(
                      label: 'Course Title',
                      child: TextField(
                        controller: _settingsTitleController,
                        decoration: _inputDecoration('Enter course title'),
                        style: PharmaTypography.body,
                        onChanged: (_) => _autoSaveSettings(),
                      ),
                    ),
                    _FormField(
                      label: 'Description',
                      child: TextField(
                        controller: _settingsDescController,
                        decoration: _inputDecoration('Course description...'),
                        style: PharmaTypography.body,
                        maxLines: 4,
                        onChanged: (_) => _autoSaveSettings(),
                      ),
                    ),
                    _FormField(
                      label: 'Linked SOP Number',
                      child: TextField(
                        controller: _settingsSopController,
                        decoration: _inputDecoration('e.g., SOP-105, SOP-GMP-001'),
                        style: PharmaTypography.body,
                        onChanged: (_) => _autoSaveSettings(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                // Media Section
                _SettingsSection(
                  title: 'Media',
                  icon: Icons.perm_media_outlined,
                  children: [
                    _FormField(
                      label: 'Cover Image URL',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _settingsImageUrlController,
                            decoration: _inputDecoration('https://example.com/course-cover.png'),
                            style: PharmaTypography.body,
                            keyboardType: TextInputType.url,
                            onChanged: (_) => _autoSaveSettings(),
                          ),
                          if (_settingsImageUrlController.text.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: PharmaRadius.cardRadius,
                              child: Image.network(
                                _settingsImageUrlController.text,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  height: 120,
                                  color: PharmaColors.gray100,
                                  child: Center(
                                    child: Icon(Icons.broken_image,
                                        color: PharmaColors.gray400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    _FormField(
                      label: 'Preview Video URL',
                      child: TextField(
                        controller: _settingsVideoUrlController,
                        decoration: _inputDecoration(
                            'https://youtube.com/watch?v=... or Vimeo link'),
                        style: PharmaTypography.body,
                        keyboardType: TextInputType.url,
                        onChanged: (_) => _autoSaveSettings(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                // Metadata Section
                _SettingsSection(
                  title: 'Metadata & Tags',
                  icon: Icons.label_outline,
                  children: [
                    _FormField(
                      label: 'Category',
                      child: DropdownButtonFormField<String>(
                        initialValue: _settingsCategory,
                        decoration: _inputDecoration('Select a category'),
                        style: PharmaTypography.body,
                        items: const [
                          DropdownMenuItem(value: 'GMP', child: Text('GMP')),
                          DropdownMenuItem(value: 'Quality', child: Text('Quality')),
                          DropdownMenuItem(value: 'Safety', child: Text('Safety')),
                          DropdownMenuItem(value: 'Regulatory', child: Text('Regulatory')),
                          DropdownMenuItem(value: 'Compliance', child: Text('Compliance')),
                          DropdownMenuItem(value: 'Manufacturing', child: Text('Manufacturing')),
                          DropdownMenuItem(value: 'Laboratory', child: Text('Laboratory')),
                          DropdownMenuItem(value: 'General', child: Text('General')),
                        ],
                        onChanged: (val) {
                          setState(() => _settingsCategory = val);
                          _autoSaveSettings();
                        },
                      ),
                    ),
                    _FormField(
                      label: 'Tags',
                      child: TextField(
                        controller: _settingsTagsController,
                        decoration: _inputDecoration(
                            'GMP, Beginner, Quality Control (comma-separated)'),
                        style: PharmaTypography.body,
                        onChanged: (_) => _autoSaveSettings(),
                      ),
                    ),
                    if (_settingsTagsController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: _settingsTagsController.text
                              .split(',')
                              .map((t) => t.trim())
                              .where((t) => t.isNotEmpty)
                              .map((t) => Chip(
                                    label: Text(t,
                                        style: PharmaTypography.caption),
                                    backgroundColor: PharmaColors.emerald50,
                                    side: BorderSide(
                                        color: PharmaColors.emerald200),
                                    visualDensity: VisualDensity.compact,
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                // Pharma & Publishing Section
                _SettingsSection(
                  title: 'Publishing & Pharma Options',
                  icon: Icons.tune_outlined,
                  children: [
                    _FormField(
                      label: 'Disable Self-Enrollment',
                      child: SwitchListTile(
                        value: _settingsDisableSelfEnrollment,
                        onChanged: (val) {
                          setState(() => _settingsDisableSelfEnrollment = val);
                          _autoSaveSettings();
                        },
                        title: Text(
                          'Require admin or manager assignment',
                          style: PharmaTypography.body,
                        ),
                        subtitle: Text(
                          'When enabled, learners cannot self-enroll in this course.',
                          style: PharmaTypography.caption,
                        ),
                        contentPadding: EdgeInsets.zero,
                        activeThumbColor: PharmaColors.emerald600,
                      ),
                    ),
                    _FormField(
                      label: 'Featured Course',
                      child: SwitchListTile(
                        value: _settingsFeatured,
                        onChanged: (val) {
                          setState(() => _settingsFeatured = val);
                          _autoSaveSettings();
                        },
                        title: Text(
                          'Promote on course catalog',
                          style: PharmaTypography.body,
                        ),
                        subtitle: Text(
                          'Featured courses appear prominently in the learner catalog.',
                          style: PharmaTypography.caption,
                        ),
                        contentPadding: EdgeInsets.zero,
                        activeThumbColor: PharmaColors.emerald600,
                      ),
                    ),
                    _FormField(
                      label: 'Published Status',
                      child: Row(
                        children: [
                          Text(
                            _course?.status == 'approved' ? 'Published' : 'Not Published',
                            style: PharmaTypography.bodyMedium.copyWith(
                              color: _course?.status == 'approved'
                                  ? PharmaColors.success
                                  : PharmaColors.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_course?.publishedAt != null)
                            Text(
                              '(${_course!.publishedAt!.toLocal().toString().substring(0, 10)})',
                              style: PharmaTypography.caption,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saving ? null : _saveSettings,
                    icon: const Icon(Icons.save, size: 16),
                    label: Text(_saving ? 'Saving...' : 'Save Settings'),
                    style: FilledButton.styleFrom(
                      backgroundColor: PharmaColors.emerald600,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Timer? _settingsDebounce;

  void _autoSaveSettings() {
    _settingsDebounce?.cancel();
    _settingsDebounce = Timer(const Duration(seconds: 2), () {
      _saveSettings();
    });
    setState(() {});
  }

  Future<void> _saveSettings() async {
    if (_course == null) return;
    setState(() => _saving = true);
    try {
      final updated = await client.course.updateCourse(
        courseId: _course!.id!,
        title: _settingsTitleController.text.trim(),
        description: _settingsDescController.text.trim().isEmpty
            ? null
            : _settingsDescController.text.trim(),
        sopNumber: _settingsSopController.text.trim().isEmpty
            ? null
            : _settingsSopController.text.trim(),
        previewVideoUrl: _settingsVideoUrlController.text.trim().isEmpty
            ? null
            : _settingsVideoUrlController.text.trim(),
        imageUrl: _settingsImageUrlController.text.trim().isEmpty
            ? null
            : _settingsImageUrlController.text.trim(),
        tags: _settingsTagsController.text.trim().isEmpty
            ? null
            : _settingsTagsController.text.trim(),
        category: _settingsCategory,
        disableSelfEnrollment: _settingsDisableSelfEnrollment,
        featured: _settingsFeatured,
      );
      setState(() {
        _course = updated;
        _lastSaved = DateTime.now();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save settings: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _refreshLinkedAssessment() async {
    final vid = _selectedVersion?.id;
    if (vid == null || !mounted) return;
    setState(() => _assessmentRefreshing = true);
    try {
      final a = await client.assessment.getAssessmentForCourse(vid);
      if (mounted) {
        setState(() {
          _linkedAssessment = a;
          _assessmentRefreshing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _linkedAssessment = null;
          _assessmentRefreshing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not load assessment: $e')),
        );
      }
    }
  }

  // ── ASSESSMENT TAB ──
  Widget _buildAssessmentTab() {
    return Container(
      color: PharmaColors.pageBg,
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          Row(
            children: [
              Icon(Icons.quiz_outlined, color: PharmaColors.emerald600, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assessment for this version',
                      style: PharmaTypography.headingSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _selectedVersion == null
                          ? 'No draft version loaded.'
                          : 'Linked to v${_selectedVersion!.version} (${_selectedVersion!.status})',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Refresh from server',
                onPressed:
                    _selectedVersion == null || _assessmentRefreshing ? null : _refreshLinkedAssessment,
                icon: _assessmentRefreshing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh, size: 20),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.lg),
          if (_selectedVersion == null)
            Text(
              'Load a course version to see assessment details.',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            )
          else if (_linkedAssessment == null)
            _buildNoAssessmentCard()
          else
            _buildAssessmentDetailCard(_linkedAssessment!),
          const SizedBox(height: PharmaSpacing.lg),
          Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: _selectedVersion == null
                  ? 'Select a version in the sidebar first'
                  : 'Edit question bank, passing score, and attempts',
              child: FilledButton.icon(
                onPressed: _selectedVersion == null
                    ? null
                    : () async {
                        await context.push('/trainer/courses/${widget.courseId}/assessment');
                        if (mounted) await _refreshLinkedAssessment();
                      },
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text(_linkedAssessment == null ? 'Create / link assessment' : 'Edit in assessment builder'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  foregroundColor: PharmaColors.cardBg,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Completion and enrollment metrics are in Analytics → Course analytics.',
            style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildNoAssessmentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link_off_outlined, color: PharmaColors.warning, size: 22),
              const SizedBox(width: 10),
              Text(
                'No assessment linked',
                style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This course version does not have a quiz yet. Use the button below to create one and attach a question bank.',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentDetailCard(Assessment a) {
    final bankName = a.questionBank?.name ?? 'Question bank #${a.questionBankId}';
    final poolNote = a.limitQuestions != null
        ? 'Pool cap: ${a.limitQuestions}'
        : 'Questions shown per attempt: ${a.questionsToDisplay ?? '—'}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.emerald200),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Linked assessment',
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            bankName,
            style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            'Assessment ID: ${a.id} · Bank ID: ${a.questionBankId}',
            style: PharmaTypography.caption.copyWith(fontFamily: 'monospace'),
          ),
          const SizedBox(height: PharmaSpacing.lg),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _assessmentChip(Icons.percent, 'Passing score', '${a.passingScore}%'),
              _assessmentChip(
                Icons.shuffle,
                'Randomize',
                a.randomize ? 'Yes' : 'No',
              ),
              _assessmentChip(
                Icons.timer_outlined,
                'Time limit',
                a.timeLimitMinutes != null ? '${a.timeLimitMinutes} min' : 'None',
              ),
              _assessmentChip(
                Icons.repeat,
                'Max attempts',
                a.maxAttempts != null && a.maxAttempts! > 0 ? '${a.maxAttempts}' : 'Unlimited',
              ),
              _assessmentChip(Icons.quiz_outlined, 'Display', poolNote),
              _assessmentChip(
                Icons.visibility_outlined,
                'Show answers after submit',
                a.showAnswers ? 'Yes' : 'No',
              ),
              _assessmentChip(
                Icons.history,
                'Submission history',
                a.showSubmissionHistory ? 'Yes' : 'No',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _assessmentChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: PharmaColors.pageBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: PharmaColors.emerald600),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: PharmaTypography.caption.copyWith(fontSize: 10)),
              Text(
                value,
                style: PharmaTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showPreSubmissionChecklist() async {
    if (_selectedVersion == null) return;
    final selectedVersionId = _selectedVersion!.id!;

    QaValidationResult validation;
    try {
      validation = await client.courseBuilder
          .validateForQaSubmission(courseVersionId: selectedVersionId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Validation failed: $e')),
        );
      }
      return;
    }

    if (!mounted) return;
    final v = validation;
    final allPassed = v.allPassed;
    final results = v.validationResults;

    final proceed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          Icon(
            allPassed ? Icons.check_circle : Icons.warning,
            color: allPassed ? PharmaColors.emerald600 : PharmaColors.warning,
          ),
          const SizedBox(width: 8),
          const Text('Pre-Submission Checklist'),
        ]),
        content: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              '${v.passedCount}/${v.totalRules} checks passed',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: 16),
            PharmaValidationChecklist(results: results),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          if (allPassed)
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
              ),
              child: const Text('Submit for QA Review'),
            ),
        ],
      ),
    );

    if (proceed == true) {
      try {
        await client.courseBuilder
            .submitForQaReview(courseVersionId: selectedVersionId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Submitted for QA review')),
          );
          context.go('/trainer/courses/${widget.courseId}/qa-review');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Submission failed: $e')),
          );
        }
      }
    }
  }

  Future<void> _saveLessonChanges(Lesson lesson) async {
    setState(() => _saving = true);
    try {
      final dur = int.tryParse(_lessonDurationController.text) ?? 15;
      final minEng = int.tryParse(_lessonMinEngagementController.text);
      await client.courseBuilder.updateLesson(
        lessonId: lesson.id!,
        title: _lessonTitleController.text,
        durationMinutes: dur,
        lessonType: _lessonType,
        minEngagementMinutes: minEng,
      );
      setState(() => _lastSaved = DateTime.now());
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _handleUploadBlockLinkMaterial(LessonBlock block) async {
    if (_selectedLessonId == null || _course?.organizationId == null) return;
    final orgId = _course!.organizationId;
    final selectedId = await showOrganizationMaterialPicker(
      context,
      organizationId: orgId,
    );
    if (selectedId == null || !mounted) return;
    try {
      await client.courseBuilder.updateLesson(
        lessonId: _selectedLessonId!,
        materialId: selectedId,
      );
      Map<String, dynamic> map;
      try {
        map = Map<String, dynamic>.from(
          jsonDecode(block.contentJson) as Map<String, dynamic>? ?? {},
        );
      } catch (_) {
        map = {};
      }
      map['materialId'] = selectedId;
      final newJson = jsonEncode(map);
      await client.lessonBlock.updateBlock(
        blockId: block.id!,
        contentJson: newJson,
      );
      if (!mounted) return;
      setState(() {
        block.contentJson = newJson;
        for (final lessons in _lessonsByModule.values) {
          for (var i = 0; i < lessons.length; i++) {
            if (lessons[i].id == _selectedLessonId) {
              lessons[i].materialId = selectedId;
              break;
            }
          }
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Material linked to lesson and block'),
          backgroundColor: PharmaColors.emerald600,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to link material: $e')),
        );
      }
    }
  }

  Future<void> _saveDraft() async {
    if (_selectedVersion == null || !_isEditable) return;
    setState(() => _saving = true);
    try {
      for (int i = 0; i < _modules.length; i++) {
        final m = _modules[i];
        await client.courseBuilder.updateModule(
          moduleId: m.id!,
          orderIndex: i,
        );
      }
      // Save lesson fields (title, duration, ordering, type, engagement, prereqs)
      for (final entry in _lessonsByModule.entries) {
        final lessons = entry.value;
        for (int i = 0; i < lessons.length; i++) {
          final l = lessons[i];
          if (l.id == null) continue;
          await client.courseBuilder.updateLesson(
            lessonId: l.id!,
            title: l.title,
            orderIndex: i,
            durationMinutes: l.durationMinutes,
            lessonType: l.lessonType,
            minEngagementMinutes: l.minEngagementMinutes,
            prerequisiteMode: l.prerequisiteMode,
          );
        }
      }
      setState(() => _lastSaved = DateTime.now());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Draft saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _selectLesson(int lessonId) {
    setState(() {
      _selectedLessonId = lessonId;
      _blocks = [];
    });
    for (final lessons in _lessonsByModule.values) {
      for (final l in lessons) {
        if (l.id == lessonId) {
          _lessonTitleController.text = l.title;
          _lessonDurationController.text = '${l.durationMinutes ?? 15}';
          _lessonMinEngagementController.text =
              '${l.minEngagementMinutes ?? l.durationMinutes ?? 15}';
          _lessonType = l.lessonType ?? 'PDF';
          _googleUrlController.clear();
          break;
        }
      }
    }
    _loadBlocks();
  }

  Future<void> _renameModule(Module module) async {
    final controller = TextEditingController(text: module.title);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Module'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Module title'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Rename'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (newName == null || newName.isEmpty || newName == module.title) return;
    try {
      await client.courseBuilder.updateModule(moduleId: module.id!, title: newName);
      setState(() => module.title = newName);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error renaming module: $e')),
        );
      }
    }
  }

  Future<void> _addModule() async {
    if (_selectedVersion == null || !_isEditable) return;
    try {
      final module = await client.courseBuilder.createModule(
        courseVersionId: _selectedVersion!.id!,
        title: 'Module ${_modules.length + 1}',
        orderIndex: _modules.length,
      );
      await client.auditTrail.logAction(
        action: 'ModuleAdded',
        entityType: 'module',
        entityId: module.id!.toString(),
        newValueJson: '{"course_version_id":${_selectedVersion!.id},"title":"${module.title}"}',
      );
      setState(() {
        _modules.add(module);
        _lessonsByModule[module.id!] = [];
        _selectedModuleId = module.id;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating module: $e')),
        );
      }
    }
  }

  Future<void> _addLesson(int moduleId) async {
    if (!_isEditable) return;
    final titleController = TextEditingController(text: 'New Lesson');
    final minEngagementController = TextEditingController(text: '15');
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Lesson'),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Lesson title',
                  hintText: 'Enter lesson title…',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: minEngagementController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Min time to complete (minutes)',
                  helperText: 'Used for tracking time spent and completion',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (result != true) return;
    final title = titleController.text.trim();
    if (title.isEmpty) return;
    final minEng = int.tryParse(minEngagementController.text.trim()) ?? 15;

    try {
      final material = await client.material.createMaterial(
        title: '$title Material',
        materialType: 'document',
        organizationId: _course!.organizationId,
      );
      final lesson = await client.courseBuilder.createLesson(
        moduleId: moduleId,
        title: title,
        materialId: material.id!,
        orderIndex: (_lessonsByModule[moduleId]?.length ?? 0),
        durationMinutes: minEng,
        minEngagementMinutes: minEng,
        lessonType: 'PDF',
      );
      await client.auditTrail.logAction(
        action: 'LessonAdded',
        entityType: 'lesson',
        entityId: lesson.id!.toString(),
        newValueJson: '{"module_id":$moduleId}',
      );
      setState(() {
        _lessonsByModule[moduleId] = [...(_lessonsByModule[moduleId] ?? []), lesson];
        _selectedLessonId = lesson.id;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating lesson: $e')),
        );
      }
    }
  }

  Future<void> _deleteModule(int moduleId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Module?'),
        content: const Text('This will delete the module and all its lessons. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await client.courseBuilder.deleteModule(moduleId: moduleId);
      setState(() {
        _modules.removeWhere((m) => m.id == moduleId);
        _lessonsByModule.remove(moduleId);
        if (_selectedModuleId == moduleId) _selectedModuleId = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _reorderModules(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    setState(() {
      final m = _modules.removeAt(oldIndex);
      _modules.insert(newIndex, m);
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE TREE ITEM
// ═══════════════════════════════════════════════════════════════════════════════

class _ModuleTreeItem extends StatelessWidget {
  const _ModuleTreeItem({
    super.key,
    required this.module,
    required this.index,
    required this.lessons,
    required this.isSelected,
    required this.selectedLessonId,
    required this.onModuleTap,
    required this.onLessonTap,
    required this.onAddLesson,
    required this.onDeleteModule,
    required this.onRenameModule,
  });

  final Module module;
  final int index;
  final List<Lesson> lessons;
  final bool isSelected;
  final int? selectedLessonId;
  final VoidCallback onModuleTap;
  final Function(int) onLessonTap;
  final VoidCallback? onAddLesson;
  final VoidCallback? onDeleteModule;
  final VoidCallback? onRenameModule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Module header
        InkWell(
          onTap: onModuleTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: isSelected ? PharmaColors.emerald50 : Colors.transparent,
            child: Row(
              children: [
                Icon(Icons.drag_indicator, size: 16, color: PharmaColors.gray300),
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: lessons.isNotEmpty ? PharmaColors.infoBg : PharmaColors.gray100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: lessons.isNotEmpty ? PharmaColors.infoText : PharmaColors.gray500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    module.title,
                    style: PharmaTypography.bodyMedium.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (lessons.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald50,
                      borderRadius: PharmaRadius.pillRadius,
                    ),
                    child: Text(
                      '${lessons.length}',
                      style: PharmaTypography.caption.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: PharmaColors.emerald700,
                      ),
                    ),
                  ),
                const SizedBox(width: 4),
                if (onAddLesson != null || onRenameModule != null || onDeleteModule != null)
                  PopupMenuButton<String>(
                    iconSize: 16,
                    icon: Icon(Icons.more_vert, size: 16, color: PharmaColors.gray400),
                    itemBuilder: (ctx) => [
                      if (onAddLesson != null)
                        const PopupMenuItem(value: 'add', child: Text('Add Lesson')),
                      if (onRenameModule != null)
                        const PopupMenuItem(value: 'rename', child: Text('Rename')),
                      if (onDeleteModule != null)
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete', style: TextStyle(color: PharmaColors.danger)),
                        ),
                    ],
                    onSelected: (v) {
                      switch (v) {
                        case 'add':
                          onAddLesson?.call();
                          break;
                        case 'rename':
                          onRenameModule?.call();
                          break;
                        case 'delete':
                          onDeleteModule?.call();
                          break;
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
        // Lessons
        ...lessons.map((lesson) => InkWell(
              onTap: () => onLessonTap(lesson.id!),
              child: Container(
                padding: const EdgeInsets.only(left: 44, right: 12, top: 6, bottom: 6),
                color: selectedLessonId == lesson.id
                    ? PharmaColors.emerald50
                    : Colors.transparent,
                child: Row(
                  children: [
                    _lessonTypeIcon(lesson),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lesson.title,
                        style: PharmaTypography.body.copyWith(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (lesson.durationMinutes != null)
                      Text(
                        '${lesson.durationMinutes}m',
                        style: PharmaTypography.caption.copyWith(fontSize: 10),
                      ),
                  ],
                ),
              ),
            )),
        // Add lesson inline
        if (onAddLesson != null)
          InkWell(
            onTap: onAddLesson,
            child: Container(
              padding: const EdgeInsets.only(left: 44, right: 12, top: 4, bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.add, size: 14, color: PharmaColors.emerald500),
                  const SizedBox(width: 4),
                  Text(
                    'Add Lesson',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.emerald600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Divider(height: 1, color: PharmaColors.borderLight),
      ],
    );
  }

  Widget _lessonTypeIcon(Lesson lesson) {
    final type = lesson.lessonType?.toLowerCase() ?? 'pdf';
    switch (type) {
      case 'video':
        return Icon(Icons.play_circle, size: 14, color: PharmaColors.info);
      case 'scorm':
        return Icon(Icons.inventory_2, size: 14, color: PharmaColors.orange);
      case 'xapi':
        return Icon(Icons.code, size: 14, color: PharmaColors.purple);
      case 'html':
        return Icon(Icons.web, size: 14, color: PharmaColors.success);
      case 'checklist':
        return Icon(Icons.checklist, size: 14, color: PharmaColors.emerald600);
      case 'google_doc':
        return Icon(Icons.article_outlined, size: 14, color: PharmaColors.info);
      case 'google_sheet':
        return Icon(Icons.table_chart_outlined, size: 14, color: PharmaColors.success);
      case 'google_slide':
        return Icon(Icons.slideshow_outlined, size: 14, color: PharmaColors.orange);
      default:
        return Icon(Icons.description, size: 14, color: PharmaColors.danger);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _WorkflowChip extends StatelessWidget {
  const _WorkflowChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;
    switch (status) {
      case 'draft':
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray700;
        label = 'DRAFT';
        break;
      case 'pending_qa':
      case 'under_review':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        label = 'UNDER REVIEW';
        break;
      case 'approved':
      case 'published':
      case 'effective':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'QA APPROVED';
        break;
      case 'rejected':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.dangerText;
        label = 'REJECTED';
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = status.toUpperCase();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg, letterSpacing: 0.5),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: PharmaColors.emerald600),
              const SizedBox(width: 8),
              Text(title,
                  style:
                      PharmaTypography.headingSmall.copyWith(fontSize: 14)),
            ],
          ),
          const SizedBox(height: PharmaSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

class _StepperDot extends StatelessWidget {
  const _StepperDot({
    required this.label,
    required this.isActive,
    required this.isCompleted,
  });

  final String label;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive || isCompleted
                ? PharmaColors.emerald600
                : PharmaColors.gray200,
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 14, color: PharmaColors.cardBg)
              : isActive
                  ? const Icon(Icons.circle, size: 8, color: PharmaColors.cardBg)
                  : null,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive
                ? PharmaColors.emerald700
                : isCompleted
                    ? PharmaColors.emerald600
                    : PharmaColors.gray400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _StepperLine extends StatelessWidget {
  const _StepperLine({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: isCompleted ? PharmaColors.emerald500 : PharmaColors.gray200,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// BLOCK EDITOR COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _BlockTypeOption {
  const _BlockTypeOption({
    required this.type,
    required this.label,
    required this.icon,
    required this.color,
  });
  final String type;
  final String label;
  final IconData icon;
  final Color color;
}

class _BlockTypeChip extends StatelessWidget {
  const _BlockTypeChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: PharmaRadius.cardRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(label, style: PharmaTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            )),
          ],
        ),
      ),
    );
  }
}

class _AddBlockDivider extends StatefulWidget {
  const _AddBlockDivider({required this.onAddBlock});
  final Function(String blockType) onAddBlock;

  @override
  State<_AddBlockDivider> createState() => _AddBlockDividerState();
}

class _AddBlockDividerState extends State<_AddBlockDivider> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: _hovering ? 36 : 16,
        child: Center(
          child: _hovering
              ? Row(
                  children: [
                    Expanded(child: Divider(color: PharmaColors.emerald300)),
                    PopupMenuButton<String>(
                      onSelected: widget.onAddBlock,
                      tooltip: 'Insert block',
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: PharmaColors.emerald50,
                          borderRadius: PharmaRadius.pillRadius,
                          border: Border.all(color: PharmaColors.emerald300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, size: 14, color: PharmaColors.emerald600),
                            const SizedBox(width: 2),
                            Text('Add', style: PharmaTypography.caption.copyWith(
                              color: PharmaColors.emerald600, fontSize: 10,
                            )),
                          ],
                        ),
                      ),
                      itemBuilder: (_) => [
                        _popupItem('text', Icons.subject, 'Text'),
                        _popupItem('heading', Icons.title, 'Heading'),
                        _popupItem('video', Icons.play_circle_outline, 'Video'),
                        _popupItem('upload', Icons.upload_file, 'Upload'),
                        _popupItem('quiz', Icons.quiz_outlined, 'Quiz'),
                        _popupItem('assignment', Icons.assignment_outlined, 'Assignment'),
                        _popupItem('google_doc', Icons.article_outlined, 'Google Docs'),
                        _popupItem('google_sheet', Icons.table_chart_outlined, 'Google Sheets'),
                        _popupItem('google_slide', Icons.slideshow_outlined, 'Google Slides'),
                        _popupItem('code_sandbox', Icons.code, 'CodeSandbox'),
                        _popupItem('audio', Icons.audiotrack, 'Audio'),
                      ],
                    ),
                    Expanded(child: Divider(color: PharmaColors.emerald300)),
                  ],
                )
              : Divider(color: PharmaColors.borderLight),
        ),
      ),
    );
  }

  PopupMenuItem<String> _popupItem(String value, IconData icon, String label) {
    return PopupMenuItem(
      value: value,
      child: Row(children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Text(label),
      ]),
    );
  }
}

class _BlockEditorWidget extends StatefulWidget {
  const _BlockEditorWidget({
    super.key,
    required this.block,
    required this.onUpdate,
    required this.onDelete,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.inputDecoration,
    this.onLinkUploadMaterial,
  });

  final LessonBlock block;
  final Function(String contentJson) onUpdate;
  final VoidCallback onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final InputDecoration Function(String hint) inputDecoration;
  /// For [blockType] `upload` only: opens org material picker and links lesson + block.
  final Future<void> Function()? onLinkUploadMaterial;

  @override
  State<_BlockEditorWidget> createState() => _BlockEditorWidgetState();
}

class _BlockEditorWidgetState extends State<_BlockEditorWidget> {
  late Map<String, dynamic> _content;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    try {
      _content = jsonDecode(widget.block.contentJson) as Map<String, dynamic>;
    } catch (_) {
      _content = {};
    }
  }

  @override
  void didUpdateWidget(covariant _BlockEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.block.contentJson != widget.block.contentJson) {
      try {
        _content = jsonDecode(widget.block.contentJson) as Map<String, dynamic>;
      } catch (_) {
        _content = {};
      }
    }
  }

  void _scheduleUpdate() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      widget.onUpdate(jsonEncode(_content));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  IconData get _blockIcon {
    switch (widget.block.blockType) {
      case 'text': return Icons.subject;
      case 'heading': return Icons.title;
      case 'video': return Icons.play_circle_outline;
      case 'upload': return Icons.upload_file;
      case 'quiz': return Icons.quiz_outlined;
      case 'assignment': return Icons.assignment_outlined;
      case 'google_doc': return Icons.article_outlined;
      case 'google_sheet': return Icons.table_chart_outlined;
      case 'google_slide': return Icons.slideshow_outlined;
      case 'code_sandbox': return Icons.code;
      case 'audio': return Icons.audiotrack;
      default: return Icons.extension;
    }
  }

  String get _blockLabel {
    switch (widget.block.blockType) {
      case 'text': return 'Text';
      case 'heading': return 'Heading';
      case 'video': return 'Video';
      case 'upload': return 'Upload';
      case 'quiz': return 'Quiz';
      case 'assignment': return 'Assignment';
      case 'google_doc': return 'Google Docs';
      case 'google_sheet': return 'Google Sheets';
      case 'google_slide': return 'Google Slides';
      case 'code_sandbox': return 'CodeSandbox';
      case 'audio': return 'Audio';
      default: return widget.block.blockType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Block header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: PharmaColors.pageBg,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(Icons.drag_indicator, size: 16, color: PharmaColors.gray300),
                const SizedBox(width: 6),
                Icon(_blockIcon, size: 16, color: PharmaColors.emerald600),
                const SizedBox(width: 6),
                Text(_blockLabel, style: PharmaTypography.caption.copyWith(
                  fontWeight: FontWeight.w600, color: PharmaColors.textSecondary,
                )),
                const Spacer(),
                if (widget.onMoveUp != null)
                  IconButton(
                    onPressed: widget.onMoveUp,
                    icon: const Icon(Icons.arrow_upward, size: 14),
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    padding: EdgeInsets.zero,
                    color: PharmaColors.gray400,
                    tooltip: 'Move up',
                  ),
                if (widget.onMoveDown != null)
                  IconButton(
                    onPressed: widget.onMoveDown,
                    icon: const Icon(Icons.arrow_downward, size: 14),
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    padding: EdgeInsets.zero,
                    color: PharmaColors.gray400,
                    tooltip: 'Move down',
                  ),
                IconButton(
                  onPressed: widget.onDelete,
                  icon: Icon(Icons.close, size: 14, color: PharmaColors.danger),
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  padding: EdgeInsets.zero,
                  tooltip: 'Delete block',
                ),
              ],
            ),
          ),
          // Block body
          Padding(
            padding: const EdgeInsets.all(12),
            child: _buildBlockBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockBody() {
    switch (widget.block.blockType) {
      case 'text':
        return _buildTextBlock();
      case 'heading':
        return _buildHeadingBlock();
      case 'video':
        return _buildVideoBlock();
      case 'upload':
        return _buildUploadBlock();
      case 'quiz':
        return _buildQuizBlock();
      case 'assignment':
        return _buildAssignmentBlock();
      case 'google_doc':
      case 'google_sheet':
      case 'google_slide':
        return _buildGoogleBlock();
      case 'code_sandbox':
        return _buildCodeSandboxBlock();
      case 'audio':
        return _buildAudioBlock();
      default:
        return Text('Unknown block type: ${widget.block.blockType}');
    }
  }

  Widget _buildTextBlock() {
    return TextField(
      controller: TextEditingController(text: _content['html'] as String? ?? ''),
      maxLines: 6,
      decoration: widget.inputDecoration('Enter rich text content (HTML supported)...'),
      style: PharmaTypography.body,
      onChanged: (v) {
        _content['html'] = v;
        _scheduleUpdate();
      },
    );
  }

  Widget _buildHeadingBlock() {
    final level = _content['level'] as int? ?? 2;
    return Row(
      children: [
        DropdownButton<int>(
          value: level,
          items: [1, 2, 3].map((l) => DropdownMenuItem(
            value: l,
            child: Text('H$l', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: l == 1 ? 18 : l == 2 ? 16 : 14,
            )),
          )).toList(),
          onChanged: (v) {
            if (v != null) {
              setState(() => _content['level'] = v);
              _scheduleUpdate();
            }
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: TextEditingController(text: _content['text'] as String? ?? ''),
            decoration: widget.inputDecoration('Enter heading text...'),
            style: PharmaTypography.headingMedium.copyWith(
              fontSize: level == 1 ? 22 : level == 2 ? 18 : 15,
            ),
            onChanged: (v) {
              _content['text'] = v;
              _scheduleUpdate();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoBlock() {
    final url = _content['url'] as String? ?? '';
    final platform = _content['platform'] as String? ?? 'direct';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: TextEditingController(text: url),
          decoration: widget.inputDecoration('Paste YouTube, Vimeo, Cloudflare, or Bunny video URL...'),
          style: PharmaTypography.body,
          keyboardType: TextInputType.url,
          onChanged: (v) {
            final detected = VideoUrlParser.detectPlatform(v);
            setState(() {
              _content['url'] = v;
              _content['platform'] = detected.name;
            });
            _scheduleUpdate();
          },
        ),
        if (url.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: PharmaColors.infoBg,
              borderRadius: PharmaRadius.pillRadius,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.play_circle, size: 14, color: PharmaColors.info),
                const SizedBox(width: 4),
                Text(
                  VideoUrlParser.platformLabel(VideoPlatform.values.firstWhere(
                    (p) => p.name == platform,
                    orElse: () => VideoPlatform.direct,
                  )),
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.info),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUploadBlock() {
    final materialId = _content['materialId'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (materialId != null && materialId is int && materialId > 0)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PharmaColors.successBg,
              borderRadius: PharmaRadius.cardRadius,
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 16, color: PharmaColors.success),
                const SizedBox(width: 8),
                Text('Material #$materialId linked',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.success)),
              ],
            ),
          )
        else
          Text('No file linked yet', style: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary)),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: widget.onLinkUploadMaterial == null
              ? null
              : () async {
                  await widget.onLinkUploadMaterial!();
                  if (mounted) setState(() {});
                },
          icon: const Icon(Icons.upload_file, size: 16),
          label: Text(materialId != null ? 'Change Material' : 'Link Material'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.emerald600,
            side: BorderSide(color: PharmaColors.emerald200),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizBlock() {
    final quizTitle = _content['quizTitle'] as String? ?? '';
    final quizId = _content['quizId'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (quizId != null && quizId is int)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PharmaColors.purple.withOpacity(0.08),
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(color: PharmaColors.purple.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.quiz, size: 16, color: PharmaColors.purple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(quizTitle.isNotEmpty ? quizTitle : 'Quiz #$quizId',
                      style: PharmaTypography.body.copyWith(color: PharmaColors.purple)),
                ),
              ],
            ),
          )
        else
          Text('No quiz selected', style: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: quizId?.toString() ?? ''),
          decoration: widget.inputDecoration('Enter Quiz/Assessment ID'),
          keyboardType: TextInputType.number,
          onChanged: (v) {
            final id = int.tryParse(v);
            _content['quizId'] = id;
            _scheduleUpdate();
          },
        ),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: quizTitle),
          decoration: widget.inputDecoration('Quiz title (for display)'),
          onChanged: (v) {
            _content['quizTitle'] = v;
            _scheduleUpdate();
          },
        ),
      ],
    );
  }

  Widget _buildAssignmentBlock() {
    final title = _content['title'] as String? ?? '';
    final instructions = _content['instructions'] as String? ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: TextEditingController(text: title),
          decoration: widget.inputDecoration('Assignment title'),
          style: PharmaTypography.bodyMedium,
          onChanged: (v) {
            _content['title'] = v;
            _scheduleUpdate();
          },
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: instructions),
          decoration: widget.inputDecoration('Instructions for the learner...'),
          maxLines: 4,
          style: PharmaTypography.body,
          onChanged: (v) {
            _content['instructions'] = v;
            _scheduleUpdate();
          },
        ),
      ],
    );
  }

  Widget _buildGoogleBlock() {
    final url = _content['url'] as String? ?? '';
    final typeLabel = widget.block.blockType == 'google_doc'
        ? 'Google Docs'
        : widget.block.blockType == 'google_sheet'
            ? 'Google Sheets'
            : 'Google Slides';
    return TextField(
      controller: TextEditingController(text: url),
      decoration: widget.inputDecoration('Paste $typeLabel URL...'),
      style: PharmaTypography.body,
      keyboardType: TextInputType.url,
      onChanged: (v) {
        _content['url'] = v;
        _scheduleUpdate();
      },
    );
  }

  Widget _buildCodeSandboxBlock() {
    return TextField(
      controller: TextEditingController(text: _content['url'] as String? ?? ''),
      decoration: widget.inputDecoration('Paste CodeSandbox embed URL...'),
      style: PharmaTypography.body,
      keyboardType: TextInputType.url,
      onChanged: (v) {
        _content['url'] = v;
        _scheduleUpdate();
      },
    );
  }

  Widget _buildAudioBlock() {
    final materialId = _content['materialId'];
    final fileName = _content['fileName'] as String? ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (materialId != null && materialId is int && materialId > 0)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PharmaColors.purple.withOpacity(0.08),
              borderRadius: PharmaRadius.cardRadius,
            ),
            child: Row(
              children: [
                Icon(Icons.audiotrack, size: 16, color: PharmaColors.purple),
                const SizedBox(width: 8),
                Text(fileName.isNotEmpty ? fileName : 'Audio #$materialId',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.purple)),
              ],
            ),
          )
        else
          Text('No audio file linked', style: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary)),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Use the materials library to upload audio files (mp3, wav, ogg, m4a)')),
            );
          },
          icon: const Icon(Icons.upload, size: 16),
          label: Text(materialId != null ? 'Change Audio' : 'Upload Audio'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.purple,
            side: BorderSide(color: PharmaColors.purple.withOpacity(0.3)),
          ),
        ),
      ],
    );
  }
}
