import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as protocol;
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import 'scorm_api.dart';

/// Course viewer with modules, lessons, minimum read time, and assessment.
/// Tab-focus pause: timer pauses when tab loses focus (server-enforced min read time).
class CourseViewerScreen extends StatefulWidget {
  const CourseViewerScreen({
    super.key,
    required this.courseId,
    this.courseTitle,
    this.courseVersionId,
    this.enrollmentId,
    this.userId,
  });

  final String courseId;
  final String? courseTitle;
  final int? courseVersionId;
  final int? enrollmentId;
  final int? userId;

  @override
  State<CourseViewerScreen> createState() => _CourseViewerScreenState();
}

class _CourseViewerScreenState extends State<CourseViewerScreen>
    with WidgetsBindingObserver {
  List<Module> _modules = [];
  List<Lesson> _lessons = [];
  String? _courseTitle;
  bool _loading = true;
  String? _error;
  int _currentLessonIndex = 0;
  int _currentLessonElapsedSeconds = 0;
  Timer? _readTimer;
  Timer? _heartbeatTimer;
  bool _timerPaused = false;
  bool _tabVisible = true;
  final Set<int> _lessonViewedMaterialIds = {};
  Lesson? _currentLessonWithMaterial;
  String? _materialViewUrl;
  bool _loadingMaterial = false;
  WebViewController? _materialWebController;
  VideoPlayerController? _videoController;

  Enrollment? _enrollment;
  bool _acknowledgementChecked = false;
  bool _acknowledging = false;
  String? _acknowledgementError;
  List<SignatureMeaning> _signatureMeanings = [];
  String? _selectedSignatureMeaning;
  final _passwordController = TextEditingController();

  int get _effectiveUserId => widget.userId ?? 0;
  int get _effectiveCourseVersionId => widget.courseVersionId ?? 0;
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
    _readTimer?.cancel();
    _heartbeatTimer?.cancel();
    _videoController?.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
    if (_tabVisible != visible) {
      if (mounted) setState(() => _tabVisible = visible);
    }
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final courseVersionId = _effectiveCourseVersionId;
      if (courseVersionId == 0) {
        setState(() {
          _error = 'Missing course version. Go back and open from dashboard.';
          _loading = false;
        });
        return;
      }

      Enrollment? enrollment;
      if (widget.enrollmentId != null) {
        enrollment = await client.training.getEnrollmentById(widget.enrollmentId!);
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

      final version = await client.course.getCourseVersion(courseVersionId);
      _courseTitle = version?.course?.title ?? widget.courseTitle ?? 'Course';

      final modules = await client.course.getModulesForCourseVersion(courseVersionId);
      final allLessons = <Lesson>[];
      for (final m in modules) {
        if (m.id != null) {
          final lessons = await client.course.getLessonsForModule(m.id!);
          allLessons.addAll(lessons);
        }
      }
      allLessons.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      int startLessonIndex = 0;
      int? resumeElapsedSeconds;
      if (_effectiveUserId > 0) {
        for (final l in allLessons) {
          final p = await client.material.getProgress(
            userId: _effectiveUserId,
            materialId: l.materialId,
            enrollmentId: widget.enrollmentId,
          );
          if (p != null &&
              (p.progressPct >= 100 ||
                  p.completedAt != null ||
                  p.readTimeMet == true)) {
            _lessonViewedMaterialIds.add(l.materialId);
          }
        }
        for (var i = 0; i < allLessons.length; i++) {
          if (!_lessonViewedMaterialIds.contains(allLessons[i].materialId)) {
            startLessonIndex = i;
            final p = await client.material.getProgress(
              userId: _effectiveUserId,
              materialId: allLessons[i].materialId,
              enrollmentId: widget.enrollmentId,
            );
            if (p?.timeSpentSeconds != null && p!.timeSpentSeconds! > 0) {
              resumeElapsedSeconds = p.timeSpentSeconds;
            }
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
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _startReadTimer(Lesson lesson) {
    _readTimer?.cancel();
    _heartbeatTimer?.cancel();
    if (_lessonViewedMaterialIds.contains(lesson.materialId)) return;
    if (lesson.id == null || _effectiveUserId <= 0) return;

    _readTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timerPaused || !_tabVisible) return;
      _currentLessonElapsedSeconds++;
      if (mounted) setState(() {});
    });

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
          userId: _effectiveUserId,
          materialId: lesson.materialId,
          lessonId: lesson.id!,
          enrollmentId: widget.enrollmentId,
          tabFocused: tabFocused,
          scrollDepthPct: scrollDepthPct,
          videoWatchedPct: videoWatchedPct,
          videoPositionSeconds: videoPositionSeconds,
          deltaSeconds: 10,
        );
        if (progress.readTimeMet == true && mounted) {
          _lessonViewedMaterialIds.add(lesson.materialId);
          _readTimer?.cancel();
          _heartbeatTimer?.cancel();
          try {
            final interactionJson = material != null
                ? _buildInteractionJson(material)
                : null;
            await client.material.updateProgress(
              userId: _effectiveUserId,
              materialId: lesson.materialId,
              progressPct: 100,
              completedAt: DateTime.now(),
              timeSpentSeconds: progress.timeSpentSeconds ?? _currentLessonElapsedSeconds,
              readTimeMet: true,
              lessonId: lesson.id,
              enrollmentId: widget.enrollmentId,
              interactionJson: interactionJson,
            );
          } catch (_) {}
          if (mounted) setState(() {});
        }
      } catch (_) {}
    });
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
    } catch (_) {
      return null;
    }
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
    } catch (_) {
      return null;
    }
  }

  Future<int?> _getVideoPositionSeconds() async {
    final vc = _videoController;
    if (vc != null) return vc.value.position.inSeconds;
    try {
      final controller = _materialWebController;
      if (controller == null) return null;
      final result = await controller.runJavaScriptReturningResult('''
        (function() {
          var v = document.querySelector('video');
          if (!v) return 0;
          return Math.round(v.currentTime || 0);
        })();
      ''');
      if (result is int) return result;
      if (result is double) return result.round();
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Handles SCORM LMSCommit/LMSFinish from injected API (plan 2C).
  Future<void> _onScormCommit(
    String message, {
    required Lesson lesson,
    required int materialId,
  }) async {
    if (_effectiveUserId <= 0 || lesson.id == null) return;
    try {
      final decoded = jsonDecode(message) as Map<String, dynamic>?;
      if (decoded == null || decoded['type'] != 'commit') return;
      final data = decoded['data'] as Map<String, dynamic>?;
      if (data == null) return;

      // SCORM 1.2: cmi.core.lesson_status, cmi.core.score.raw
      // SCORM 2004: cmi.completion_status, cmi.score.raw, cmi.progress_measure
      final status12 = data['cmi.core.lesson_status'] as String?;
      final status04 = data['cmi.completion_status'] as String?;
      final status = status12 ?? status04 ?? '';
      final completed = status.toLowerCase() == 'completed' ||
          status.toLowerCase() == 'passed' ||
          status.toLowerCase() == 'complete';
      final rawScore = data['cmi.core.score.raw'] ?? data['cmi.score.raw'];
      final progressMeasure = data['cmi.progress_measure'];
      var progressPct = 0;
      if (completed) {
        progressPct = 100;
      } else if (progressMeasure is num) {
        progressPct = (progressMeasure.clamp(0.0, 1.0) * 100).round();
      }

      final durationMinutes = lesson.durationMinutes ?? 1;
      final requiredSeconds = durationMinutes * 60;
      final timeSpent = _currentLessonElapsedSeconds >= requiredSeconds
          ? _currentLessonElapsedSeconds
          : requiredSeconds;

      await client.material.updateProgress(
        userId: _effectiveUserId,
        materialId: materialId,
        progressPct: progressPct,
        readTimeMet: completed ? true : null,
        timeSpentSeconds: timeSpent,
        lessonId: lesson.id,
        enrollmentId: widget.enrollmentId,
        interactionJson: jsonEncode({
          ...data,
          'scorm_completion_status': status,
          if (rawScore != null) 'scorm_score_raw': rawScore,
        }),
        completedAt: completed ? DateTime.now() : null,
      );
      if (mounted && completed) {
        _lessonViewedMaterialIds.add(materialId);
        setState(() {});
      }
    } catch (_) {}
  }

  String? _buildInteractionJson(protocol.Material material) {
    final type = material.materialType.toLowerCase();
    if (type == 'video') {
      return '{"videoWatchedPct": 100}';
    }
    if (type == 'pdf') {
      return '{"pdfScrollPct": 100}';
    }
    if (type == 'scorm') {
      return '{"scormComplete": true}';
    }
    return null;
  }

  void _stopReadTimer() {
    _readTimer?.cancel();
    _heartbeatTimer?.cancel();
    _currentLessonElapsedSeconds = 0;
  }

  Future<void> _markLessonCompleteAndProceed(Lesson lesson) async {
    if (lesson.id == null || _effectiveUserId <= 0) return;
    _lessonViewedMaterialIds.add(lesson.materialId);
    _readTimer?.cancel();
    _heartbeatTimer?.cancel();
    final material = _currentLessonWithMaterial?.material;
    try {
      final interactionJson = material != null ? _buildInteractionJson(material) : null;
      await client.material.updateProgress(
        userId: _effectiveUserId,
        materialId: lesson.materialId,
        progressPct: 100,
        completedAt: DateTime.now(),
        timeSpentSeconds: _currentLessonElapsedSeconds,
        readTimeMet: true,
        lessonId: lesson.id,
        enrollmentId: widget.enrollmentId,
        interactionJson: interactionJson,
      );
    } catch (_) {}
    if (!mounted) return;
    if (_currentLessonIndex < _lessons.length - 1) {
      _stopReadTimer();
      final nextIndex = _currentLessonIndex + 1;
      _loadLessonMaterial(_lessons[nextIndex]);
      setState(() => _currentLessonIndex = nextIndex);
      if (!_lessonViewedMaterialIds.contains(_lessons[nextIndex].materialId)) {
        _startReadTimer(_lessons[nextIndex]);
      }
    } else {
      setState(() {});
    }
  }

  Widget _buildMaterialViewer() {
    final type = _currentLessonWithMaterial?.material?.materialType.toLowerCase() ?? '';
    if (type == 'video' && _videoController != null) {
      final ar = _videoController!.value.aspectRatio;
      return SizedBox(
        height: 400,
        child: AspectRatio(
          aspectRatio: ar > 0 ? ar : 16 / 9,
          child: VideoPlayer(_videoController!),
        ),
      );
    }
    // PDF, SCORM: WebView (SCORM completion tracked via read-time for zip packages)
    if (_materialWebController != null) {
      return SizedBox(
        height: 400,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.slate200),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: WebViewWidget(controller: _materialWebController!),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  bool get _allLessonsViewed {
    if (_lessons.isEmpty) return false;
    for (final l in _lessons) {
      if (!_lessonViewedMaterialIds.contains(l.materialId)) return false;
    }
    return true;
  }

  int _remainingSeconds(Lesson lesson) {
    final durationMinutes = lesson.durationMinutes ?? 1;
    final required = durationMinutes * 60;
    if (_lessonViewedMaterialIds.contains(lesson.materialId)) return 0;
    final remaining = required - _currentLessonElapsedSeconds;
    return remaining > 0 ? remaining : 0;
  }

  bool _canProceed(Lesson lesson) =>
      _lessonViewedMaterialIds.contains(lesson.materialId);

  Future<void> _performAcknowledgement() async {
    final enrollmentId = widget.enrollmentId;
    final userId = _effectiveUserId;
    if (enrollmentId == null || userId == 0) return;

    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _acknowledgementError = 'Password is required for re-authentication.');
      return;
    }

    setState(() {
      _acknowledging = true;
      _acknowledgementError = null;
    });

    try {
      final updated = await client.training.acknowledgeRetraining(
        enrollmentId: enrollmentId,
        userId: userId,
        signatureMeaning: _selectedSignatureMeaning ?? 'I have read and understood',
        passwordReauth: password,
      );
      if (mounted) {
        setState(() {
          _enrollment = updated;
          _acknowledging = false;
          _acknowledgementError = null;
          _passwordController.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _acknowledging = false;
          _acknowledgementError = e.toString();
        });
      }
    }
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
    });
    try {
      final lessonWithMaterial =
          await client.course.getLessonWithMaterial(lesson.id!);
      String? viewUrl;
      final material = lessonWithMaterial?.material;
      if (material?.storageKey != null) {
        viewUrl = await client.material.getMaterialViewUrl(material!.storageKey!);
      }
      if (!mounted) return;
      final type = material?.materialType.toLowerCase() ?? '';
      WebViewController? webController;
      VideoPlayerController? videoController;

      if (viewUrl != null) {
        if (type == 'video') {
          videoController = VideoPlayerController.networkUrl(Uri.parse(viewUrl));
          await videoController.initialize();
        } else if (type == 'scorm') {
          // Plan 2C: inject SCORM API (1.2 + 2004) via wrapper HTML; bridge commits to Flutter
          final wrapperHtml = buildScormWrapperHtml(viewUrl);
          final dataUri = Uri.dataFromString(
            wrapperHtml,
            mimeType: 'text/html',
            encoding: utf8,
          );
          webController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..addJavaScriptChannel(
              'ScormBridge',
              onMessageReceived: (JavaScriptMessage msg) {
                _onScormCommit(
                  msg.message,
                  lesson: lesson,
                  materialId: lesson.materialId,
                );
              },
            )
            ..loadRequest(dataUri);
        } else {
          // PDF, etc.: use WebView
          webController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(viewUrl));
        }
      }

      if (mounted) {
        int elapsed = 0;
        if (_effectiveUserId > 0 &&
            !_lessonViewedMaterialIds.contains(lesson.materialId)) {
          try {
            final p = await client.material.getProgress(
              userId: _effectiveUserId,
              materialId: lesson.materialId,
              enrollmentId: widget.enrollmentId,
            );
            if (p?.timeSpentSeconds != null) elapsed = p!.timeSpentSeconds!;
          } catch (_) {}
        }
        setState(() {
          _currentLessonWithMaterial = lessonWithMaterial;
          _materialViewUrl = viewUrl;
          _materialWebController = webController;
          _videoController = videoController;
          _loadingMaterial = false;
          _currentLessonElapsedSeconds = elapsed;
        });
        if (webController != null &&
            _effectiveUserId > 0 &&
            material != null) {
          _scheduleResumePosition(webController, material, lesson.materialId);
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loadingMaterial = false);
      }
    }
  }

  void _scheduleResumePosition(
    WebViewController controller,
    protocol.Material material,
    int materialId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    try {
      final progress = await client.material.getProgress(
        userId: _effectiveUserId,
        materialId: materialId,
        enrollmentId: widget.enrollmentId,
      );
      if (progress?.interactionJson == null) return;
      final decoded = jsonDecode(progress!.interactionJson!) as Map<String, dynamic>?;
      if (decoded == null) return;
      final type = material.materialType.toLowerCase();
      if (type == 'video') {
        final pos = decoded['videoPositionSeconds'] as num?;
        if (pos != null && pos > 0) {
          final vc = _videoController;
          if (vc != null) {
            vc.seekTo(Duration(seconds: pos.toInt()));
          } else {
            await controller.runJavaScript('''
              (function() {
                var v = document.querySelector('video');
                if (v && v.readyState >= 2) v.currentTime = $pos;
                else if (v) v.addEventListener('loadeddata', function() { v.currentTime = $pos; }, { once: true });
              })();
            ''');
          }
        }
      } else if (type == 'pdf') {
        final pct = decoded['pdfScrollPct'] as num?;
        if (pct != null && pct > 0 && pct < 100) {
          await controller.runJavaScript('''
            (function() {
              var el = document.documentElement || document.body;
              if (el && el.scrollHeight > el.clientHeight) {
                var target = (el.scrollHeight - el.clientHeight) * ($pct / 100);
                el.scrollTop = Math.round(target);
              }
            })();
          ''');
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(_courseTitle ?? widget.courseTitle ?? 'Course')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    if (_showRetrainingGate) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_courseTitle ?? 'Course'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Retraining Change Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _enrollment!.retrainingChangeSummary!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      CheckboxListTile(
                        value: _acknowledgementChecked,
                        onChanged: (v) =>
                            setState(() => _acknowledgementChecked = v ?? false),
                        title: const Text(
                          'I have read and understood the changes above.',
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if (_acknowledgementChecked) ...[
                        const SizedBox(height: 16),
                        if (_signatureMeanings.isNotEmpty)
                          DropdownButtonFormField<String>(
                            value: _selectedSignatureMeaning,
                            decoration: const InputDecoration(
                              labelText: 'Signature meaning',
                            ),
                            items: _signatureMeanings
                                .map((m) => DropdownMenuItem(
                                      value: m.meaning,
                                      child: Text(m.meaning),
                                    ))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedSignatureMeaning = v),
                          ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password (re-authentication)',
                          ),
                        ),
                        if (_acknowledgementError != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            _acknowledgementError!,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _acknowledging
                                ? null
                                : _performAcknowledgement,
                            icon: _acknowledging
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : const Icon(Icons.draw),
                            label: Text(_acknowledging ? 'Signing...' : 'E-Sign'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentLesson = _lessons.isNotEmpty && _currentLessonIndex < _lessons.length
        ? _lessons[_currentLessonIndex]
        : null;

    // Dynamic progress: completed lessons + fractional progress of current lesson (time spent)
    double progress = 0.0;
    if (_lessons.isNotEmpty) {
      final completedCount = _lessonViewedMaterialIds.length;
      double currentFraction = 0.0;
      if (currentLesson != null &&
          !_lessonViewedMaterialIds.contains(currentLesson.materialId)) {
        final required = (currentLesson.durationMinutes ?? 1) * 60;
        currentFraction = (required > 0)
            ? (_currentLessonElapsedSeconds / required).clamp(0.0, 1.0)
            : 0.0;
      }
      progress = (completedCount + currentFraction) / _lessons.length;
    }

    return VisibilityDetector(
      key: const Key('course_viewer_visibility'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Scaffold(
      appBar: AppBar(
        title: Text(_courseTitle ?? 'Course'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.slate600,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (currentLesson != null &&
                            !_lessonViewedMaterialIds.contains(currentLesson.materialId)) ...[
                          Text(
                            'Time: ${_currentLessonElapsedSeconds ~/ 60}m ${_currentLessonElapsedSeconds % 60}s / '
                            '${(currentLesson.durationMinutes ?? 1)}m',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.slate600,
                                ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Text(
                          '${(progress * 100).round()}%',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.teal600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.slate200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal600),
                  ),
                ),
                if (currentLesson != null &&
                    !_lessonViewedMaterialIds.contains(currentLesson.materialId)) ...[
                  const SizedBox(height: 12),
                  _StickyReadTimeBar(
                    elapsedSeconds: _currentLessonElapsedSeconds,
                    requiredSeconds: (currentLesson.durationMinutes ?? 1) * 60,
                    onProceed: () => _markLessonCompleteAndProceed(currentLesson),
                    hasNextLesson: _currentLessonIndex < _lessons.length - 1,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_modules.isNotEmpty)
                    ..._modules.map((m) => Card(
                          child: ExpansionTile(
                            title: Text(m.title),
                            children: _lessons
                                .where((l) => l.moduleId == m.id)
                                .map((l) => ListTile(
                                      title: Text(l.title),
                                      trailing: _lessonViewedMaterialIds
                                              .contains(l.materialId)
                                          ? const Icon(Icons.check_circle,
                                              color: Colors.green)
                                          : null,
                                    ))
                                .toList(),
                          ),
                        )),
                  const SizedBox(height: 16),
                  if (currentLesson != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentLesson.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            if (_loadingMaterial)
                              const SizedBox(
                                height: 200,
                                child: Center(
                                    child: CircularProgressIndicator()),
                              )
                            else if (_materialViewUrl != null &&
                                _currentLessonWithMaterial?.material != null)
                              _buildMaterialViewer()
                            else if (_currentLessonWithMaterial?.material !=
                                null)
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentLessonWithMaterial!
                                        .material!.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Type: ${_currentLessonWithMaterial!.material!.materialType}. '
                                    'Minimum read time applies.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              )
                            else
                              const Text(
                                'No material content. '
                                'Minimum read time applies.',
                              ),
                            const SizedBox(height: 16),
                            Builder(
                              builder: (context) {
                                final remaining = _remainingSeconds(currentLesson);
                                final canProceed = _canProceed(currentLesson);
                                if (canProceed) {
                                  return const Text('✓ Ready to proceed');
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Read for ${remaining}s more',
                                      style: TextStyle(
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _startReadTimer(currentLesson),
                                      child: const Text('Start reading timer'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (_lessons.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No lessons in this course.'),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_lessons.isNotEmpty)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _currentLessonIndex > 0
                            ? () {
                                _stopReadTimer();
                                final prevIndex = _currentLessonIndex - 1;
                                _loadLessonMaterial(_lessons[prevIndex]);
                                setState(() => _currentLessonIndex = prevIndex);
                                if (!_lessonViewedMaterialIds.contains(_lessons[prevIndex].materialId)) {
                                  _startReadTimer(_lessons[prevIndex]);
                                }
                              }
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),
                    ),
                  if (_lessons.isNotEmpty) const SizedBox(width: 16),
                  if (_lessons.isNotEmpty)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _currentLessonIndex < _lessons.length - 1
                            ? (_canProceed(currentLesson!)
                                ? () {
                                    _stopReadTimer();
                                    final nextIndex = _currentLessonIndex + 1;
                                    _loadLessonMaterial(_lessons[nextIndex]);
                                    setState(() => _currentLessonIndex = nextIndex);
                                    if (!_lessonViewedMaterialIds.contains(_lessons[nextIndex].materialId)) {
                                      _startReadTimer(_lessons[nextIndex]);
                                    }
                                  }
                                : null)
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: !_showRetrainingGate &&
                          _allLessonsViewed &&
                          widget.enrollmentId != null &&
                          _effectiveCourseVersionId > 0
                      ? () {
                          context.push(
                            '/assessment/${widget.courseId}',
                            extra: {
                              'courseVersionId': _effectiveCourseVersionId,
                              'enrollmentId': widget.enrollmentId,
                              'userId': _effectiveUserId,
                              'courseTitle': _courseTitle ?? widget.courseTitle,
                            },
                          );
                        }
                      : null,
                  child: const Text('Take Assessment'),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

/// Sticky read time bar: animated progress, morphs to "Next Lesson" when complete.
class _StickyReadTimeBar extends StatelessWidget {
  const _StickyReadTimeBar({
    required this.elapsedSeconds,
    required this.requiredSeconds,
    required this.onProceed,
    required this.hasNextLesson,
  });

  final int elapsedSeconds;
  final int requiredSeconds;
  final VoidCallback onProceed;
  final bool hasNextLesson;

  @override
  Widget build(BuildContext context) {
    final progress = requiredSeconds > 0
        ? (elapsedSeconds / requiredSeconds).clamp(0.0, 1.0)
        : 1.0;
    final isComplete = progress >= 1.0;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isComplete
          ? Container(
              key: const ValueKey('complete'),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.teal600.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.teal600.withValues(alpha: 0.4)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onProceed,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: AppColors.teal600, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          hasNextLesson ? 'Proceed to Next Lesson' : 'Ready to proceed',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.teal700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Container(
              key: ValueKey(progress),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Read for ${requiredSeconds - elapsedSeconds}s more',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppColors.slate700,
                              ),
                        ),
                        Text(
                          '${elapsedSeconds ~/ 60}m ${elapsedSeconds % 60}s / ${requiredSeconds ~/ 60}m',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.slate600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: AppColors.slate200,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
