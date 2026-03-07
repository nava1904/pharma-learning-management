import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'auth_provider.dart';

/// Fetches PharmaUser by email.
final userByEmailProvider = FutureProvider.family<PharmaUser?, String>((ref, email) async {
  return client.user.getUserByEmail(email);
});

/// Current user based on selected role.
final currentUserProvider = FutureProvider<PharmaUser?>((ref) async {
  final email = ref.watch(currentUserEmailProvider);
  if (email == null) return null;
  return client.user.getUserByEmail(email);
});
