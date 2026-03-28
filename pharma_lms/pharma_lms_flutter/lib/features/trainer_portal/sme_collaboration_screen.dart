// ═══════════════════════════════════════════════════════════════════════════════
// SME COLLABORATION — invite, comments, resolve + in-app notifications (server)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/sme
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:intl/intl.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

class SmeCollaborationScreen extends ConsumerStatefulWidget {
  const SmeCollaborationScreen({super.key, required this.courseId});

  final int courseId;

  @override
  ConsumerState<SmeCollaborationScreen> createState() =>
      _SmeCollaborationScreenState();
}

class _SmeCollaborationScreenState extends ConsumerState<SmeCollaborationScreen> {
  Course? _course;
  List<CourseVersion> _versions = [];
  CourseVersion? _selectedVersion;
  List<SmeAssignment> _assignments = [];
  List<SmeReviewComment> _comments = [];
  List<PharmaUser> _orgUsers = [];
  PharmaUser? _inviteUser;
  bool _loading = true;
  String? _error;

  final _sectionController = TextEditingController();
  final _bodyController = TextEditingController();
  String _severity = 'note';
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _sectionController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final course = await client.course.getCourse(widget.courseId);
      final versions = await client.course.getCourseVersions(widget.courseId);
      final users = await client.organization.listUsers();
      final assignments =
          await client.sme.listAssignmentsForCourse(widget.courseId);
      versions.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      if (!mounted) return;
      setState(() {
        _course = course;
        _versions = versions;
        _selectedVersion = versions.isNotEmpty ? versions.first : null;
        _orgUsers = users.where((u) => u.status == 'active').toList();
        _assignments = assignments;
        _loading = false;
      });
      if (_selectedVersion?.id != null) {
        await _loadComments(_selectedVersion!.id!);
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

  Future<void> _loadComments(int courseVersionId) async {
    try {
      final list =
          await client.sme.listCommentsForCourseVersion(courseVersionId);
      if (mounted) setState(() => _comments = list);
    } catch (_) {
      if (mounted) setState(() => _comments = []);
    }
  }

  Future<void> _onVersionChanged(CourseVersion? v) async {
    setState(() => _selectedVersion = v);
    if (v?.id != null) await _loadComments(v!.id!);
  }

  Future<void> _invite() async {
    if (_inviteUser?.id == null) return;
    setState(() => _submitting = true);
    try {
      await client.sme.inviteSme(
        courseId: widget.courseId,
        smeUserId: _inviteUser!.id!,
        courseVersionId: _selectedVersion?.id,
      );
      final assignments =
          await client.sme.listAssignmentsForCourse(widget.courseId);
      if (mounted) {
        setState(() {
          _assignments = assignments;
          _submitting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SME invited — notification sent')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invite failed: $e')),
        );
      }
    }
  }

  Future<void> _postComment() async {
    if (_selectedVersion?.id == null) return;
    final body = _bodyController.text.trim();
    final section = _sectionController.text.trim().isEmpty
        ? 'General'
        : _sectionController.text.trim();
    if (body.isEmpty) return;
    setState(() => _submitting = true);
    try {
      await client.sme.addComment(
        courseVersionId: _selectedVersion!.id!,
        sectionRef: section,
        body: body,
        severity: _severity,
      );
      _bodyController.clear();
      await _loadComments(_selectedVersion!.id!);
      if (mounted) setState(() => _submitting = false);
    } catch (e) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comment failed: $e')),
        );
      }
    }
  }

  Future<void> _resolve(SmeReviewComment c) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Resolve comment'),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Trainer response (optional)',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Resolve')),
        ],
      ),
    );
    if (ok != true || c.id == null) return;
    try {
      await client.sme.resolveComment(
        commentId: c.id!,
        trainerResponse: ctrl.text.trim().isEmpty ? null : ctrl.text.trim(),
      );
      if (_selectedVersion?.id != null) {
        await _loadComments(_selectedVersion!.id!);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marked resolved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Resolve failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(currentUserProvider).valueOrNull;

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!, style: TextStyle(color: PharmaColors.danger)));
    }

    final courseTitle = _course?.title ?? 'Course';

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/trainer/courses/${widget.courseId}/versions'),
              icon: const Icon(Icons.arrow_back, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SME collaboration',
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(courseTitle,
                      style: PharmaTypography.body
                          .copyWith(color: PharmaColors.textTertiary)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Text('Invited SMEs',
            style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
        const SizedBox(height: 8),
        if (_assignments.isEmpty)
          Text('No SMEs invited yet.', style: PharmaTypography.caption)
        else
          ..._assignments.map((a) {
            final name =
                '${a.smeUser?.firstName ?? ''} ${a.smeUser?.lastName ?? ''}'
                    .trim();
            return ListTile(
              dense: true,
              leading: const Icon(Icons.person_search, size: 20),
              title: Text(
                name.isNotEmpty ? name : 'User #${a.smeUserId}',
                style: PharmaTypography.bodyMedium,
              ),
              subtitle: Text(
                a.smeUser?.email ?? '',
                style: PharmaTypography.caption,
              ),
              trailing: Text(
                a.status.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: PharmaColors.emerald600,
                ),
              ),
            );
          }),

        const SizedBox(height: 20),
        Text('Invite SME', style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<PharmaUser>(
                initialValue: _inviteUser,
                items: _orgUsers
                    .where((u) => u.id != null && u.id != me?.id)
                    .map(
                      (u) => DropdownMenuItem(
                        value: u,
                        child: Text(
                          '${u.firstName} ${u.lastName} (${u.email})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (u) => setState(() => _inviteUser = u),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
                isExpanded: true,
              ),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: _submitting || _inviteUser == null ? null : _invite,
              style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
              child: const Text('Send invite'),
            ),
          ],
        ),

        const SizedBox(height: 28),
        Text('Review thread', style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
        const SizedBox(height: 8),
        if (_versions.isEmpty)
          Text('No course versions yet.', style: PharmaTypography.caption)
        else
          DropdownButtonFormField<CourseVersion>(
            initialValue: _selectedVersion,
            items: _versions
                .map(
                  (v) => DropdownMenuItem(
                    value: v,
                    child: Text('v${v.version} (${v.status})'),
                  ),
                )
                .toList(),
            onChanged: _onVersionChanged,
            decoration: InputDecoration(
              labelText: 'Course version',
              filled: true,
              fillColor: PharmaColors.pageBg,
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
            ),
            isExpanded: true,
          ),
        const SizedBox(height: 16),

        TextField(
          controller: _sectionController,
          decoration: InputDecoration(
            labelText: 'Section reference',
            hintText: 'e.g. Module 2 — GMP refresher',
            filled: true,
            fillColor: PharmaColors.pageBg,
            border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _severity,
          items: const [
            DropdownMenuItem(value: 'note', child: Text('Note')),
            DropdownMenuItem(value: 'major', child: Text('Major')),
            DropdownMenuItem(value: 'critical', child: Text('Critical')),
          ],
          onChanged: (v) {
            if (v != null) setState(() => _severity = v);
          },
          decoration: InputDecoration(
            labelText: 'Severity',
            filled: true,
            fillColor: PharmaColors.pageBg,
            border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _bodyController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Comment',
            filled: true,
            fillColor: PharmaColors.pageBg,
            border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed:
                _submitting || _selectedVersion == null ? null : _postComment,
            icon: const Icon(Icons.send, size: 18),
            label: const Text('Post comment'),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          ),
        ),

        const SizedBox(height: 24),
        Text('Comments', style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
        const SizedBox(height: 8),
        if (_comments.isEmpty)
          Text('No comments for this version.', style: PharmaTypography.caption)
        else
          ..._comments.map((c) {
            final author =
                '${c.author?.firstName ?? ''} ${c.author?.lastName ?? ''}'.trim();
            final when = DateFormat('MMM d, yyyy · HH:mm').format(c.createdAt);
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
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
                      Expanded(
                        child: Text(
                          c.sectionRef,
                          style: PharmaTypography.bodyMedium
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: PharmaColors.emerald50,
                          borderRadius: PharmaRadius.pillRadius,
                        ),
                        child: Text(
                          c.severity.toUpperCase(),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: PharmaColors.emerald600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(c.body, style: PharmaTypography.body),
                  const SizedBox(height: 8),
                  Text(
                    '${author.isNotEmpty ? author : "User #${c.authorId}"} · $when',
                    style: PharmaTypography.caption
                        .copyWith(color: PharmaColors.textTertiary),
                  ),
                  if (c.resolved) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Resolved${c.trainerResponse != null && c.trainerResponse!.isNotEmpty ? ': ${c.trainerResponse}' : ''}',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.emerald600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else if (_course?.createdById == me?.id) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () => _resolve(c),
                      child: const Text('Resolve'),
                    ),
                  ],
                ],
              ),
            );
          }),
      ],
    );
  }
}
