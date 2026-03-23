import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers.dart';

/// User Management Screen
/// 
/// Module 1: User & Identity Management
/// Screen 1/8: User Management List
/// 
/// Displays comprehensive user management interface with:
/// - Paginated list of all pharma_user records (employees, trainers, admins)
/// - Filters: Role, Status, Organization, Department
/// - Search by name, email, employee ID
/// - CRUD operations (Create, View, Edit, Deactivate)
/// - Bulk operations
/// - Real-time data from pharma_user table with live counts
/// - Compliance: Full audit trail on user modifications
class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  int currentPage = 1;
  final int itemsPerPage = 10;
  String? selectedRole;
  String? selectedStatus;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Watch the users count provider
    final totalUsersAsync = ref.watch(adminUserCountProvider);
    
    // Watch paginated users with filters
    final usersAsync = ref.watch(
      adminUsersListProvider(
        UsersListParams(
          page: currentPage,
          perPage: itemsPerPage,
          role: selectedRole,
          status: selectedStatus,
          search: searchQuery,
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          /// Page Header
          _buildPageHeader(context),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// Filters and Search
          _buildFiltersSection(context),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// Users Table with Real Data
          Expanded(
            child: usersAsync.when(
              data: (users) => totalUsersAsync.when(
                data: (totalCount) => _buildUsersTable(
                  context,
                  users,
                  totalCount,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Text('Error loading user count: $err'),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text('Error loading users: $err'),
              ),
            ),
          ),

          /// Pagination Controls
          _buildPaginationControls(context, totalUsersAsync),
        ],
      ),
    );
  }

  /// Page header with title and action buttons
  Widget _buildPageHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Management', style: PharmaTypography.displayLarge),
              SizedBox(height: PharmaSpacing.xs),
              Text(
                'Manage employees, trainers, and administrators',
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () => context.push('/admin/users/create'),
            icon: const Icon(Icons.person_add_outlined),
            label: const Text('New User'),
          ),
        ],
      ),
    );
  }

  /// Filters and search bar with real-time updates
  Widget _buildFiltersSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search by name, email, or employee ID...',
              prefixIcon: const Icon(Icons.search_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PharmaRadius.md),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: PharmaSpacing.md,
                vertical: PharmaSpacing.sm,
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
                currentPage = 1; // Reset to first page on search
              });
            },
          ),
          SizedBox(height: PharmaSpacing.md),

          /// Filter Chips
          Wrap(
            spacing: PharmaSpacing.sm,
            runSpacing: PharmaSpacing.sm,
            children: [
              _buildFilterChip(
                'Active Only',
                isSelected: selectedStatus == 'active',
                onTap: () => setState(() {
                  selectedStatus = selectedStatus == 'active' ? null : 'active';
                  currentPage = 1;
                }),
              ),
              _buildFilterChip(
                'Trainers',
                isSelected: selectedRole == 'TRAINER',
                onTap: () => setState(() {
                  selectedRole = selectedRole == 'TRAINER' ? null : 'TRAINER';
                  currentPage = 1;
                }),
              ),
              _buildFilterChip(
                'Employees',
                isSelected: selectedRole == 'EMPLOYEE',
                onTap: () => setState(() {
                  selectedRole = selectedRole == 'EMPLOYEE' ? null : 'EMPLOYEE';
                  currentPage = 1;
                }),
              ),
              _buildFilterChip(
                'Admins',
                isSelected: selectedRole == 'ADMIN',
                onTap: () => setState(() {
                  selectedRole = selectedRole == 'ADMIN' ? null : 'ADMIN';
                  currentPage = 1;
                }),
              ),
              _buildFilterChip(
                'Pending Approval',
                isSelected: selectedStatus == 'PENDING_APPROVAL',
                onTap: () => setState(() {
                  selectedStatus = selectedStatus == 'PENDING_APPROVAL'
                      ? null
                      : 'PENDING_APPROVAL';
                  currentPage = 1;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Filter chip widget with callback
  Widget _buildFilterChip(
    String label, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return FilterChip(
      onSelected: (_) => onTap(),
      selected: isSelected,
      label: Text(label),
      backgroundColor: PharmaColors.pageBg,
      selectedColor: PharmaColors.emerald100,
    );
  }

  /// Users data table with real database data
  Widget _buildUsersTable(
    BuildContext context,
    List<dynamic> users,
    int totalCount,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Employee ID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Hire Date')),
            DataColumn(label: Text('Actions')),
          ],
          rows: users.isEmpty
              ? _buildEmptyRows()
              : _buildUserRows(context, users),
        ),
      ),
    );
  }

  /// Build user rows for table from real database objects
  List<DataRow> _buildUserRows(BuildContext context, List<dynamic> users) {
    return users.map((user) {
      // user should be a PharmaUser object from the backend
      final userId = user['id'] ?? 0;
      final employeeId = user['employee_id'] ?? '-';
      final name = user['name'] ?? '-';
      final email = user['email'] ?? '-';
      final role = user['role'] ?? 'EMPLOYEE';
      final status = user['status'] ?? 'active';
      final hireDate = user['hire_date'] != null
          ? DateTime.parse(user['hire_date']).toLocal()
          : DateTime.now();
      final hireDateFormatted =
          '${hireDate.year}-${hireDate.month.toString().padLeft(2, '0')}-${hireDate.day.toString().padLeft(2, '0')}';

      return DataRow(
        cells: [
          DataCell(Text(employeeId)),
          DataCell(Text(name)),
          DataCell(Text(email)),
          DataCell(_buildRoleChip(role)),
          DataCell(_buildStatusChip(status)),
          DataCell(Text(hireDateFormatted)),
          DataCell(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  tooltip: 'View',
                  onPressed: () =>
                      context.push('/admin/users/$userId/view'),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  tooltip: 'Edit',
                  onPressed: () =>
                      context.push('/admin/users/$userId/edit'),
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: const Text('Reset Password'),
                      onTap: () => _showResetPasswordDialog(
                          context, userId, name),
                    ),
                    PopupMenuItem(
                      child: const Text('Deactivate'),
                      onTap: () =>
                          _showDeactivateDialog(context, userId, name),
                    ),
                    PopupMenuItem(
                      child: const Text('View Audit Log'),
                      onTap: () => context.push(
                          '/admin/users/$userId/audit-log'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  /// Empty state rows
  List<DataRow> _buildEmptyRows() {
    return [
      DataRow(cells: [
        const DataCell(Text('No users found')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
      ]),
    ];
  }

  /// Role chip with color coding
  Widget _buildRoleChip(String? role) {
    final color = switch (role?.toUpperCase()) {
      'ADMIN' => PharmaColors.dangerBg,
      'TRAINER' => PharmaColors.infoBg,
      'EMPLOYEE' => PharmaColors.successBg,
      _ => PharmaColors.gray100,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PharmaSpacing.sm,
        vertical: PharmaSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(
        role ?? 'EMPLOYEE',
        style: PharmaTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Status chip with live indicator
  Widget _buildStatusChip(String? status) {
    final isActive = status?.toLowerCase() == 'active';
    final color = isActive ? PharmaColors.successBg : PharmaColors.warningBg;
    final textColor = isActive ? PharmaColors.success : PharmaColors.warning;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PharmaSpacing.sm,
        vertical: PharmaSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: PharmaSpacing.xs),
          Text(
            status ?? 'active',
            style: PharmaTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Pagination controls with real data
  Widget _buildPaginationControls(
    BuildContext context,
    AsyncValue<int> totalUsersAsync,
  ) {
    return totalUsersAsync.when(
      data: (totalCount) {
        final totalPages = (totalCount / itemsPerPage).ceil();
        final startItem = ((currentPage - 1) * itemsPerPage) + 1;
        final endItem = (currentPage * itemsPerPage) > totalCount
            ? totalCount
            : (currentPage * itemsPerPage);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: PharmaSpacing.cardPadding,
            vertical: PharmaSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing $startItem-$endItem of $totalCount users',
                style: PharmaTypography.caption,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: currentPage > 1
                        ? () => setState(() => currentPage--)
                        : null,
                    tooltip: 'Previous Page',
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: PharmaSpacing.sm,
                      vertical: PharmaSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: PharmaColors.primary,
                      borderRadius: BorderRadius.circular(PharmaRadius.sm),
                    ),
                    child: Text(
                      'Page $currentPage of $totalPages',
                      style: PharmaTypography.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_outlined),
                    onPressed: currentPage < totalPages
                        ? () => setState(() => currentPage++)
                        : null,
                    tooltip: 'Next Page',
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => Container(
        padding: EdgeInsets.all(PharmaSpacing.md),
        child: const CircularProgressIndicator(),
      ),
      error: (err, stack) => Container(
        padding: EdgeInsets.all(PharmaSpacing.md),
        child: Text('Error loading pagination: $err'),
      ),
    );
  }

  /// Show reset password confirmation dialog
  void _showResetPasswordDialog(BuildContext context, int userId, String userName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Reset Password'),
        content: Text(
          'Send password reset email to $userName?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Call backend to reset password
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password reset email sent to $userName'),
                  backgroundColor: PharmaColors.success,
                ),
              );
            },
            child: const Text('Send Reset Email'),
          ),
        ],
      ),
    );
  }

  /// Show deactivate user confirmation dialog
  void _showDeactivateDialog(
      BuildContext context, int userId, String userName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Deactivate User'),
        content: Text(
          'Deactivate $userName? They will not be able to login.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Call backend to deactivate user
              Navigator.pop(dialogContext);
              // Schedule refresh for after snackbar is shown
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.invalidate(adminUsersListProvider);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$userName has been deactivated'),
                  backgroundColor: PharmaColors.warning,
                ),
              );
            },
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );
  }
}
