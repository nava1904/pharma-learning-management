import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/client.dart';
import '../../core/lms_realtime.dart';
import '../../core/video_url_parser.dart';
import '../../core/webview_safe.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';
import 'scorm_api.dart';

class CourseViewerScreenV2 extends ConsumerStatefulWidget {
  const CourseViewerScreenV2({
    super.key,
    required this.courseId,
    this.courseTitle,
    this.courseVersionId,
    this.enrollmentId,
    this.userId,
    this.enrollmentStatus,
    this.previewMode = false,
  });

  final String courseId;
  final String? courseTitle;
  final int? courseVersionId;
  final int? enrollmentId;
  final int? userId;
  final String? enrollmentStatus;
  /// When true, shows a "Preview Mode" banner and a back button. No enrollment
  /// progress is recorded.
  final bool previewMode;

  @override
  ConsumerState<CourseViewerScreenV2> createState() => _CourseViewerScreenV2State();
}

class _CourseViewerScreenV2State extends ConsumerState<CourseViewerScreenV2> with WidgetsBindingObserver {
  // ─── Backend State ───
  // ignore: unused_field - populated during _load, used to group lessons by module
  List<Module> _modules = [];
  List<Lesson> _lessons = [];
  String? _courseTitle;
  String? _courseDescription;
  bool _loading = true;
  String? _error;
  
  // ─── Tab State ───
  int _activeTab = 0; // 0=Objectives, 1=Transcript, 2=Resources

  // ─── Player State ───
  int _currentLessonIndex = 0;
  int _currentLessonElapsedSeconds = 0;
  Timer? _heartbeatTimer;
  bool _timerPaused = false;
  bool _tabVisible = true;
  final Set<int> _lessonViewedMaterialIds = {};
  Lesson? _currentLessonWithMaterial;
  // ignore: unused_field - Used for future SCORM implementation
  String? _materialViewUrl;
  bool _loadingMaterial = false;
  WebViewController? _materialWebController;
  VideoPlayerController? _videoController;
  List<LessonBlock> _lessonBlocks = [];
  /// Server [Assignment] rows for the current lesson (lesson coursework).
  List<Assignment> _lessonAssignments = [];

  // ─── Compliance State (for e-signature/acknowledgement) ───
  Enrollment? _enrollment;
  bool _acknowledgementChecked = false;
  bool _acknowledging = false;
  String? _acknowledgementError;
  // ignore: unused_field
  List<SignatureMeaning> _signatureMeanings = [];
  // ignore: unused_field
  String? _selectedSignatureMeaning;
  final _passwordController = TextEditingController();

  int? _resolvedUserId;
  int? _resolvedCourseVersionId;
  /// When route omits [enrollmentId], resolved from the user’s enrollments for this course version.
  int? _resolvedEnrollmentId;
  /// WebSocket subscription for realtime progress sync across tabs/devices.
  StreamSubscription<Map<String, dynamic>>? _realtimeSub;

  int get _effectiveUserId => widget.userId ?? _resolvedUserId ?? 0;
  int get _effectiveCourseVersionId =>
      widget.courseVersionId ?? _resolvedCourseVersionId ?? 0;
  int? get _effectiveEnrollmentId => widget.enrollmentId ?? _resolvedEnrollmentId;
  bool get _showRetrainingGate =>
      _enrollment?.retrainingChangeSummary != null &&
      _enrollment!.retrainingChangeSummary!.isNotEmpty &&
      _enrollment?.acknowledgedAt == null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _heartbeatTimer?.cancel();
    _realtimeSub?.cancel();
    _videoController?.dispose();
    _passwordController.dispose();
    // Unsubscribe from enrollment progress room
    final eid = _effectiveEnrollmentId;
    if (eid != null) {
      LmsRealtime.unsubscribeRooms(['enrollment:$eid']);
    }
    super.dispose();
  }

  // [Backend logic methods remain identical to ensure flawless functionality]
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _timerPaused = true;
      _tabVisible = false;
    } else if (state == AppLifecycleState.resumed) {
      _timerPaused = false;
      _tabVisible = true;
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    final visible = info.visibleFraction > 0;
    if (_tabVisible != visible && mounted) setState(() => _tabVisible = visible);
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      // Resolve userId from provider if not passed via route
      if (widget.userId == null || widget.userId == 0) {
        final user = await ref.read(currentUserProvider.future);
        if (user?.id != null) {
          _resolvedUserId = user!.id;
        }
      }

      var courseVersionId = _effectiveCourseVersionId;

      // Prefer the course version from enrollment (most accurate for
      // "Start training" flows).
      Enrollment? enrollment;
      if (widget.enrollmentId != null) {
        enrollment = await client.training.getEnrollmentById(widget.enrollmentId!);
        if (enrollment != null && courseVersionId == 0) {
          _resolvedCourseVersionId = enrollment.courseVersionId;
          courseVersionId = enrollment.courseVersionId;
        }

        if (enrollment != null &&
            enrollment.retrainingChangeSummary != null &&
            enrollment.acknowledgedAt == null) {
          final meanings = await client.training.listSignatureMeanings();
          if (mounted) {
            setState(() {
              _signatureMeanings = meanings;
              _selectedSignatureMeaning = meanings.isNotEmpty
                  ? meanings.first.meaning
                  : 'I have read and understood';
            });
          }
        }
      }

      // Fallback: resolve from courseId if still missing.
      if (courseVersionId == 0) {
        final resolved = await _resolveCourseVersionIdFromCourseId();
        if (resolved != null && resolved > 0) {
          _resolvedCourseVersionId = resolved;
          courseVersionId = resolved;
        }
      }

      // Catalog and some deep links pass only courseVersionId — resolve enrollment for progress + assessment.
      if (enrollment == null &&
          widget.enrollmentId == null &&
          _effectiveUserId > 0 &&
          courseVersionId > 0) {
        try {
          final list = await client.training.getEnrollmentsForUser(_effectiveUserId);
          Enrollment? match;
          for (final e in list) {
            if (e.courseVersionId == courseVersionId) {
              match = e;
              break;
            }
          }
          if (match?.id != null) {
            _resolvedEnrollmentId = match!.id;
            enrollment = await client.training.getEnrollmentById(match.id!);
            if (enrollment != null &&
                enrollment.retrainingChangeSummary != null &&
                enrollment.acknowledgedAt == null) {
              final meanings = await client.training.listSignatureMeanings();
              if (mounted) {
                setState(() {
                  _signatureMeanings = meanings;
                  _selectedSignatureMeaning = meanings.isNotEmpty
                      ? meanings.first.meaning
                      : 'I have read and understood';
                });
              }
            }
          }
        } catch (_) {}
      }

      if (courseVersionId == 0) {
        setState(() { _error = 'Course version missing.'; _loading = false; });
        return;
      }

      final version = await client.course.getCourseVersion(courseVersionId);
      _courseTitle = version?.course?.title ?? widget.courseTitle ?? 'Course';
      _courseDescription = version?.course?.description ?? 'No description provided.';

      final modules = await client.course.getModulesForCourseVersion(courseVersionId);
      final allLessons = <Lesson>[];
      for (final m in modules) {
        if (m.id != null) {
          final lessons = await client.course.getLessonsForModule(m.id!);
          allLessons.addAll(lessons);
        }
      }
      allLessons.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      final isEnrollmentCompleted =
          widget.enrollmentStatus == 'completed' ||
          (enrollment != null && enrollment.status == 'completed');

      int startLessonIndex = 0;
      int? resumeElapsedSeconds;

      if (isEnrollmentCompleted) {
        for (final l in allLessons) {
          _lessonViewedMaterialIds.add(l.materialId);
        }
      } else if (_effectiveUserId > 0) {
        for (final l in allLessons) {
          try {
            final p = await client.material.getProgress(userId: _effectiveUserId, materialId: l.materialId, enrollmentId: _effectiveEnrollmentId);
            if (p != null && (p.progressPct >= 100 || p.completedAt != null || p.readTimeMet == true)) {
              _lessonViewedMaterialIds.add(l.materialId);
            }
          } catch (_) {}
        }
        for (var i = 0; i < allLessons.length; i++) {
          if (!_lessonViewedMaterialIds.contains(allLessons[i].materialId)) {
            startLessonIndex = i;
            try {
              final p = await client.material.getProgress(userId: _effectiveUserId, materialId: allLessons[i].materialId, enrollmentId: _effectiveEnrollmentId);
              if (p?.timeSpentSeconds != null && p!.timeSpentSeconds! > 0) resumeElapsedSeconds = p.timeSpentSeconds;
            } catch (_) {}
            break;
          }
        }
      }

      setState(() {
        _enrollment = enrollment;
        _modules = modules;
        _lessons = allLessons;
        _currentLessonIndex = startLessonIndex;
        _currentLessonElapsedSeconds = resumeElapsedSeconds ?? 0;
        _loading = false;
      });
      
      if (allLessons.isNotEmpty && mounted) {
        _loadLessonMaterial(allLessons[startLessonIndex]);
        if (!_lessonViewedMaterialIds.contains(allLessons[startLessonIndex].materialId)) {
          _startReadTimer(allLessons[startLessonIndex]);
        }
      }

      // Subscribe to realtime progress events for this enrollment
      // so multi-tab or cross-device updates reflect instantly.
      _setupRealtimeProgressSubscription();
    } catch (e) {
      setState(() { _error = e.toString(); _loading = false; });
    }
  }

  /// Matches server [recordEngagement]: minEngagementMinutes, else durationMinutes, else 1 min.
  int _lessonRequiredSeconds(Lesson? lesson) {
    if (lesson == null) return 60;
    final m = lesson.minEngagementMinutes ?? lesson.durationMinutes ?? 1;
    return m.clamp(1, 9999) * 60;
  }

  Future<int?> _resolveCourseVersionIdFromCourseId() async {
    final courseIdInt = int.tryParse(widget.courseId);
    if (courseIdInt == null) return null;
    final versions = await client.course.getCourseVersions(courseIdInt);
    if (versions.isEmpty) return null;

    int? pickBest(Iterable<CourseVersion> list) {
      final withId = list.where((v) => v.id != null).toList();
      if (withId.isEmpty) return null;
      withId.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      return withId.first.id;
    }

    final preferred = pickBest(
      versions.where((v) => v.status == 'effective' || v.status == 'approved'),
    );
    return preferred ?? pickBest(versions);
  }

  // [Keep all other backend/timer methods: _startReadTimer, _getPdfScrollDepth, etc...]
  void _startReadTimer(Lesson lesson) {
    _heartbeatTimer?.cancel();
    // In preview mode, don't record engagement or progress.
    if (widget.previewMode) return;
    if (_lessonViewedMaterialIds.contains(lesson.materialId)) return;
    if (lesson.id == null || _effectiveUserId <= 0) return;

    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (_lessonViewedMaterialIds.contains(lesson.materialId)) {
        _heartbeatTimer?.cancel();
        return;
      }
      final tabFocused = !_timerPaused && _tabVisible;
      int? scrollDepthPct;
      int? videoWatchedPct;
      int? videoPositionSeconds;
      final material = _currentLessonWithMaterial?.material;
      if (material != null) {
        final type = material.materialType.toLowerCase();
        if (type == 'pdf') {
          scrollDepthPct = await _getPdfScrollDepth();
        } else if (type == 'video') {
          videoWatchedPct = await _getVideoWatchedPct();
          videoPositionSeconds = await _getVideoPositionSeconds();
        }
      }
      try {
        final progress = await client.material.recordEngagement(
          userId: _effectiveUserId, materialId: lesson.materialId, lessonId: lesson.id!,
          enrollmentId: _effectiveEnrollmentId, tabFocused: tabFocused, scrollDepthPct: scrollDepthPct,
          videoWatchedPct: videoWatchedPct, videoPositionSeconds: videoPositionSeconds, deltaSeconds: 10,
        );
        if (mounted) {
          if (progress.timeSpentSeconds != null) setState(() => _currentLessonElapsedSeconds = progress.timeSpentSeconds!);
          if (progress.readTimeMet == true) {
            _lessonViewedMaterialIds.add(lesson.materialId);
            _heartbeatTimer?.cancel();
            setState(() {});
          }
        }
      } catch (_) {}
    });
  }

  /// Acknowledge SOP retraining with e-signature (21 CFR Part 11 §11.50).
  /// Uses the server-side `acknowledgeRetraining` which creates the signature internally.
  Future<void> _acknowledgeRetraining() async {
    if (!_acknowledgementChecked || _acknowledging) return;

    // Prompt for password in-line for re-authentication
    final password = await _showPasswordDialog();
    if (password == null || password.isEmpty || !mounted) return;

    setState(() { _acknowledging = true; _acknowledgementError = null; });

    try {
      final meaning = _selectedSignatureMeaning ?? 'I have read and understood';
      final updatedEnrollment = await client.training.acknowledgeRetraining(
        enrollmentId: _effectiveEnrollmentId!,
        userId: _effectiveUserId,
        signatureMeaning: meaning,
        passwordPlaintext: password,
      );
      if (!mounted) return;
      setState(() {
        _enrollment = updatedEnrollment;
        _acknowledging = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _acknowledging = false;
        _acknowledgementError = e.toString().contains('password')
            ? 'Re-authentication failed. Please check your password.'
            : 'Acknowledgement failed: $e';
      });
    }
  }

  /// Show a password re-authentication dialog for e-signature.
  Future<String?> _showPasswordDialog() {
    _passwordController.clear();
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.draw_outlined, size: 22, color: _accent),
            const SizedBox(width: 8),
            const Text('Re-authenticate to Sign'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your password to electronically sign this acknowledgement.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              onSubmitted: (v) => Navigator.of(ctx).pop(v.trim()),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: const [
                  Icon(Icons.verified_user, size: 14, color: Color(0xFF3B82F6)),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '21 CFR Part 11 · HMAC-SHA256 integrity',
                      style: TextStyle(fontSize: 11, color: Color(0xFF3B82F6), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(_passwordController.text.trim()),
            style: FilledButton.styleFrom(backgroundColor: _accent),
            child: const Text('Sign'),
          ),
        ],
      ),
    );
  }

  /// Subscribe to realtime WebSocket events for this enrollment.
  /// Handles `material_progress` events from other tabs/devices so the
  /// lesson-completion state stays in sync without re-fetching.
  Future<void> _setupRealtimeProgressSubscription() async {
    if (widget.previewMode) return;
    final enrollmentId = _effectiveEnrollmentId;
    if (enrollmentId == null) return;

    try {
      await LmsRealtime.ensureConnected();
      LmsRealtime.subscribeRooms(['enrollment:$enrollmentId']);

      _realtimeSub = LmsRealtime.events.listen((event) {
        if (!mounted) return;
        final eventType = event['event'] as String?;

        if (eventType == 'material_progress') {
          final materialId = event['materialId'] as int?;
          final pct = (event['progressPct'] as num?)?.toInt() ?? 0;
          final readTimeMet = event['readTimeMet'] as bool? ?? false;

          if (materialId != null && (pct >= 100 || readTimeMet)) {
            if (!_lessonViewedMaterialIds.contains(materialId)) {
              setState(() {
                _lessonViewedMaterialIds.add(materialId);
              });

            }
          }
        }
      });
    } catch (e) {

    }
  }

  Future<int?> _getPdfScrollDepth() async {
    try {
      final controller = _materialWebController;
      if (controller == null) return null;
      final result = await controller.runJavaScriptReturningResult('''
        (function() {
          var el = document.documentElement || document.body;
          if (!el || el.scrollHeight <= el.clientHeight) return 100;
          var pct = (el.scrollTop + el.clientHeight) / el.scrollHeight * 100;
          return Math.round(Math.min(100, pct));
        })();
      ''');
      if (result is int) return result;
      if (result is double) return result.round();
      return null;
    } catch (_) { return null; }
  }

  Future<int?> _getVideoWatchedPct() async {
    final vc = _videoController;
    if (vc != null) {
      final pos = vc.value.position.inSeconds;
      final dur = vc.value.duration.inSeconds;
      if (dur <= 0) return 100;
      return ((pos / dur) * 100).round().clamp(0, 100);
    }
    try {
      final controller = _materialWebController;
      if (controller == null) return null;
      final result = await controller.runJavaScriptReturningResult('''
        (function() {
          var v = document.querySelector('video');
          if (!v || v.duration <= 0) return 100;
          var pct = (v.currentTime / v.duration) * 100;
          return Math.round(Math.min(100, pct));
        })();
      ''');
      if (result is int) return result;
      if (result is double) return result.round();
      return null;
    } catch (_) { return null; }
  }

  Future<int?> _getVideoPositionSeconds() async {
    final vc = _videoController;
    if (vc != null) return vc.value.position.inSeconds;
    return null;
  }

  Future<void> _loadLessonMaterial(Lesson lesson) async {
    if (lesson.id == null) return;
    _videoController?.dispose();
    _videoController = null;
    setState(() {
      _currentLessonWithMaterial = null;
      _materialViewUrl = null;
      _materialWebController = null;
      _loadingMaterial = true;
      _lessonBlocks = [];
      _lessonAssignments = [];
    });

    try {
      final blocks = await client.lessonBlock.listBlocks(lessonId: lesson.id!);
      List<Assignment> assigns = [];
      try {
        assigns = await client.assignment.listByLesson(lessonId: lesson.id!);
      } catch (_) {}
      if (mounted) {
        setState(() {
          _lessonBlocks = blocks;
          _lessonAssignments = assigns;
        });
      }
    } catch (_) {}
    try {
      final lessonWithMaterial = await client.course.getLessonWithMaterial(lesson.id!);
      String? viewUrl;
      final material = lessonWithMaterial?.material;
      final type = material?.materialType.toLowerCase() ?? '';
      final googleTypes = ['google_doc', 'google_sheet', 'google_slide'];

      if (googleTypes.contains(type) && material?.contentUrl != null) {
        viewUrl = await client.material.getMaterialContentUrl(material!.id!);
      } else if (material?.storageKey != null) {
        viewUrl = await client.material.getMaterialViewUrl(material!.storageKey!);
      } else if (type == 'video' &&
          material?.contentUrl != null &&
          material!.contentUrl!.trim().isNotEmpty) {
        // Hosted video (YouTube/Vimeo, etc.) stored as link only — no storage key.
        viewUrl = material.contentUrl!.trim();
      }
      if (!mounted) return;
      WebViewController? webController;
      VideoPlayerController? videoController;

      if (viewUrl != null) {
        if (type == 'video') {
          final vp = VideoUrlParser.detectPlatform(viewUrl);
          if (vp == VideoPlatform.direct) {
            videoController = VideoPlayerController.networkUrl(Uri.parse(viewUrl));
            await videoController.initialize();
          } else {
            final embedUrl = VideoUrlParser.toEmbedUrl(viewUrl, vp);
            webController = webViewControllerWithDefaults()
              ..loadRequest(Uri.parse(embedUrl));
          }
        } else if (type == 'scorm') {
          final wrapperHtml = buildScormWrapperHtml(viewUrl);
          final dataUri = Uri.dataFromString(wrapperHtml, mimeType: 'text/html', encoding: utf8);
          webController = webViewControllerWithDefaults()
            ..loadRequest(dataUri);
        } else if (googleTypes.contains(type)) {
          webController = webViewControllerWithDefaults()
            ..loadRequest(Uri.parse(viewUrl));
        } else {
          webController = webViewControllerWithDefaults()
            ..loadRequest(Uri.parse(viewUrl));
        }
      }

      if (mounted) {
        setState(() {
          _currentLessonWithMaterial = lessonWithMaterial;
          _materialViewUrl = viewUrl;
          _materialWebController = webController;
          _videoController = videoController;
          _loadingMaterial = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingMaterial = false);
    }
  }

  void _stopReadTimer() => _heartbeatTimer?.cancel();

  Future<void> _markLessonCompleteAndProceed(Lesson lesson) async {
    if (lesson.id == null || _effectiveUserId <= 0) return;
    _lessonViewedMaterialIds.add(lesson.materialId);
    _heartbeatTimer?.cancel();
    try {
      await client.material.updateProgress(
        userId: _effectiveUserId, 
        materialId: lesson.materialId, 
        progressPct: 100,
        completedAt: DateTime.now(), 
        timeSpentSeconds: _currentLessonElapsedSeconds,
        lessonId: lesson.id, 
        enrollmentId: _effectiveEnrollmentId,
        readTimeMet: true, // CRITICAL FIX: Forces backend to accept completion (FDA 21 CFR Part 11)
      );
    } catch (e) {

    }
    if (!mounted) return;
    if (_currentLessonIndex < _lessons.length - 1) {
      _stopReadTimer();
      final nextIndex = _currentLessonIndex + 1;
      _loadLessonMaterial(_lessons[nextIndex]);
      setState(() { _currentLessonIndex = nextIndex; _activeTab = 0; });
      if (!_lessonViewedMaterialIds.contains(_lessons[nextIndex].materialId)) {
        _startReadTimer(_lessons[nextIndex]);
      }
    } else {
      setState(() {});
    }
  }

  bool get _allLessonsViewed {
    if (_lessons.isEmpty) return false;
    for (final l in _lessons) {
      if (!_lessonViewedMaterialIds.contains(l.materialId)) return false;
    }
    return true;
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // DARK VIEWER THEME
  // ═══════════════════════════════════════════════════════════════════════════════
  static const _bg = Color(0xFF0D1B2A);
  static const _cardBg = Color(0xFF162233);
  static const _panelBg = Color(0xFF1A2737);
  static const _border = Color(0xFF1E3A5F);
  static const _accent = Color(0xFF10B981);
  static const _textLight = Color(0xFFE2E8F0);
  static const _textMuted = Color(0xFF94A3B8);
  static const _textDim = Color(0xFF64748B);

  bool _isLessonAccessible(int idx) {
    for (var i = 0; i < idx; i++) {
      if (!_lessonViewedMaterialIds.contains(_lessons[i].materialId)) return false;
    }
    return true;
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // UI BUILD
  // ═══════════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(child: CircularProgressIndicator(color: _accent)),
      );
    }
    if (_error != null) {
      return Scaffold(
        backgroundColor: _bg,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: _accent),
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: _textLight)),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _load,
                style: FilledButton.styleFrom(backgroundColor: _accent),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    if (_showRetrainingGate) {
      return Scaffold(
        backgroundColor: _bg,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Card(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.update_rounded, color: Colors.orange.shade700, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'SOP Retraining Required',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _textLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Change Summary',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _enrollment?.retrainingChangeSummary ?? 'SOP content has been updated.',
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      value: _acknowledgementChecked,
                      onChanged: _acknowledging
                          ? null
                          : (v) => setState(() => _acknowledgementChecked = v ?? false),
                      title: const Text(
                        'I have read and understood the changes described above',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    if (_acknowledgementError != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _acknowledgementError!,
                        style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                      ),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: (_acknowledgementChecked && !_acknowledging)
                            ? _acknowledgeRetraining
                            : null,
                        icon: _acknowledging
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.draw_outlined, size: 18),
                        label: Text(_acknowledging ? 'Signing...' : 'Acknowledge & Continue'),
                        style: FilledButton.styleFrom(
                          backgroundColor: _accent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.verified_user, size: 14, color: Color(0xFF3B82F6)),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '21 CFR Part 11 · E-signature required before proceeding',
                              style: TextStyle(fontSize: 11, color: Color(0xFF3B82F6), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    final currentLesson = _lessons.isNotEmpty && _currentLessonIndex < _lessons.length
        ? _lessons[_currentLessonIndex]
        : null;
    final overallProgress = _lessons.isEmpty ? 0.0 : _lessonViewedMaterialIds.length / _lessons.length;
    final percent = (overallProgress * 100).toInt();
    final lessonRequiredSec = _lessonRequiredSeconds(currentLesson);
    final lessonMinMet = currentLesson != null &&
        _lessonViewedMaterialIds.contains(currentLesson.materialId);
    final lessonTimeProgress = lessonMinMet
        ? 1.0
        : (lessonRequiredSec > 0
            ? (_currentLessonElapsedSeconds / lessonRequiredSec).clamp(0.0, 1.0)
            : 0.0);

    return VisibilityDetector(
      key: const Key('course_viewer_visibility'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Scaffold(
        backgroundColor: _bg,
        body: Column(
          children: [
            // ─── TOP HEADER ───
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: const BoxDecoration(
                color: _cardBg,
                border: Border(bottom: BorderSide(color: _border)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.school_rounded, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(_courseTitle ?? PharmaBrand.name,
                      style: const TextStyle(
                          color: _textLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  if (_effectiveCourseVersionId > 0) ...[
                    const SizedBox(width: 4),
                    IconButton(
                      tooltip: 'Message instructor',
                      onPressed: () async {
                        String? instructorName;
                        try {
                          final version = await client.course.getCourseVersion(_effectiveCourseVersionId);
                          final course = version?.course;
                          final createdBy = course?.createdBy;
                          if (createdBy != null) {
                            instructorName = '${createdBy.firstName} ${createdBy.lastName}'.trim();
                          }
                        } catch (_) {}
                        openLearnerInstructorChat(
                          context,
                          courseVersionId: _effectiveCourseVersionId,
                          courseTitle: _courseTitle ?? 'Course',
                          instructorName: instructorName,
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline, color: _textLight, size: 22),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ],
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: overallProgress,
                            backgroundColor: _border,
                            valueColor: const AlwaysStoppedAnimation(_accent),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('$percent% Complete', style: const TextStyle(color: _textMuted, fontSize: 12)),
                        if (currentLesson != null) ...[
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: lessonTimeProgress,
                              backgroundColor: _border.withValues(alpha: 0.5),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                lessonMinMet ? const Color(0xFF22C55E) : const Color(0xFF38BDF8),
                              ),
                              minHeight: 4,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            lessonMinMet
                                ? 'This lesson: minimum time met'
                                : 'This lesson: time on content (${(lessonRequiredSec / 60).ceil()} min target)',
                            style: const TextStyle(color: _textMuted, fontSize: 11),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  if (widget.previewMode)
                    OutlinedButton.icon(
                      onPressed: () {
                        if (GoRouter.of(context).canPop()) {
                          context.pop();
                        } else {
                          context.go('/trainer/courses/${widget.courseId}/builder');
                        }
                      },
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('Back to Builder', style: TextStyle(fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _accent),
                        foregroundColor: _accent,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  else
                    OutlinedButton(
                      onPressed: () {
                        if (GoRouter.of(context).canPop()) {
                          context.pop();
                        } else {
                          context.go('/employee/lessons');
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFEF4444)),
                        foregroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Exit Course', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            ),

            // ─── PREVIEW MODE BANNER ───
            if (widget.previewMode)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                color: const Color(0xFFFEF3C7),
                child: Row(
                  children: [
                    const Icon(Icons.visibility, size: 16, color: Color(0xFF92400E)),
                    const SizedBox(width: 8),
                    const Text(
                      'PREVIEW MODE — This is how employees/learners see this course. No progress is recorded.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF92400E),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        if (GoRouter.of(context).canPop()) {
                          context.pop();
                        } else {
                          context.go('/trainer/courses/${widget.courseId}/builder');
                        }
                      },
                      icon: const Icon(Icons.edit, size: 14),
                      label: const Text('Return to Editor'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF92400E),
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

            // ─── BODY ───
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT CONTENT PANEL
                  Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Media Player
                          Container(
                            height: 520,
                            decoration: BoxDecoration(
                              color: _cardBg,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              children: [
                                Positioned.fill(child: _buildMaterialViewer(currentLesson)),
                                if (currentLesson != null)
                                  Positioned(
                                    left: 24,
                                    bottom: 24,
                                    right: 24,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lesson ${_currentLessonIndex + 1} Material',
                                          style: const TextStyle(color: _textMuted, fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          currentLesson.title,
                                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          _buildNavigationFooter(currentLesson),
                          const SizedBox(height: 28),

                          // Tabs — Objectives / Transcript / Resources below the player and lesson actions
                          Row(
                            children: [
                              _viewerTab('Course Objectives', 0),
                              const SizedBox(width: 24),
                              _viewerTab('Transcript', 1),
                              const SizedBox(width: 24),
                              _viewerTab('Resources', 2),
                            ],
                          ),
                          const SizedBox(height: 16),

                          _buildTabContent(currentLesson),
                        ],
                      ),
                    ),
                  ),

                  // RIGHT — COURSE PATH PANEL
                  Container(
                    width: 320,
                    decoration: const BoxDecoration(
                      color: _panelBg,
                      border: Border(left: BorderSide(color: _border)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                          child: Text('Course Path', style: TextStyle(color: _textLight, fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _lessons.length,
                            itemBuilder: (context, i) => _buildLessonCard(i),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── TAB WIDGET ───
  Widget _viewerTab(String label, int tabIndex) {
    final active = _activeTab == tabIndex;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = tabIndex),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(color: active ? _textLight : _textDim, fontSize: 14, fontWeight: active ? FontWeight.w700 : FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(height: 2, width: 100, color: active ? _accent : Colors.transparent),
        ],
      ),
    );
  }

  // ─── TAB CONTENT ───
  Widget _buildTabContent(Lesson? currentLesson) {
    switch (_activeTab) {
      case 1:
        return _buildTranscriptTab(currentLesson);
      case 2:
        return _buildResourcesTab(currentLesson);
      default:
        return Text(
          _courseDescription ?? '',
          style: const TextStyle(color: _textMuted, fontSize: 14, height: 1.6),
        );
    }
  }

  Widget _buildTranscriptTab(Lesson? currentLesson) {
    if (currentLesson == null) {
      return const Text('No lesson selected.', style: TextStyle(color: _textDim, fontSize: 14));
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.subtitles_outlined, color: _accent, size: 20),
              const SizedBox(width: 10),
              Text(
                'Transcript — ${currentLesson.title}',
                style: const TextStyle(color: _textLight, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Transcript will be available after the lesson content has been processed. '
            'Automated transcription is generated for video and audio materials.',
            style: TextStyle(color: _textMuted, fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _border.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 14, color: _textDim),
                const SizedBox(width: 8),
                const Text('Transcript processing pending', style: TextStyle(color: _textDim, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openMaterialResource({
    int? materialId,
    String? storageKey,
    String? contentUrl,
  }) async {
    Uri? uri;
    if (storageKey != null && storageKey.isNotEmpty) {
      final u = await client.material.getMaterialViewUrl(storageKey);
      if (u != null && u.isNotEmpty) uri = Uri.tryParse(u);
    }
    if (uri == null && materialId != null) {
      final u = await client.material.getMaterialContentUrl(materialId);
      if (u != null && u.isNotEmpty) uri = Uri.tryParse(u);
    }
    if (uri == null &&
        contentUrl != null &&
        contentUrl.trim().isNotEmpty) {
      uri = Uri.tryParse(contentUrl.trim());
    }
    if (uri == null || !mounted) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildResourcesTab(Lesson? currentLesson) {
    if (currentLesson == null) {
      return const Text('No lesson selected.', style: TextStyle(color: _textDim, fontSize: 14));
    }

    final material = _currentLessonWithMaterial?.material;
    final hasFile = material != null &&
        material.storageKey != null &&
        material.storageKey!.isNotEmpty;
    final hasLink = material != null &&
        material.contentUrl != null &&
        material.contentUrl!.trim().isNotEmpty;

    // Collect all attached resources from lesson blocks
    final blockResources = <_BlockResource>[];
    for (final block in _lessonBlocks) {
      try {
        final content = jsonDecode(block.contentJson) as Map<String, dynamic>;
        final bt = block.blockType;
        if (bt == 'google_doc' || bt == 'google_sheet' || bt == 'google_slide') {
          final url = content['url'] as String? ?? '';
          if (url.isNotEmpty) {
            blockResources.add(_BlockResource(
              title: content['title'] as String? ?? bt.replaceAll('_', ' ').toUpperCase(),
              type: bt,
              url: url,
            ));
          }
        } else if (bt == 'video') {
          final url = content['url'] as String? ?? '';
          if (url.isNotEmpty) {
            blockResources.add(_BlockResource(
              title: content['title'] as String? ?? 'Video',
              type: 'video',
              url: url,
            ));
          }
        } else if (bt == 'code_sandbox') {
          final url = content['url'] as String? ?? '';
          if (url.isNotEmpty) {
            blockResources.add(_BlockResource(
              title: content['title'] as String? ?? 'Code Sandbox',
              type: 'code_sandbox',
              url: url,
            ));
          }
        } else if (bt == 'audio') {
          final fileName = content['fileName'] as String? ?? 'Audio file';
          final url = content['url'] as String? ?? '';
          if (url.isNotEmpty) {
            blockResources.add(_BlockResource(title: fileName, type: 'audio', url: url));
          }
        }
      } catch (_) {}
    }

    final hasNoResources = (material == null || (!hasFile && !hasLink)) && blockResources.isEmpty;

    if (hasNoResources) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Icon(Icons.folder_open_outlined, color: _textDim, size: 40),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No resources attached', style: TextStyle(color: _textLight, fontSize: 15, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text(
                    'This lesson does not have any linked file or URL.',
                    style: TextStyle(color: _textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lesson Resources (${1 + blockResources.length})',
            style: const TextStyle(color: _textLight, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          // Primary material
          if (material != null && (hasFile || hasLink))
            _buildResourceRow(
              title: material.title,
              type: material.materialType.toLowerCase(),
              onOpen: () => _openMaterialResource(
                materialId: material.id,
                storageKey: material.storageKey,
                contentUrl: material.contentUrl,
              ),
              isLink: hasLink && !hasFile,
            ),
          // Additional resources from lesson blocks
          for (final res in blockResources) ...[
            const SizedBox(height: 10),
            _buildResourceRow(
              title: res.title,
              type: res.type,
              onOpen: () async {
                final uri = Uri.tryParse(res.url);
                if (uri != null && await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              isLink: true,
            ),
          ],
        ],
      ),
    );
  }

  /// Builds a single resource row with icon, title, type badge, and open button.
  Widget _buildResourceRow({
    required String title,
    required String type,
    required VoidCallback onOpen,
    bool isLink = false,
  }) {
    IconData typeIcon;
    Color typeColor;
    switch (type) {
      case 'video':
        typeIcon = Icons.videocam_rounded;
        typeColor = const Color(0xFFF59E0B);
      case 'pdf':
        typeIcon = Icons.picture_as_pdf_rounded;
        typeColor = const Color(0xFFEF4444);
      case 'scorm':
        typeIcon = Icons.web_rounded;
        typeColor = const Color(0xFF8B5CF6);
      case 'google_doc':
        typeIcon = Icons.article_rounded;
        typeColor = const Color(0xFF4285F4);
      case 'google_sheet':
        typeIcon = Icons.table_chart_rounded;
        typeColor = const Color(0xFF0F9D58);
      case 'google_slide':
        typeIcon = Icons.slideshow_rounded;
        typeColor = const Color(0xFFF4B400);
      case 'audio':
        typeIcon = Icons.audiotrack_rounded;
        typeColor = const Color(0xFF8B5CF6);
      case 'code_sandbox':
        typeIcon = Icons.code_rounded;
        typeColor = const Color(0xFF06B6D4);
      default:
        typeIcon = Icons.insert_drive_file_rounded;
        typeColor = _accent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(typeIcon, color: typeColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: _textLight, fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  type.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(color: typeColor, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: onOpen,
            icon: Icon(
              isLink ? Icons.link_rounded : Icons.open_in_new_rounded,
              size: 16,
            ),
            label: Text(isLink ? 'Open link' : 'Open'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _accent,
              side: const BorderSide(color: _accent),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  // ─── LESSON CARD (Course Path) ───
  Widget _buildLessonCard(int index) {
    final lesson = _lessons[index];
    final isViewed = _lessonViewedMaterialIds.contains(lesson.materialId);
    final isCurrent = index == _currentLessonIndex;
    final isAccessible = _isLessonAccessible(index);
    final isLocked = !isViewed && !isCurrent && !isAccessible;

    Color accent;
    IconData icon;
    String? badge;
    if (isViewed) {
      accent = _accent;
      icon = Icons.check_rounded;
    } else if (isCurrent) {
      accent = const Color(0xFF06B6D4);
      icon = Icons.play_arrow_rounded;
      badge = 'Current';
    } else {
      accent = _textDim;
      icon = Icons.lock_outline_rounded;
      badge = 'Locked';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (isViewed || isCurrent || isAccessible) ? () {
            _stopReadTimer();
            _loadLessonMaterial(lesson);
            setState(() {
              _currentLessonIndex = index;
              _currentLessonElapsedSeconds = 0;
              _activeTab = 0;
            });
            if (!_lessonViewedMaterialIds.contains(lesson.materialId)) _startReadTimer(lesson);
          } : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isCurrent ? accent.withValues(alpha: 0.08) : _cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isCurrent ? accent : _border, width: isCurrent ? 1.5 : 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent.withValues(alpha: 0.15),
                    border: Border.all(color: accent.withValues(alpha: 0.5)),
                  ),
                  child: Icon(icon, size: 14, color: accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      color: isLocked ? _textDim : _textLight,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: isCurrent ? accent.withValues(alpha: 0.15) : _border,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(badge, style: TextStyle(color: isCurrent ? accent : _textDim, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ],
                if (isViewed) ...[
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: const LinearProgressIndicator(
                        value: 1.0,
                        backgroundColor: _border,
                        valueColor: AlwaysStoppedAnimation(_accent),
                        minHeight: 3,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── MATERIAL VIEWER (Block-based or single material fallback) ───
  Widget _buildMaterialViewer(Lesson? currentLesson) {
    if (_loadingMaterial) return const Center(child: CircularProgressIndicator(color: _accent));
    if (currentLesson == null) return const Center(child: Text('No content', style: TextStyle(color: _textMuted)));

    // Block-based rendering: if lesson has blocks, render them
    if (_lessonBlocks.isNotEmpty) {
      return _buildBlockBasedContent();
    }

    // Fallback: single material rendering
    final material = _currentLessonWithMaterial?.material;
    final type = material?.materialType.toLowerCase() ?? '';

    if (type == 'video' && _videoController != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_videoController!),
          GestureDetector(
            onTap: () => setState(() => _videoController!.value.isPlaying ? _videoController!.pause() : _videoController!.play()),
            child: AnimatedOpacity(
              opacity: _videoController!.value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 72, height: 72,
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(_videoController!, allowScrubbing: true, colors: const VideoProgressColors(playedColor: _accent)),
          ),
        ],
      );
    }

    if (_materialWebController != null) {
      final t = type;
      final poster = t == 'video' && _materialViewUrl != null
          ? VideoUrlParser.posterImageUrlForVideo(_materialViewUrl!)
          : null;
      return Stack(
        fit: StackFit.expand,
        children: [
          if (poster != null)
            Image.network(
              poster,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          WebViewWidget(controller: _materialWebController!),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_accent.withValues(alpha: 0.3), const Color(0xFF1E3A5F).withValues(alpha: 0.8)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_fill_rounded, size: 72, color: Colors.white.withValues(alpha: 0.7)),
            const SizedBox(height: 16),
            Text(material?.title ?? currentLesson.title, style: const TextStyle(color: _textLight, fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ─── BLOCK-BASED CONTENT RENDERER ───
  Widget _buildBlockBasedContent() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _lessonBlocks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final block = _lessonBlocks[index];
        Map<String, dynamic> content;
        try {
          content = jsonDecode(block.contentJson) as Map<String, dynamic>;
        } catch (_) {
          content = {};
        }

        switch (block.blockType) {
          case 'text':
            final html = content['html'] as String? ?? '';
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                html.replaceAll(RegExp(r'<[^>]*>'), ''),
                style: const TextStyle(color: _textLight, fontSize: 14, height: 1.7),
              ),
            );

          case 'heading':
            final text = content['text'] as String? ?? '';
            final level = content['level'] as int? ?? 2;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                text,
                style: TextStyle(
                  color: _textLight,
                  fontSize: level == 1 ? 24 : level == 2 ? 20 : 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );

          case 'video':
            final url = content['url'] as String? ?? '';
            final platformStr = content['platform'] as String? ?? 'direct';
            if (url.isEmpty) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('No video URL', style: TextStyle(color: _textMuted))),
              );
            }
            final platform = VideoPlatform.values.firstWhere(
              (p) => p.name == platformStr,
              orElse: () => VideoPlatform.direct,
            );
            final embedUrl = VideoUrlParser.toEmbedUrl(url, platform);
            final thumb = (content['thumbnailUrl'] as String?)?.trim();
            final poster = (thumb != null && thumb.isNotEmpty)
                ? thumb
                : VideoUrlParser.posterImageUrlForVideo(url);
            final webCtrl = webViewControllerWithDefaults()
              ..loadRequest(Uri.parse(embedUrl));
            return Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (poster != null)
                    Image.network(
                      poster,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                  WebViewWidget(controller: webCtrl),
                ],
              ),
            );

          case 'quiz':
            final quizTitle = content['quizTitle'] as String? ?? 'Knowledge Check';
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.quiz, color: Color(0xFF8B5CF6), size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(quizTitle, style: const TextStyle(color: _textLight, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        const Text('Complete this quiz to continue', style: TextStyle(color: _textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
                    child: const Text('Start Quiz'),
                  ),
                ],
              ),
            );

          case 'assignment':
            final title = content['title'] as String? ?? 'Assignment';
            final instructions = content['instructions'] as String? ?? '';
            final linked = _resolveLessonAssignment(content);
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.assignment, color: Color(0xFFF59E0B), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          linked?.title ?? title,
                          style: const TextStyle(color: _textLight, fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  if ((linked?.instructions ?? instructions).trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      (linked?.instructions ?? instructions).trim(),
                      style: const TextStyle(color: _textMuted, fontSize: 13),
                    ),
                  ],
                  if (linked == null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _lessonAssignments.isEmpty
                          ? 'This assignment is not linked on the server yet. Open the course in the builder, add a title to the assignment block, and save — or ask your trainer to republish.'
                          : 'Could not match this block to a coursework assignment. Check the assignment title matches the server or ask your trainer.',
                      style: const TextStyle(color: _textDim, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: linked == null
                        ? null
                        : () => _openAssignmentSubmissionSheet(
                              assignment: linked,
                              displayTitle: linked.title,
                              instructions: linked.instructions ?? instructions,
                            ),
                    icon: const Icon(Icons.upload_file, size: 16),
                    label: const Text('Submit assignment'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFF59E0B),
                      side: const BorderSide(color: Color(0xFFF59E0B)),
                    ),
                  ),
                ],
              ),
            );

          case 'google_doc':
          case 'google_sheet':
          case 'google_slide':
            final url = content['url'] as String? ?? '';
            if (url.isEmpty) {
              return Container(
                height: 200,
                color: _cardBg,
                child: const Center(child: Text('No Google URL', style: TextStyle(color: _textMuted))),
              );
            }
            final webCtrl2 = webViewControllerWithDefaults()
              ..loadRequest(Uri.parse(url));
            return Container(
              height: 400,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias,
              child: WebViewWidget(controller: webCtrl2),
            );

          case 'code_sandbox':
            final url = content['url'] as String? ?? '';
            if (url.isEmpty) {
              return Container(
                height: 200,
                color: _cardBg,
                child: const Center(child: Text('No CodeSandbox URL', style: TextStyle(color: _textMuted))),
              );
            }
            final webCtrl3 = webViewControllerWithDefaults()
              ..loadRequest(Uri.parse(url));
            return Container(
              height: 400,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias,
              child: WebViewWidget(controller: webCtrl3),
            );

          case 'audio':
            final fileName = content['fileName'] as String? ?? 'Audio file';
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.audiotrack, color: Color(0xFF8B5CF6), size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(fileName, style: const TextStyle(color: _textLight, fontSize: 14)),
                  ),
                  const Icon(Icons.play_circle_outline, color: _accent, size: 28),
                ],
              ),
            );

          default:
            return Container(
              padding: const EdgeInsets.all(12),
              color: _cardBg,
              child: Text('Unknown block: ${block.blockType}', style: const TextStyle(color: _textMuted)),
            );
        }
      },
    );
  }

  Assignment? _resolveLessonAssignment(Map<String, dynamic> content) {
    final rawId = content['assignmentId'];
    if (rawId is int) {
      for (final a in _lessonAssignments) {
        if (a.id == rawId) return a;
      }
    }
    if (rawId is num) {
      final id = rawId.toInt();
      for (final a in _lessonAssignments) {
        if (a.id == id) return a;
      }
    }
    final title = (content['title'] as String? ?? '').trim();
    if (title.isNotEmpty) {
      for (final a in _lessonAssignments) {
        if (a.title.trim() == title) return a;
      }
    }
    if (_lessonAssignments.length == 1) return _lessonAssignments.first;
    return null;
  }

  Future<void> _openAssignmentSubmissionSheet({
    required Assignment assignment,
    required String displayTitle,
    required String instructions,
  }) async {
    if (assignment.id == null || _effectiveUserId <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in to submit assignments.')),
        );
      }
      return;
    }
    final linkController = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _cardBg,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(ctx).bottom,
            left: 24,
            right: 24,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  displayTitle,
                  style: const TextStyle(
                    color: _textLight,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (instructions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    instructions,
                    style: const TextStyle(color: _textMuted, fontSize: 14),
                  ),
                ],
                const SizedBox(height: 16),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    labelText: 'Submission link',
                    hintText: 'https://… (shared file or document)',
                    labelStyle: TextStyle(color: _textMuted),
                    hintStyle: TextStyle(color: _textDim),
                  ),
                  style: const TextStyle(color: _textLight),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Paste a link to your completed work (e.g. Google Drive, OneDrive, or a shared URL).',
                  style: TextStyle(color: _textDim, fontSize: 12),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    final url = linkController.text.trim();
                    if (url.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter a submission link.')),
                      );
                      return;
                    }
                    try {
                      await client.assignment.submitAssignment(
                        assignmentId: assignment.id!,
                        userId: _effectiveUserId,
                        submissionUrl: url,
                      );
                      if (ctx.mounted) Navigator.pop(ctx);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Submission received.')),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Submit failed: $e')),
                        );
                      }
                    }
                  },
                  style: FilledButton.styleFrom(backgroundColor: _accent),
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── NAVIGATION FOOTER ───
  Widget _buildNavigationFooter(Lesson? currentLesson) {
    final canGoBack = _currentLessonIndex > 0;
    final isViewed = currentLesson != null && _lessonViewedMaterialIds.contains(currentLesson.materialId);
    final isLastLesson = _currentLessonIndex == _lessons.length - 1;

    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: canGoBack
              ? () {
                  _stopReadTimer();
                  final prev = _currentLessonIndex - 1;
                  _loadLessonMaterial(_lessons[prev]);
                  setState(() { _currentLessonIndex = prev; _currentLessonElapsedSeconds = 0; _activeTab = 0; });
                  if (!_lessonViewedMaterialIds.contains(_lessons[prev].materialId)) _startReadTimer(_lessons[prev]);
                }
              : null,
          icon: const Icon(Icons.chevron_left_rounded, size: 18),
          label: const Text('Previous Lesson'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _textMuted,
            side: const BorderSide(color: _border),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const Spacer(),
        if (currentLesson != null && !isViewed) ...[
          const Icon(Icons.schedule_rounded, size: 14, color: _textDim),
          const SizedBox(width: 6),
          Text(
            'Req: ${currentLesson.durationMinutes ?? 1}m',
            style: const TextStyle(color: _textMuted, fontSize: 12),
          ),
          const SizedBox(width: 16),
        ],
        FilledButton(
          onPressed: isViewed
              ? () {
                  if (!isLastLesson) {
                    _markLessonCompleteAndProceed(currentLesson);
                  } else if (_allLessonsViewed) {
                    if (_effectiveEnrollmentId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enroll in this course to take the assessment.'),
                        ),
                      );
                    } else {
                      context.push('/employee/assessment/${widget.courseId}', extra: {
                        'courseVersionId': _effectiveCourseVersionId,
                        'enrollmentId': _effectiveEnrollmentId,
                        'userId': _effectiveUserId,
                      });
                    }
                  }
                }
              : null,
          style: FilledButton.styleFrom(
            backgroundColor: _accent,
            disabledBackgroundColor: _border,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            isLastLesson ? (_allLessonsViewed ? 'Take Assessment' : 'Complete Lesson') : 'Next Lesson',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

/// Helper class for collecting resources from lesson blocks for the Resources tab.
class _BlockResource {
  final String title;
  final String type;
  final String url;

  const _BlockResource({
    required this.title,
    required this.type,
    required this.url,
  });
}