import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'user_provider.dart';

/// In-app notifications for current user.
final notificationsProvider = FutureProvider<List<InAppNotification>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.notification.getInAppNotifications(user!.id!);
});
