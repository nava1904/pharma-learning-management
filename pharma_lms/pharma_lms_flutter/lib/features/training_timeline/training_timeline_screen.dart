import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/audit_timeline.dart';

/// Training timeline: chronological view of training activity.
class TrainingTimelineScreen extends ConsumerWidget {
  const TrainingTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(trainingRecordsProvider);
    final certificatesAsync = ref.watch(certificatesProvider);
    final userAsync = ref.watch(currentUserProvider);

    return AppShell(
      title: 'Training Timeline',
      icon: Icons.timeline_rounded,
      child: recordsAsync.when(
        data: (records) {
          final certificates = certificatesAsync.valueOrNull ?? [];
          final events = <AuditTimelineEvent>[];

          for (final r in records) {
            events.add(AuditTimelineEvent(
              timestamp: r.completedAt!,
              title: r.courseVersion?.course?.title ?? 'Course completed',
              subtitle: 'Score: ${r.score ?? 0}%',
              type: (r.score ?? 0) >= 80
                  ? AuditEventType.success
                  : AuditEventType.warning,
            ));
                    }

          for (final c in certificates) {
            events.add(AuditTimelineEvent(
              timestamp: c.issuedAt!,
              title: 'Certificate issued',
              subtitle: c.courseVersion?.course?.title ?? 'Course',
              type: AuditEventType.success,
              icon: Icons.verified_outlined,
            ));
                    }

          events.sort((a, b) => b.timestamp.compareTo(a.timestamp));

          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timeline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No training activity yet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(trainingRecordsProvider);
              ref.invalidate(certificatesProvider);
              await ref.read(trainingRecordsProvider.future);
              await ref.read(certificatesProvider.future);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: AuditTimeline(events: events),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $e', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(trainingRecordsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
