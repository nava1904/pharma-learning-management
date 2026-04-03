// Hub for /trainer/assessments — pick a course to open Assessment Builder (real API data).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_components.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';
import 'widgets/trainer_page_scaffold.dart';

class TrainerAssessmentsHubScreen extends ConsumerStatefulWidget {
  const TrainerAssessmentsHubScreen({super.key});

  @override
  ConsumerState<TrainerAssessmentsHubScreen> createState() =>
      _TrainerAssessmentsHubScreenState();
}

class _TrainerAssessmentsHubScreenState
    extends ConsumerState<TrainerAssessmentsHubScreen> {
  List<Course> _courses = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) throw Exception('Not signed in');
      final list = await client.course.listCourses(
        organizationId: user.organizationId,
      );
      if (mounted) {
        setState(() {
          _courses = list;
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Text(
          'Assessment builder',
          style: PharmaTypography.headingLarge.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Select a course to configure its quiz, question bank, and attempts.',
          style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
        ),
        const SizedBox(height: PharmaSpacing.sectionGap),
        if (_loading)
          const TrainerPageLoading(cardCount: 3)
        else if (_error != null)
          TrainerPageError(message: _error!, onRetry: _load)
        else if (_courses.isEmpty)
          PharmaEmptyState(
            icon: Icons.quiz_outlined,
            title: 'No courses yet',
            subtitle: 'Create a course first, then attach an assessment from the course builder or here.',
            action: FilledButton.icon(
              onPressed: () => context.go('/trainer/courses'),
              icon: const Icon(Icons.menu_book_outlined, size: 18),
              label: const Text('Go to courses'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: PharmaColors.cardBg,
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
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
                  child: Text(
                    'Your organization’s courses',
                    style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(height: 1),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _courses.length,
                  separatorBuilder: (_, _) => Divider(height: 1, color: PharmaColors.borderLight),
                  itemBuilder: (context, i) {
                    final c = _courses[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: PharmaSpacing.lg,
                        vertical: 4,
                      ),
                      leading: Icon(Icons.menu_book_outlined, color: PharmaColors.emerald600),
                      title: Text(
                        c.title,
                        style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        c.sopNumber != null ? 'SOP #${c.sopNumber} · ${c.status}' : c.status,
                        style: PharmaTypography.caption,
                      ),
                      trailing: Icon(Icons.chevron_right, color: PharmaColors.textQuaternary),
                      onTap: () {
                        if (c.id != null) {
                          context.go('/trainer/courses/${c.id}/assessment');
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
