import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' as protocol;

import '../../core/client.dart';
import '../../widgets/app_shell.dart';

/// ADM-WF-07: Add a single employee/trainer/admin user (create account + role).
class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final _employeeIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();

  String _roleCode = 'trainer';

  bool _loadingOrgs = true;
  bool _submitting = false;
  int _assignedById = 1;

  List<protocol.Organization> _orgs = [];
  List<protocol.Site> _sites = [];
  List<protocol.Department> _departments = [];
  List<protocol.JobRole> _jobRoles = [];

  protocol.Organization? _selectedOrg;
  protocol.Site? _selectedSite;
  protocol.Department? _selectedDept;
  protocol.JobRole? _selectedJobRole;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _employeeIdCtrl.dispose();
    _emailCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      final orgs = await client.organization.listOrganizations();
      if (!mounted) return;
      setState(() {
        _orgs = orgs;
        _selectedOrg = orgs.firstOrNull;
      });

      if (_selectedOrg?.id != null) {
        await _loadSites(_selectedOrg!.id!);
      }
    } catch (_) {
      // Leave lists empty; UI shows error/empty states.
    } finally {
      await _loadAssignedBy();
      if (mounted) setState(() => _loadingOrgs = false);
    }
  }

  Future<void> _loadAssignedBy() async {
    try {
      final user = await client.user.getUserByEmail('admin@pharmacorp.demo');
      if (!mounted) return;
      if (user?.id != null) {
        setState(() => _assignedById = user!.id!);
      }
    } catch (_) {}
  }

  Future<void> _loadSites(int organizationId) async {
    final sites = await client.organization.listSites(organizationId);
    if (!mounted) return;
    setState(() {
      _sites = sites;
      _selectedSite = sites.firstOrNull;
      _departments = [];
      _jobRoles = [];
      _selectedDept = null;
      _selectedJobRole = null;
    });

    if (_selectedSite?.id != null) {
      await _loadDepartments(_selectedSite!.id!);
    }
  }

  Future<void> _loadDepartments(int siteId) async {
    final departments = await client.organization.listDepartments(siteId);
    if (!mounted) return;
    setState(() {
      _departments = departments;
      _selectedDept = departments.firstOrNull;
      _jobRoles = [];
      _selectedJobRole = null;
    });

    if (_selectedDept?.id != null) {
      await _loadJobRoles(_selectedDept!.id!);
    }
  }

  Future<void> _loadJobRoles(int departmentId) async {
    final jobRoles = await client.organization.listJobRoles(departmentId);
    if (!mounted) return;
    setState(() {
      _jobRoles = jobRoles;
      _selectedJobRole = jobRoles.firstOrNull;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedOrg?.id == null ||
        _selectedSite?.id == null ||
        _selectedDept?.id == null ||
        _selectedJobRole?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select organization/site/department/job role.')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await client.admin.createUserWithRole(
        employeeId: _employeeIdCtrl.text.trim(),
        email: _emailCtrl.text.trim().toLowerCase(),
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        departmentId: _selectedDept!.id!,
        siteId: _selectedSite!.id!,
        organizationId: _selectedOrg!.id!,
        jobRoleId: _selectedJobRole!.id!,
        roleCode: _roleCode,
        assignedById: _assignedById,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User created successfully.')),
      );
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Create user failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleOptions = const <String>[
      'trainer',
      'employee',
      'admin',
      'qa_manager',
      'qa_director',
      'auditor',
      'sme',
    ];

    return AppShell(
      title: 'Add Single User',
      icon: Icons.person_add_rounded,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _loadingOrgs
                    ? const SizedBox(
                        height: 120,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'ADM-WF-07 • Create account and assign role',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _employeeIdCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Employee ID',
                                hintText: 'Required',
                              ),
                              textCapitalization: TextCapitalization.none,
                              validator: (v) {
                                final value = v?.trim() ?? '';
                                if (value.isEmpty) return 'Employee ID is required';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            TextFormField(
                              controller: _emailCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Required',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                final value = v?.trim() ?? '';
                                if (value.isEmpty) return 'Email is required';
                                final emailRegex =
                                    RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Invalid email format';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _firstNameCtrl,
                                    decoration: const InputDecoration(
                                      labelText: 'First name',
                                      hintText: 'Required',
                                    ),
                                    validator: (v) {
                                      if ((v ?? '').trim().isEmpty) {
                                        return 'First name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lastNameCtrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Last name',
                                      hintText: 'Required',
                                    ),
                                    validator: (v) {
                                      if ((v ?? '').trim().isEmpty) {
                                        return 'Last name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            DropdownButtonFormField<protocol.Organization>(
                              initialValue: _selectedOrg,
                              decoration: const InputDecoration(
                                labelText: 'Organization',
                              ),
                              items: _orgs
                                  .map(
                                    (o) => DropdownMenuItem(
                                      value: o,
                                      child: Text(o.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) async {
                                if (v?.id == null) return;
                                setState(() => _selectedOrg = v);
                                await _loadSites(v!.id!);
                              },
                            ),
                            const SizedBox(height: 12),

                            DropdownButtonFormField<protocol.Site>(
                              initialValue: _selectedSite,
                              decoration: const InputDecoration(
                                labelText: 'Site',
                              ),
                              items: _sites
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) async {
                                if (v?.id == null) return;
                                setState(() => _selectedSite = v);
                                await _loadDepartments(v!.id!);
                              },
                            ),
                            const SizedBox(height: 12),

                            DropdownButtonFormField<protocol.Department>(
                              initialValue: _selectedDept,
                              decoration: const InputDecoration(
                                labelText: 'Department',
                              ),
                              items: _departments
                                  .map(
                                    (d) => DropdownMenuItem(
                                      value: d,
                                      child: Text(d.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) async {
                                if (v?.id == null) return;
                                setState(() => _selectedDept = v);
                                await _loadJobRoles(v!.id!);
                              },
                            ),
                            const SizedBox(height: 12),

                            DropdownButtonFormField<protocol.JobRole>(
                              initialValue: _selectedJobRole,
                              decoration: const InputDecoration(
                                labelText: 'Job role (training matrix)',
                              ),
                              items: _jobRoles
                                  .map(
                                    (jr) => DropdownMenuItem(
                                      value: jr,
                                      child: Text(jr.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                setState(() => _selectedJobRole = v);
                              },
                            ),
                            const SizedBox(height: 12),

                            DropdownButtonFormField<String>(
                              initialValue: _roleCode,
                              decoration: const InputDecoration(
                                labelText: 'Portal role',
                              ),
                              items: roleOptions
                                  .map(
                                    (r) => DropdownMenuItem(
                                      value: r,
                                      child: Text(r),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                if (v == null) return;
                                setState(() => _roleCode = v);
                              },
                            ),

                            const SizedBox(height: 18),

                            Align(
                              alignment: Alignment.centerRight,
                              child: FilledButton(
                                onPressed: _submitting ? null : _submit,
                                child: _submitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Create User'),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

