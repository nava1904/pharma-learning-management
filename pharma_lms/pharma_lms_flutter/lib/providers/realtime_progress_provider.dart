import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/lms_realtime.dart';
import 'dashboard_providers.dart';
import 'user_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — REALTIME PROGRESS PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════
//
// Subscribes to WebSocket room `progress:user:<userId>` for live updates to:
//   - Material progress (lesson completion percentage)
//   - Engagement heartbeats (time spent on content)
//   - Enrollment progress (overall course completion)
//
// Used by the Employee Dashboard to show live-updating progress bars and the
// Course Viewer to reflect cross-tab progress changes.
//
// When a `material_progress` event with progressPct=100 is received, the
// enrollment progress map is recalculated and dashboard providers are
// invalidated for instant UI update.
// ═══════════════════════════════════════════════════════════════════════════════

/// Realtime progress events for the current user.
/// Maintains a map of enrollmentId → latest progressPct from WebSocket events.
/// Falls back gracefully if WebSocket is unavailable.
class RealtimeProgressNotifier extends StateNotifier<Map<int, double>> {
  RealtimeProgressNotifier(this._ref) : super({}) {
    _init();
  }

  final Ref _ref;
  StreamSubscription<Map<String, dynamic>>? _wsSub;

  Future<void> _init() async {
    final user = _ref.read(currentUserProvider).valueOrNull;
    if (user?.id == null) return;

    final userId = user!.id!;

    try {
      await LmsRealtime.ensureConnected();
      LmsRealtime.subscribeRooms(['progress:user:$userId']);

      _wsSub = LmsRealtime.events.listen((event) {
        final eventType = event['event'] as String?;

        if (eventType == 'material_progress') {
          final enrollmentId = event['enrollmentId'] as int?;
          final progressPct = (event['progressPct'] as num?)?.toDouble();
          final readTimeMet = event['readTimeMet'] as bool?;

          if (enrollmentId != null && progressPct != null) {
            // Update local progress map
            final current = Map<int, double>.from(state);
            final existingPct = current[enrollmentId] ?? 0.0;
            if (progressPct > existingPct) {
              current[enrollmentId] = progressPct;
              state = current;
            }
          }

          // When a lesson is completed (100%), refresh the enrollment progress
          if (progressPct != null && progressPct >= 100 || readTimeMet == true) {
            _ref.invalidate(enrollmentProgressProvider);

          }
        }

        if (eventType == 'engagement_heartbeat') {
          final enrollmentId = event['enrollmentId'] as int?;
          final timeSpent = event['timeSpentSeconds'] as int?;
          final required = event['requiredSeconds'] as int?;
          final readTimeMet = event['readTimeMet'] as bool?;

          if (enrollmentId != null && timeSpent != null && required != null && required > 0) {
            // Compute a progress estimate from time spent ratio
            final timePct = (timeSpent / required * 100).clamp(0.0, 100.0);
            final current = Map<int, double>.from(state);
            final existingPct = current[enrollmentId] ?? 0.0;

            // Only update if engagement progress is higher than material-progress based value
            // (material_progress events are authoritative; heartbeats are interim estimates)
            if (timePct > existingPct && !readTimeMet!) {
              current[enrollmentId] = timePct;
              state = current;
            }
          }
        }
      });
    } catch (e) {

    }
  }

  @override
  void dispose() {
    _wsSub?.cancel();
    final user = _ref.read(currentUserProvider).valueOrNull;
    if (user?.id != null) {
      LmsRealtime.unsubscribeRooms(['progress:user:${user!.id}']);
    }
    super.dispose();
  }
}

/// Provides a live-updating map of enrollmentId → progressPct from WebSocket.
/// Merges with the server-fetched [enrollmentProgressProvider] for the most
/// accurate view. Use in dashboard widgets for realtime progress bars.
final realtimeProgressProvider =
    StateNotifierProvider.autoDispose<RealtimeProgressNotifier, Map<int, double>>(
  (ref) => RealtimeProgressNotifier(ref),
);

/// Merged progress map: combines server-fetched progress with realtime updates.
/// Always returns the higher value for each enrollment (realtime may be ahead
/// of the last server fetch).
final mergedEnrollmentProgressProvider =
    Provider.autoDispose<Map<int, double>>((ref) {
  final serverProgress = ref.watch(enrollmentProgressProvider).valueOrNull ?? {};
  final realtimeProgress = ref.watch(realtimeProgressProvider);

  final merged = Map<int, double>.from(serverProgress);
  for (final entry in realtimeProgress.entries) {
    final existing = merged[entry.key] ?? 0.0;
    if (entry.value > existing) {
      merged[entry.key] = entry.value;
    }
  }
  return merged;
});
