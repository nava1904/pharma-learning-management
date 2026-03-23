import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_providers_v2.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

class UserDirectoryScreen extends ConsumerWidget {
  const UserDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(adminUsersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('User Directory')),
      body: usersAsync.when(
        data: (users) => _UserList(users: users),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  final List<PharmaUser> users;
  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, i) {
        final user = users[i];
        return ListTile(
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.email),
          trailing: Text((user.status.toLowerCase() == 'active') ? 'Active' : 'Inactive'),
          onTap: () {
            // TODO: Navigate to user detail screen
          },
        );
      },
    );
  }
}
