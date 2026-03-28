import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show JobRole;
import 'package:pharma_lms_flutter/providers/user_provider.dart';

/// User Create Screen
/// 
/// Module 1: User & Identity Management
/// Screen 2/8: Create New User
/// 
/// Allows admins to create new users with the following fields:
/// - Email (required, unique validation)
/// - First Name (required)
/// - Last Name (required)
/// - Employee ID (required, unique)
/// - Phone (optional)
/// - Department (required, dropdown)
/// - Organization (required, dropdown)
/// - Hire Date (required, date picker)
/// - Role (required, EMPLOYEE/TRAINER/ADMIN)
/// - Status (defaults to PENDING_APPROVAL)
/// 
/// On successful creation:
/// - Returns to user management list
/// - Shows success snackbar
/// - Refreshes user count and list
class UserCreateScreen extends ConsumerStatefulWidget {
  const UserCreateScreen({super.key});

  @override
  ConsumerState<UserCreateScreen> createState() => _UserCreateScreenState();
}

class _UserCreateScreenState extends ConsumerState<UserCreateScreen> {
  late final TextEditingController emailController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController employeeIdController;
  late final TextEditingController phoneController;
  
  int? selectedOrganizationId;
  int? selectedDepartmentId;
  int? selectedSiteId;
  int? selectedJobRoleId;
  DateTime? selectedHireDate;
  bool isLoading = false;
  bool _orgDefaultApplied = false;

  // Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    employeeIdController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    employeeIdController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _pickHireDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedHireDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix errors before submitting')),
      );
      return;
    }

    if (selectedOrganizationId == null ||
        selectedDepartmentId == null ||
        selectedSiteId == null ||
        selectedJobRoleId == null ||
        selectedHireDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final params = {
        'email': emailController.text.trim(),
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'employeeId': employeeIdController.text.trim(),
        'organizationId': selectedOrganizationId,
        'departmentId': selectedDepartmentId,
        'jobRoleId': selectedJobRoleId,
        'siteId': selectedSiteId,
      };
      await ref.read(adminCreateUserProvider(params).future);

      if (mounted) {
        ref.invalidate(adminUserCountProvider);
        ref.invalidate(adminUsersProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User ${firstNameController.text} created successfully',
            ),
            backgroundColor: PharmaColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating user: $e'),
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
    final orgsAsync = ref.watch(adminOrganizationsListProvider);
    final deptAsync = selectedOrganizationId != null
        ? ref.watch(adminDepartmentOptionsForOrgProvider(selectedOrganizationId!))
        : AsyncValue<List<AdminDepartmentOption>>.data(const []);
    final rolesAsync = selectedDepartmentId != null
        ? ref.watch(adminJobRolesForDepartmentProvider(selectedDepartmentId!))
        : AsyncValue<List<JobRole>>.data(<JobRole>[]);

    ref.listen(adminOrganizationsListProvider, (previous, next) {
      next.whenData((orgs) {
        if (_orgDefaultApplied || selectedOrganizationId != null) return;
        final me = ref.read(currentUserProvider).valueOrNull;
        final oid = me?.organizationId;
        if (oid == null) return;
        for (final o in orgs) {
          final id = o.id;
          if (id != null && id == oid) {
            _orgDefaultApplied = true;
            if (mounted) {
              setState(() => selectedOrganizationId = id);
            }
            return;
          }
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New User'),
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
              // Section 1: Basic Information
              _buildSectionTitle('Basic Information'),
              SizedBox(height: PharmaSpacing.md),

              // Email Field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email *',
                  hintText: 'user@pharmacompany.com',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
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

              // Employee ID & Phone Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: employeeIdController,
                      decoration: InputDecoration(
                        labelText: 'Employee ID *',
                        hintText: 'EMP12345',
                        prefixIcon: const Icon(Icons.badge),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Employee ID is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: PharmaSpacing.md),
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone (Optional)',
                        hintText: '+1 (555) 123-4567',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
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
                      selectedJobRoleId = null;
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
                      selectedJobRoleId = null;
                      selectedSiteId = match?.siteId;
                    });
                  },
                  validator: (value) => value == null ? 'Department is required' : null,
                ),
              ),
              SizedBox(height: PharmaSpacing.lg),

              // Section 3: Job role & Dates
              _buildSectionTitle('Job role & employment'),
              SizedBox(height: PharmaSpacing.md),

              rolesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(8),
                  child: LinearProgressIndicator(),
                ),
                error: (e, _) => Text('Job roles: $e'),
                data: (roles) => DropdownButtonFormField<int>(
                  initialValue: selectedJobRoleId,
                  decoration: InputDecoration(
                    labelText: 'Job role *',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                    ),
                  ),
                  items: roles
                      .where((r) => r.id != null)
                      .map(
                        (r) => DropdownMenuItem(
                          value: r.id,
                          child: Text(r.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => selectedJobRoleId = value),
                  validator: (value) => value == null ? 'Job role is required' : null,
                ),
              ),
              SizedBox(height: PharmaSpacing.md),

              // Hire Date Picker
              InkWell(
                onTap: _pickHireDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Hire Date *',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                    ),
                    errorText: selectedHireDate == null ? 'Please select a date' : null,
                  ),
                  child: Text(
                    selectedHireDate != null
                        ? _formatDate(selectedHireDate!)
                        : 'Select date...',
                    style: selectedHireDate != null
                        ? PharmaTypography.bodyMedium
                        : PharmaTypography.bodyMedium.copyWith(
                            color: PharmaColors.textSecondary,
                          ),
                  ),
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
                          : const Text('Create User'),
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
    return Padding(
      padding: EdgeInsets.only(top: PharmaSpacing.md),
      child: Text(
        title,
        style: PharmaTypography.headingMedium.copyWith(
          color: PharmaColors.primary,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
