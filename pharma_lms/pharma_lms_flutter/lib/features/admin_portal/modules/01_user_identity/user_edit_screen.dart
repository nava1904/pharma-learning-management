import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers.dart';

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
  
  String? selectedDepartment;
  String? selectedOrganization;
  bool isLoading = true;
  String? errorMessage;

  // Form validation
  final _formKey = GlobalKey<FormState>();

  // Mock data for dropdowns
  final departments = [
    'Sales',
    'Marketing',
    'Operations',
    'HR',
    'Finance',
    'IT',
    'Training',
    'R&D',
    'Quality Assurance',
    'Customer Support',
  ];

  final organizations = [
    'HQ',
    'Training Center',
    'Regional Office - North',
    'Regional Office - South',
    'Regional Office - East',
    'Regional Office - West',
  ];

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
      // TODO: Fetch user data from backend
      // final user = await ref.read(adminUserDetailProvider(widget.userId).future);
      
      // TEMPORARY: Mock user data
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (mounted) {
        setState(() {
          firstNameController.text = 'John';
          lastNameController.text = 'Trainer';
          emailController.text = 'john.trainer@pharmatest.com';
          employeeIdController.text = 'EMP002';
          phoneController.text = '+1 (555) 234-5678';
          selectedDepartment = 'Training';
          selectedOrganization = 'Training Center';
          isLoading = false;
        });
      }
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

    if (selectedDepartment == null || selectedOrganization == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // TODO: Call backend endpoint
      // final result = await ref.read(updateUserProvider.notifier).updateUser(
      //   widget.userId,
      //   firstName: firstNameController.text,
      //   lastName: lastNameController.text,
      //   phone: phoneController.text,
      //   department: selectedDepartment!,
      // );

      // TEMPORARY: Simulate success
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        // Invalidate providers to refresh data
        ref.invalidate(adminUserDetailProvider(widget.userId));
        ref.invalidate(adminUsersListProvider);

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

              // Organization Dropdown (Read-only)
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Organization (Read-only)',
                  prefixIcon: const Icon(Icons.business),
                  filled: true,
                  fillColor: PharmaColors.gray100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  ),
                ),
                child: Text(
                  selectedOrganization ?? 'N/A',
                  style: PharmaTypography.bodyMedium,
                ),
              ),
              SizedBox(height: PharmaSpacing.md),

              // Department Dropdown
              DropdownButtonFormField<String>(
                initialValue: selectedDepartment,
                decoration: InputDecoration(
                  labelText: 'Department *',
                  prefixIcon: const Icon(Icons.domain),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  ),
                ),
                items: departments
                    .map((dept) => DropdownMenuItem(
                          value: dept,
                          child: Text(dept),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedDepartment = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Department is required';
                  }
                  return null;
                },
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
