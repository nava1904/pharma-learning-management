import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:url_launcher/url_launcher.dart';

import '../../core/client.dart';
import '../../core/lms_realtime.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';

/// Opens QA / SME review thread for a [courseId] (picks best matching version).
Future<void> openCourseQaThreadForCourse(
  BuildContext context, {
  required int courseId,
  required String courseTitle,
}) async {
  try {
    final versions = await client.course.getCourseVersions(courseId);
    int? vid;
    for (final v in versions) {
      if (v.status == 'pending_qa' || v.status == 'under_review') {
        vid = v.id;
        break;
      }
    }
    if (vid == null) {
      for (final v in versions) {
        if (v.status == 'draft') {
          vid = v.id;
          break;
        }
      }
    }
    vid ??= versions.isNotEmpty ? versions.first.id : null;
    if (vid == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No course version found for QA thread.')),
        );
      }
      return;
    }
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: PharmaColors.cardBg,
      builder: (ctx) => SizedBox(
        height: MediaQuery.sizeOf(ctx).height * 0.88,
        child: CourseQaThreadSheet(courseVersionId: vid!, courseTitle: courseTitle),
      ),
    );
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QA thread: $e')),
      );
    }
  }
}

Future<void> openCourseQaThreadForVersion(
  BuildContext context, {
  required int courseVersionId,
  required String courseTitle,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: PharmaColors.cardBg,
    builder: (ctx) => SizedBox(
      height: MediaQuery.sizeOf(ctx).height * 0.88,
      child: CourseQaThreadSheet(courseVersionId: courseVersionId, courseTitle: courseTitle),
    ),
  );
}

Future<void> openLearnerInstructorChat(
  BuildContext context, {
  required int courseVersionId,
  required String courseTitle,
  /// When set (e.g. from dashboard recent activity), scroll to this message after load.
  int? focusMessageId,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: PharmaColors.cardBg,
    builder: (ctx) => SizedBox(
      height: MediaQuery.sizeOf(ctx).height * 0.88,
      child: LearnerInstructorChatSheet(
        courseVersionId: courseVersionId,
        courseTitle: courseTitle,
        focusMessageId: focusMessageId,
      ),
    ),
  );
}

class CourseQaThreadSheet extends ConsumerStatefulWidget {
  const CourseQaThreadSheet({
    super.key,
    required this.courseVersionId,
    required this.courseTitle,
  });

  final int courseVersionId;
  final String courseTitle;

  @override
  ConsumerState<CourseQaThreadSheet> createState() => _CourseQaThreadSheetState();
}

class _CourseQaThreadSheetState extends ConsumerState<CourseQaThreadSheet> {
  final _text = TextEditingController();
  List<SmeReviewComment> _rows = [];
  int? _ownerId;
  int? _replyToId;
  StreamSubscription<Map<String, dynamic>>? _rtSub;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final room = 'qa_thread:cv:${widget.courseVersionId}';
    await LmsRealtime.ensureConnected();
    LmsRealtime.subscribeRooms([room]);
    _rtSub = LmsRealtime.events.listen((e) {
      final ev = e['event'] as String?;
      final cv = e['courseVersionId'];
      if (cv == widget.courseVersionId &&
          (ev == 'sme_comment_created' || ev == 'sme_comment_resolved')) {
        _reload();
      }
    });
    await _reload();
  }

  Future<void> _reload() async {
    try {
      final cv = await client.course.getCourseVersion(widget.courseVersionId);
      if (cv == null) {
        if (mounted) setState(() => _loading = false);
        return;
      }
      final course = await client.course.getCourse(cv.courseId);
      final list = await client.sme.listCommentsForCourseVersion(widget.courseVersionId);
      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      // Mark QA comments as read for the current user
      try {
        await client.sme.markCommentsRead(widget.courseVersionId);
      } catch (_) {}
      if (mounted) {
        setState(() {
          _ownerId = course?.createdById;
          _rows = list;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _rtSub?.cancel();
    LmsRealtime.unsubscribeRooms(['qa_thread:cv:${widget.courseVersionId}']);
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final t = _text.text.trim();
    if (t.isEmpty) return;
    try {
      await client.sme.addComment(
        courseVersionId: widget.courseVersionId,
        sectionRef: 'general',
        body: t,
        severity: 'note',
        parentCommentId: _replyToId,
      );
      _text.clear();
      setState(() => _replyToId = null);
      await _reload();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> _resolve(SmeReviewComment c) async {
    try {
      await client.sme.resolveComment(commentId: c.id!, trainerResponse: 'Acknowledged');
      await _reload();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final meAsync = ref.watch(currentUserProvider);
    final meId = meAsync.valueOrNull?.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(PharmaSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'QA & review — ${widget.courseTitle}',
                  style: PharmaTypography.headingSmall,
                ),
              ),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
        ),
        if (_replyToId != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md),
            child: Row(
              children: [
                Text('Replying…', style: PharmaTypography.caption),
                TextButton(onPressed: () => setState(() => _replyToId = null), child: const Text('Cancel')),
              ],
            ),
          ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(PharmaSpacing.md),
                  itemCount: _rows.length,
                  itemBuilder: (context, i) {
                    final c = _rows[i];
                    final author = c.author;
                    final name = author != null
                        ? '${author.firstName} ${author.lastName}'
                        : 'User ${c.authorId}';
                    final mine = meId == c.authorId;
                    final canResolve = meId != null &&
                        meId == _ownerId &&
                        !c.resolved &&
                        !mine;
                    return Card(
                      margin: const EdgeInsets.only(bottom: PharmaSpacing.sm),
                      child: Padding(
                        padding: const EdgeInsets.all(PharmaSpacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                            Text(DateFormat.yMMMd().add_jm().format(c.createdAt.toLocal()),
                                style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
                            const SizedBox(height: 4),
                            Text(c.body, style: PharmaTypography.body),
                            if (c.resolved) ...[
                              const SizedBox(height: 4),
                              Text('Resolved', style: PharmaTypography.caption.copyWith(color: PharmaColors.emerald600)),
                            ],
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => setState(() => _replyToId = c.id),
                                  child: const Text('Reply'),
                                ),
                                if (canResolve)
                                  TextButton(
                                    onPressed: () => _resolve(c),
                                    child: const Text('Resolve'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: PharmaSpacing.md,
            right: PharmaSpacing.md,
            bottom: MediaQuery.paddingOf(context).bottom + PharmaSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _text,
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Add comment…',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(onPressed: _send, child: const Icon(Icons.send)),
            ],
          ),
        ),
      ],
    );
  }
}

class LearnerInstructorChatSheet extends ConsumerStatefulWidget {
  const LearnerInstructorChatSheet({
    super.key,
    required this.courseVersionId,
    required this.courseTitle,
    this.focusMessageId,
  });

  final int courseVersionId;
  final String courseTitle;
  final int? focusMessageId;

  @override
  ConsumerState<LearnerInstructorChatSheet> createState() => _LearnerInstructorChatSheetState();
}

class _LearnerInstructorChatSheetState extends ConsumerState<LearnerInstructorChatSheet> {
  final _text = TextEditingController();
  List<LearnerTrainerMessage> _rows = [];
  int? _replyToId;
  StreamSubscription<Map<String, dynamic>>? _rtSub;
  bool _loading = true;
  final Map<int, GlobalKey> _messageKeys = {};
  bool _scrolledToFocus = false;
  /// True when the current user has an enrollment row for this course version (learner path).
  bool _isLearner = false;
  /// Other users enrolled in this version (for trainer-initiated first message).
  List<Enrollment> _otherEnrollments = [];
  int? _firstMessageToUserId;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void didUpdateWidget(LearnerInstructorChatSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusMessageId != widget.focusMessageId) {
      _scrolledToFocus = false;
    }
  }

  void _scrollToFocusMessageIfNeeded() {
    final id = widget.focusMessageId;
    if (id == null || _scrolledToFocus || _rows.isEmpty) return;
    if (!_rows.any((m) => m.id == id)) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _scrolledToFocus) return;
      final key = _messageKeys[id];
      final ctx = key?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          alignment: 0.25,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
        setState(() => _scrolledToFocus = true);
      }
    });
  }

  Future<void> _bootstrap() async {
    final room = 'learner_trainer:cv:${widget.courseVersionId}';
    await LmsRealtime.ensureConnected();
    LmsRealtime.subscribeRooms([room]);
    _rtSub = LmsRealtime.events.listen((e) {
      final ev = e['event'] as String?;
      final cv = e['courseVersionId'];
      if (cv == widget.courseVersionId && ev == 'learner_trainer_message_created') {
        _reload();
      }
    });
    await _reload();
  }

  Future<void> _reload() async {
    final meId = ref.read(currentUserProvider).valueOrNull?.id;
    try {
      final list = await client.learnerSupport.listThread(widget.courseVersionId);
      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      List<Enrollment> enrollments = [];
      try {
        enrollments = await client.training.getEnrollmentsForCourseVersion(widget.courseVersionId);
      } catch (_) {}

      final isLearner = meId != null && enrollments.any((e) => e.userId == meId);
      final others = meId == null
          ? <Enrollment>[]
          : enrollments.where((e) => e.userId != meId).toList();

      int? firstTo;
      if (!isLearner && list.isEmpty && others.length == 1) {
        firstTo = others.first.userId;
      }

      await client.learnerSupport.markThreadMessagesRead(widget.courseVersionId);
      if (mounted) {
        setState(() {
          _rows = list;
          _isLearner = isLearner;
          _otherEnrollments = others;
          _firstMessageToUserId = firstTo ?? _firstMessageToUserId;
          _loading = false;
        });
        _scrollToFocusMessageIfNeeded();
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _rtSub?.cancel();
    LmsRealtime.unsubscribeRooms(['learner_trainer:cv:${widget.courseVersionId}']);
    _text.dispose();
    super.dispose();
  }

  /// Server requires trainers to send either a reply [parentMessageId] or [toUserId] for a new thread.
  ({int? parentId, int? toUserId}) _resolveTrainerSendTargets(int meId) {
    int? parentId = _replyToId;
    int? toUserId;

    if (parentId != null) {
      return (parentId: parentId, toUserId: null);
    }

    if (_rows.isNotEmpty) {
      LearnerTrainerMessage? lastFromOther;
      for (final m in _rows.reversed) {
        if (m.fromUserId != meId) {
          lastFromOther = m;
          break;
        }
      }
      if (lastFromOther != null) {
        return (parentId: lastFromOther.id, toUserId: null);
      }
      final last = _rows.last;
      if (last.fromUserId == meId) {
        toUserId = last.toUserId;
      }
      return (parentId: null, toUserId: toUserId);
    }

    return (parentId: null, toUserId: _firstMessageToUserId);
  }

  Future<void> _send() async {
    final t = _text.text.trim();
    if (t.isEmpty) return;
    final meId = ref.read(currentUserProvider).valueOrNull?.id;
    if (meId == null) return;

    int? parentId = _replyToId;
    int? toUserId;

    if (_isLearner) {
      parentId = _replyToId;
    } else {
      final r = _resolveTrainerSendTargets(meId);
      parentId = r.parentId;
      toUserId = r.toUserId;
      if (parentId == null && toUserId == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Select a learner above, or reply to an existing message.',
              ),
            ),
          );
        }
        return;
      }
    }

    try {
      final result = await client.learnerSupport.sendMessage(
        courseVersionId: widget.courseVersionId,
        body: t,
        parentMessageId: parentId,
        toUserId: toUserId,
      );
      if (result == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not send message. You may lack permission or the target learner is not enrolled.',
              ),
            ),
          );
        }
        return;
      }
      _text.clear();
      setState(() => _replyToId = null);
      await _reload();
  // Invalidate and force refresh so dashboard always updates immediately
  ref.invalidate(recentActivityProvider);
  ref.invalidate(dashboardSummaryProvider);
  await ref.read(dashboardSummaryProvider.future);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  String _enrollmentLabel(Enrollment e) {
    final u = e.user;
    if (u != null) {
      final name = '${u.firstName} ${u.lastName}'.trim();
      if (name.isNotEmpty) return name;
    }
    return 'User ${e.userId}';
  }

  /// Valid selection for the learner dropdown (must match an item value).
  int? get _recipientDropdownValue {
    final ids = _otherEnrollments.map((e) => e.userId).toSet();
    final id = _firstMessageToUserId;
    if (id != null && ids.contains(id)) return id;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final meAsync = ref.watch(currentUserProvider);
    final meId = meAsync.valueOrNull?.id;

    final title = _isLearner
        ? 'Message instructor — ${widget.courseTitle}'
        : 'Learner messages — ${widget.courseTitle}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(PharmaSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: PharmaTypography.headingSmall,
                ),
              ),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
        ),
        if (!_isLearner && _rows.isEmpty && _otherEnrollments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Send to',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
                ),
                const SizedBox(height: 4),
                InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      hint: const Text('Choose learner'),
                      value: _recipientDropdownValue,
                      items: [
                        for (final e in _otherEnrollments)
                          DropdownMenuItem(
                            value: e.userId,
                            child: Text(_enrollmentLabel(e)),
                          ),
                      ],
                      onChanged: (v) => setState(() => _firstMessageToUserId = v),
                    ),
                  ),
                ),
                const SizedBox(height: PharmaSpacing.sm),
              ],
            ),
          ),
        if (_replyToId != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md),
            child: Row(
              children: [
                Text('Replying…', style: PharmaTypography.caption),
                TextButton(onPressed: () => setState(() => _replyToId = null), child: const Text('Cancel')),
              ],
            ),
          ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(PharmaSpacing.md),
                  itemCount: _rows.length,
                  itemBuilder: (context, i) {
                    final m = _rows[i];
                    final mid = m.id;
                    if (mid != null) {
                      _messageKeys.putIfAbsent(mid, GlobalKey.new);
                    }
                    final from = m.fromUser;
                    final name = from != null ? '${from.firstName} ${from.lastName}' : 'User ${m.fromUserId}';
                    final alignRight = meId == m.fromUserId;
                    final highlight =
                        widget.focusMessageId != null && m.id == widget.focusMessageId;
                    return KeyedSubtree(
                      key: mid != null ? _messageKeys[mid] : null,
                      child: Align(
                        alignment:
                            alignRight ? Alignment.centerRight : Alignment.centerLeft,
                        child: Card(
                          elevation: highlight ? 3 : 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: highlight
                                ? BorderSide(color: PharmaColors.emerald600, width: 2)
                                : BorderSide.none,
                          ),
                          color: alignRight ? PharmaColors.emerald50 : PharmaColors.pageBg,
                          child: Padding(
                            padding: const EdgeInsets.all(PharmaSpacing.sm),
                            child: Column(
                              crossAxisAlignment: alignRight
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: PharmaTypography.caption
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(m.body, style: PharmaTypography.body),
                                TextButton(
                                  onPressed: () => setState(() => _replyToId = m.id),
                                  child: const Text('Reply'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: PharmaSpacing.md,
            right: PharmaSpacing.md,
            bottom: MediaQuery.paddingOf(context).bottom + PharmaSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _text,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: _isLearner ? 'Write a message…' : 'Write a reply…',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(onPressed: _send, child: const Icon(Icons.send)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Read-only batch feed (announcements + live classes) for employees.
class EmployeeBatchFeedSection extends StatefulWidget {
  const EmployeeBatchFeedSection({super.key, required this.batchId});

  final int batchId;

  @override
  State<EmployeeBatchFeedSection> createState() => _EmployeeBatchFeedSectionState();
}

class _EmployeeBatchFeedSectionState extends State<EmployeeBatchFeedSection> {
  List<BatchAnnouncement> _announcements = [];
  List<LiveClass> _live = [];
  StreamSubscription<Map<String, dynamic>>? _rtSub;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    _wireRt();
  }

  Future<void> _load() async {
    try {
      final a = await client.batchAnnouncement.listForBatch(widget.batchId);
      final l = await client.liveClass.listByBatch(widget.batchId);
      if (mounted) {
        setState(() {
          _announcements = a;
          _live = l;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _wireRt() async {
    final room = 'batch:${widget.batchId}';
    await LmsRealtime.ensureConnected();
    LmsRealtime.subscribeRooms([room]);
    _rtSub = LmsRealtime.events.listen((e) {
      final bid = e['batchId'];
      if (bid == widget.batchId) _load();
    });
  }

  @override
  void dispose() {
    _rtSub?.cancel();
    LmsRealtime.unsubscribeRooms(['batch:${widget.batchId}']);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(PharmaSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Updates & live sessions', style: PharmaTypography.headingSmall),
        const SizedBox(height: PharmaSpacing.sm),
        if (_live.isEmpty && _announcements.isEmpty)
          Text('No announcements yet.', style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary))
        else ...[
          ..._live.map((lc) {
            return ListTile(
              leading: const Icon(Icons.video_call_outlined),
              title: Text(lc.title),
              subtitle: Text(DateFormat.yMMMd().add_jm().format(lc.scheduledAt.toLocal())),
              trailing: lc.meetingUrl != null && lc.meetingUrl!.isNotEmpty
                  ? TextButton(
                      onPressed: () async {
                        final u = Uri.tryParse(lc.meetingUrl!);
                        if (u != null) await launchUrl(u, mode: LaunchMode.externalApplication);
                      },
                      child: const Text('Join'),
                    )
                  : null,
            );
          }),
          ..._announcements.map((a) {
            return ListTile(
              leading: Icon(
                a.kind == 'live_session' ? Icons.campaign_outlined : Icons.info_outline,
              ),
              title: Text(a.title),
              subtitle: Text(a.body),
            );
          }),
        ],
      ],
    );
  }
}

/// Trainer batch tab: post announcements; list refreshes on WebSocket batch events.
class TrainerBatchAnnouncementsTab extends StatefulWidget {
  const TrainerBatchAnnouncementsTab({super.key, required this.batchId});

  final int batchId;

  @override
  State<TrainerBatchAnnouncementsTab> createState() => _TrainerBatchAnnouncementsTabState();
}

class _TrainerBatchAnnouncementsTabState extends State<TrainerBatchAnnouncementsTab> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  List<BatchAnnouncement> _rows = [];
  List<LiveClass> _live = [];
  StreamSubscription<Map<String, dynamic>>? _rtSub;
  bool _loading = true;
  bool _posting = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _load();
    final room = 'batch:${widget.batchId}';
    await LmsRealtime.ensureConnected();
    LmsRealtime.subscribeRooms([room]);
    _rtSub = LmsRealtime.events.listen((e) {
      final bid = e['batchId'];
      if (bid == widget.batchId) _load();
    });
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        client.batchAnnouncement.listForBatch(widget.batchId),
        client.liveClass.listByBatch(widget.batchId),
      ]);
      final list = results[0] as List<BatchAnnouncement>;
      final live = results[1] as List<LiveClass>;
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (mounted) {
        setState(() {
          _rows = list;
          _live = live;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _post() async {
    final t = _title.text.trim();
    final b = _body.text.trim();
    if (t.isEmpty || b.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title and body are required.')),
        );
      }
      return;
    }
    setState(() => _posting = true);
    try {
      final created = await client.batchAnnouncement.createForBatch(
        batchId: widget.batchId,
        title: t,
        body: b,
        kind: 'general',
      );
      if (created == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not post. You may lack permission, or the batch is in another organization.',
              ),
              backgroundColor: PharmaColors.danger,
            ),
          );
        }
        return;
      }
      _title.clear();
      _body.clear();
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  void dispose() {
    _rtSub?.cancel();
    LmsRealtime.unsubscribeRooms(['batch:${widget.batchId}']);
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(PharmaSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('New announcement', style: PharmaTypography.headingSmall),
              const SizedBox(height: PharmaSpacing.sm),
              TextField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: PharmaSpacing.sm),
              TextField(
                controller: _body,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: PharmaSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _posting ? null : _post,
                  icon: _posting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send, size: 18),
                  label: const Text('Post to cohort'),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(PharmaSpacing.md),
            children: [
              Text('Live sessions', style: PharmaTypography.headingSmall),
              const SizedBox(height: PharmaSpacing.sm),
              if (_live.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
                  child: Text(
                    'No live classes scheduled for this batch.',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                  ),
                )
              else
                ..._live.map((lc) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: PharmaSpacing.sm),
                    child: ListTile(
                      leading: const Icon(Icons.video_call_outlined),
                      title: Text(lc.title),
                      subtitle: Text(
                        DateFormat.yMMMd().add_jm().format(lc.scheduledAt.toLocal()),
                      ),
                      trailing: lc.meetingUrl != null && lc.meetingUrl!.isNotEmpty
                          ? TextButton(
                              onPressed: () async {
                                final u = Uri.tryParse(lc.meetingUrl!);
                                if (u != null) {
                                  await launchUrl(u, mode: LaunchMode.externalApplication);
                                }
                              },
                              child: const Text('Join'),
                            )
                          : null,
                    ),
                  );
                }),
              const SizedBox(height: PharmaSpacing.md),
              Text('Announcement feed', style: PharmaTypography.headingSmall),
              const SizedBox(height: PharmaSpacing.sm),
              if (_rows.isEmpty)
                Text(
                  'No announcements yet.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                )
              else
                ..._rows.map((a) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: PharmaSpacing.sm),
                    child: ListTile(
                      leading: Icon(
                        a.kind == 'live_session' ? Icons.campaign_outlined : Icons.info_outline,
                      ),
                      title: Text(a.title),
                      subtitle: Text(a.body),
                    ),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
