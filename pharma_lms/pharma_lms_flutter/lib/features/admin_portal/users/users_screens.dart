import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show PharmaUser;
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../access_review/access_review_screen.dart';
import '../modules/01_user_identity/user_bulk_import_screen.dart';
import '../modules/01_user_identity/user_create_screen.dart';
import '../widgets/admin_page_frame.dart';
import '../widgets/admin_page_scaffold.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// USER DIRECTORY SCREEN - Real data from backend
// ═══════════════════════════════════════════════════════════════════════════════

class AdminUserDirectoryScreen extends ConsumerStatefulWidget {
  const AdminUserDirectoryScreen({super.key});

  @override
  ConsumerState<AdminUserDirectoryScreen> createState() => _AdminUserDirectoryScreenState();
}

class _AdminUserDirectoryScreenState extends ConsumerState<AdminUserDirectoryScreen> {
  String _searchQuery = '';
  String? _selectedStatus;
  int _currentPage = 1;
  final int _perPage = 20;

  @override
  Widget build(BuildContext context) {
    final usersParams = UsersListParams(
      page: _currentPage,
      perPage: _perPage,
      search: _searchQuery.isNotEmpty ? _searchQuery : null,
      status: _selectedStatus,
    );
    
    final usersAsync = ref.watch(adminUsersListProvider(usersParams));
    final userCountAsync = ref.watch(adminUserCountProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(context, userCountAsync),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Search & Filters
          _buildSearchAndFilters(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Users Table
          usersAsync.when(
            data: (users) => _buildUsersTable(context, users),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),

          // Pagination
          SizedBox(height: PharmaSpacing.sectionGap),
          _buildPagination(userCountAsync),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, AsyncValue<int> userCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Directory', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            userCount.when(
              data: (count) => Text(
                '$count total users',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              loading: () => Text(
                'Loading...',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => context.push('/admin/users/directory/import'),
              icon: const Icon(Icons.upload_file_outlined, size: 18),
              label: const Text('Import'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.textSecondary,
                side: BorderSide(color: PharmaColors.borderMedium),
              ),
            ),
            SizedBox(width: PharmaSpacing.md),
            ElevatedButton.icon(
              onPressed: () => context.push('/admin/users/directory/create'),
              icon: const Icon(Icons.person_add_outlined, size: 18),
              label: const Text('Create User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Search Box
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (value) => setState(() {
                _searchQuery = value;
                _currentPage = 1;
              }),
              decoration: InputDecoration(
                hintText: 'Search by name, email, or employee ID...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                  vertical: PharmaSpacing.sm,
                ),
              ),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Status Filter
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'Status',
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                  vertical: PharmaSpacing.sm,
                ),
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text('All')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                DropdownMenuItem(value: 'pending', child: Text('Pending')),
              ],
              onChanged: (value) => setState(() {
                _selectedStatus = value;
                _currentPage = 1;
              }),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          
          // Clear Filters
          TextButton.icon(
            onPressed: () => setState(() {
              _searchQuery = '';
              _selectedStatus = null;
              _currentPage = 1;
            }),
            icon: const Icon(Icons.clear, size: 18),
            label: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  // For bulk selection
  final Set<int> _selectedUserIds = {};

  Widget _buildUsersTable(BuildContext context, List<PharmaUser> users) {
    if (users.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.people_outline, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No users found',
                style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textTertiary),
              ),
              if (_searchQuery.isNotEmpty || _selectedStatus != null)
                TextButton(
                  onPressed: () => setState(() {
                    _searchQuery = '';
                    _selectedStatus = null;
                  }),
                  child: const Text('Clear filters'),
                ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: PharmaSpacing.cardPadding,
              vertical: PharmaSpacing.md,
            ),
            decoration: BoxDecoration(
              color: PharmaColors.gray50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(PharmaRadius.md)),
            ),
            child: Row(
              children: [
                // Checkbox for bulk select
                SizedBox(
                  width: 32,
                  child: Checkbox(
                    value: _selectedUserIds.length == users.length && users.isNotEmpty,
                    onChanged: (checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedUserIds.addAll(users.map((u) => u.id!));
                        } else {
                          _selectedUserIds.clear();
                        }
                      });
                    },
                  ),
                ),
                _buildHeaderCell('Employee', flex: 2),
                _buildHeaderCell('ID', flex: 1),
                _buildHeaderCell('Dept/Site', flex: 2),
                _buildHeaderCell('Roles', flex: 2),
                _buildHeaderCell('Status', flex: 1),
                _buildHeaderCell('Last Login', flex: 2),
                _buildHeaderCell('Auth', flex: 1),
                _buildHeaderCell('MFA', flex: 1),
                _buildHeaderCell('Compliance', flex: 1),
                _buildHeaderCell('Actions', flex: 1),
              ],
            ),
          ),
          // Table Rows
          ...users.map((user) => _buildUserRow(context, user)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: PharmaTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: PharmaColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildUserRow(BuildContext context, PharmaUser user) {
    final statusColor = _getStatusColor(user.status);
    final isSelected = _selectedUserIds.contains(user.id);
    final lastLogin = user.lastLogin != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(user.lastLogin!.toLocal())
        : '—';
    final authType = user.authType ?? '—';
    final mfaEnabled = user.mfaEnabled ?? false;
    final compliance = user.compliancePercent ?? 0.0;
    final roles = user.roles ?? [];
    final department = user.department?.name ?? 'Dept #${user.departmentId}';
    final site = user.site?.name ?? '';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PharmaSpacing.cardPadding,
        vertical: PharmaSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          // Checkbox
          SizedBox(
            width: 32,
            child: Checkbox(
              value: isSelected,
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                      _selectedUserIds.add(user.id!);
                  } else {
                    _selectedUserIds.remove(user.id);
                  }
                });
              },
            ),
          ),
          // Employee Info
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: PharmaColors.emerald100,
                  child: Text(
                    '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}',
                    style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.emerald600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: PharmaSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: PharmaTypography.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.email,
                        style: PharmaTypography.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ID
          Expanded(
            flex: 1,
            child: Text(user.employeeId ?? '—', style: PharmaTypography.body, overflow: TextOverflow.ellipsis),
          ),
          // Dept/Site
          Expanded(
            flex: 2,
            child: Text('$department${site.isNotEmpty ? ", $site" : ""}', style: PharmaTypography.body, overflow: TextOverflow.ellipsis),
          ),
          // Roles (badges)
          Expanded(
            flex: 2,
            child: Wrap(
              spacing: 4,
              children: roles.isNotEmpty
                  ? roles.map<Widget>((role) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: PharmaColors.info.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(role, style: PharmaTypography.caption.copyWith(color: PharmaColors.info)),
                      )).toList()
                  : [Text('—', style: PharmaTypography.caption)],
            ),
          ),
          // Status (pill)
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
              ),
              child: Text(
                user.status.toUpperCase(),
                style: PharmaTypography.caption.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Last Login
          Expanded(
            flex: 2,
            child: Text(lastLogin, style: PharmaTypography.caption, overflow: TextOverflow.ellipsis),
          ),
          // Auth
          Expanded(
            flex: 1,
            child: Text(authType, style: PharmaTypography.caption, overflow: TextOverflow.ellipsis),
          ),
          // MFA
          Expanded(
            flex: 1,
            child: Icon(mfaEnabled ? Icons.check_circle : Icons.cancel, color: mfaEnabled ? PharmaColors.success : PharmaColors.textTertiary, size: 18),
          ),
          // Compliance
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: compliance / 100.0,
                    backgroundColor: PharmaColors.gray100,
                    valueColor: AlwaysStoppedAnimation<Color>(compliance >= 80 ? PharmaColors.success : PharmaColors.warning),
                  ),
                ),
                SizedBox(width: 4),
                Text('${compliance.toStringAsFixed(0)}%', style: PharmaTypography.caption),
              ],
            ),
          ),
          // Actions
          Expanded(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  onPressed: () => context.push('/admin/users/${user.id}'),
                  tooltip: 'View Details',
                  color: PharmaColors.info,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                  iconSize: 18,
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => context.push('/admin/users/${user.id}/edit'),
                  tooltip: 'Edit User',
                  color: PharmaColors.textTertiary,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                  iconSize: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return PharmaColors.success;
      case 'inactive':
        return PharmaColors.textTertiary;
      case 'pending':
        return PharmaColors.warning;
      default:
        return PharmaColors.textSecondary;
    }
  }

  Widget _buildPagination(AsyncValue<int> userCountAsync) {
    return userCountAsync.when(
      data: (total) {
        final totalPages = (total / _perPage).ceil();
        if (totalPages <= 1) return const SizedBox.shrink();
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _currentPage > 1 
                  ? () => setState(() => _currentPage--) 
                  : null,
            ),
            Text('Page $_currentPage of $totalPages'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _currentPage < totalPages 
                  ? () => setState(() => _currentPage++) 
                  : null,
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildLoadingState() {
    return const AdminPageLoading(cardCount: 4);
  }

  Widget _buildErrorState(String error) {
    return AdminPageError(
      message: 'Failed to load users: $error',
      onRetry: () => ref.invalidate(adminUsersProvider),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE USER / IMPORT (canonical implementations under directory/)
// ═══════════════════════════════════════════════════════════════════════════════

class AdminUserCreateScreen extends StatelessWidget {
  const AdminUserCreateScreen({super.key});
  @override
  Widget build(BuildContext context) => const UserCreateScreen();
}

class AdminUserImportScreen extends StatelessWidget {
  const AdminUserImportScreen({super.key});
  @override
  Widget build(BuildContext context) => const UserBulkImportScreen();
}

// ═══════════════════════════════════════════════════════════════════════════════
// ORG HIERARCHY SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

Future<List<List<String>>> _orgHierarchyRows(WidgetRef ref) async {
  final user = await ref.read(currentUserProvider.future);
  if (user == null) return [];
  final sites = await client.organization.listSites(user.organizationId);
  final out = <List<String>>[];
  for (final s in sites) {
    final sid = s.id;
    if (sid == null) continue;
    final depts = await client.organization.listDepartments(sid);
    if (depts.isEmpty) {
      out.add([s.name, '—', '—']);
    } else {
      for (final d in depts) {
        out.add([s.name, d.name, '${d.id ?? ""}']);
      }
    }
  }
  return out;
}

class AdminOrgHierarchyScreen extends ConsumerWidget {
  const AdminOrgHierarchyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<List<String>>>(
      future: _orgHierarchyRows(ref),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const AdminPageFrame(
            title: 'Org Hierarchy',
            subtitle: 'Sites and departments',
            children: [
              SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
            ],
          );
        }
        final rows = snap.data ?? [];
        return AdminPageFrame(
          title: 'Org Hierarchy',
          subtitle: 'Sites and departments from organization endpoints.',
          children: [
            AdminSectionCard(
              title: 'Structure',
              child: rows.isEmpty
                  ? Text(
                      'No sites or departments found.',
                      style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                    )
                  : AdminDataTable(
                      columns: const ['Site', 'Department', 'Department ID'],
                      rows: rows,
                    ),
            ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACCESS REVIEW (canonical screen)
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAccessReviewScreen extends StatelessWidget {
  const AdminAccessReviewScreen({super.key});
  @override
  Widget build(BuildContext context) => const AccessReviewScreen();
}
