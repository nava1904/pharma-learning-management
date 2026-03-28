import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';

/// User Edit Screen
/// 
/// Module 1: User & Identity Management
/// Screen 3/8: Edit User
/// 
/// Allows admins to edit existing user information:
/// - First Name
/// - Last Name
/// - Phone
/// - Department
/// - Email (read-only, unique constraint)
/// - Employee ID (read-only, unique constraint)
/// - Organization (read-only after creation)
/// 
/// Fields marked as read-only cannot be changed due to system constraints.
/// To change email/employee ID, user must be recreated.
/// 
/// On successful update:
/// - Returns to user management list
/// - Shows success snackbar
/// - Refreshes user data
class UserEditScreen extends ConsumerStatefulWidget {
  final int userId;

  const UserEditScreen({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends ConsumerState<UserEditScreen> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController employeeIdController;
  late final TextEditingController phoneController;
  
  int? selectedOrganizationId;
  int? selectedDepartmentId;
  int? selectedSiteId;
  bool isLoading = true;
  String? errorMessage;

  // Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    employeeIdController = TextEditingController();
    phoneController = TextEditingController();
    
    // Load user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    employeeIdController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await ref.read(adminUserDetailProvider(widget.userId).future);
      if (!mounted) return;
      if (user == null) {
        setState(() {
          errorMessage = 'User not found';
          isLoading = false;
        });
        return;
      }
      final opts = await ref.read(
        adminDepartmentOptionsForOrgProvider(user.organizationId).future,
      );
      AdminDepartmentOption? match;
      for (final d in opts) {
        if (d.departmentId == user.departmentId) match = d;
      }
      setState(() {
        firstNameController.text = user.firstName;
        lastNameController.text = user.lastName;
        emailController.text = user.email;
        employeeIdController.text = user.employeeId ?? '';
        phoneController.clear();
        selectedOrganizationId = user.organizationId;
        selectedDepartmentId = user.departmentId;
        selectedSiteId = match?.siteId;
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to load user: $e';
          isLoading = false;
        });
      }
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix errors before submitting')),
      );
      return;
    }

    if (selectedOrganizationId == null || selectedDepartmentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final updated = await ref.read(adminUpdateUserProvider({
        'userId': widget.userId,
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'organizationId': selectedOrganizationId,
        'departmentId': selectedDepartmentId,
      }).future);

      if (updated == null) throw Exception('Update rejected');

      if (mounted) {
        ref.invalidate(adminUserDetailProvider(widget.userId));
        ref.invalidate(adminUsersProvider);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User ${firstNameController.text} updated successfully',
            ),
            backgroundColor: PharmaColors.success,
          ),
        );

        // Navigate back to user management
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating user: $e'),
            backgroundColor: PharmaColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
          elevation: 0,
          backgroundColor: PharmaColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
          elevation: 0,
          backgroundColor: PharmaColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Text(errorMessage!),
        ),
      );
    }

    final orgsAsync = ref.watch(adminOrganizationsListProvider);
    final deptAsync = selectedOrganizationId != null
        ? ref.watch(adminDepartmentOptionsForOrgProvider(selectedOrganizationId!))
        : AsyncValue<List<AdminDepartmentOption>>.data(const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        elevation: 0,
        backgroundColor: PharmaColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              Container(
                padding: EdgeInsets.all(PharmaSpacing.md),
                decoration: BoxDecoration(
                  color: PharmaColors.infoBg,
                  borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  border: Border.all(color: PharmaColors.info),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: PharmaColors.info),
                    SizedBox(width: PharmaSpacing.md),
                    Expanded(
                      child: Text(
                        'Email and Employee ID cannot be changed. To change these, recreate the user.',
                        style: PharmaTypography.caption.copyWith(
                          color: PharmaColors.infoText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: PharmaSpacing.lg),

              // Section 1: Basic Information
              _buildSectionTitle('Basic Information'),
              SizedBox(height: PharmaSpacing.md),

              // Email Field (Read-only)
              TextFormField(
                controller: emailController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Email (Read-only)',
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: PharmaColors.gray100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  ),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),

              // Employee ID (Read-only)
              TextFormField(
                controller: employeeIdController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Employee ID (Read-only)',
                  prefixIcon: const Icon(Icons.badge),
                  filled: true,
                  fillColor: PharmaColors.gray100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  ),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),

              // First & Last Name Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name *',
                        hintText: 'John',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name *',
                        hintText: 'Doe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: PharmaSpacing.md),

              // Phone Field
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: '+1 (555) 123-4567',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: PharmaSpacing.lg),

              // Section 2: Organization & Department
              _buildSectionTitle('Organization & Department'),
              SizedBox(height: PharmaSpacing.md),

              orgsAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Organizations: $e'),
                data: (orgs) => DropdownButtonFormField<int>(
                  initialValue: selectedOrganizationId,
                  decoration: InputDecoration(
                    labelText: 'Organization *',
                    prefixIcon: const Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                    ),
                  ),
                  items: orgs
                      .where((o) => o.id != null)
                      .map(
                        (o) => DropdownMenuItem(
                          value: o.id,
                          child: Text(o.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedOrganizationId = value;
                      selectedDepartmentId = null;
                      selectedSiteId = null;
                    });
                  },
                  validator: (value) => value == null ? 'Organization is required' : null,
                ),
              ),
              SizedBox(height: PharmaSpacing.md),

              deptAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(8),
                  child: LinearProgressIndicator(),
                ),
                error: (e, _) => Text('Departments: $e'),
                data: (opts) => DropdownButtonFormField<int>(
                  initialValue: selectedDepartmentId,
                  decoration: InputDecoration(
                    labelText: 'Department *',
                    prefixIcon: const Icon(Icons.domain),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                    ),
                  ),
                  items: opts
                      .map(
                        (d) => DropdownMenuItem(
                          value: d.departmentId,
                          child: Text(d.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    AdminDepartmentOption? match;
                    if (value != null) {
                      for (final d in opts) {
                        if (d.departmentId == value) match = d;
                      }
                    }
                    setState(() {
                      selectedDepartmentId = value;
                      selectedSiteId = match?.siteId;
                    });
                  },
                  validator: (value) => value == null ? 'Department is required' : null,
                ),
              ),
              SizedBox(height: PharmaSpacing.lg),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PharmaColors.background,
                      foregroundColor: PharmaColors.textPrimary,
                      side: BorderSide(color: PharmaColors.border),
                    ),
                    onPressed: isLoading ? null : () => context.pop(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PharmaColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isLoading ? null : _submitForm,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Update User'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: PharmaTypography.headingMedium.copyWith(
        color: PharmaColors.primary,
      ),
    );
  }
}
