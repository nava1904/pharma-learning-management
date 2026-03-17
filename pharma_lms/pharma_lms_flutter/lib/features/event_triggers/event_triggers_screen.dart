import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// Manual event triggers for workflow testing (SYS-WF-01, 02, 03, 06).
/// AWS EventBridge-inspired UI for testing domain automation events.
class EventTriggersScreen extends StatefulWidget {
  const EventTriggersScreen({super.key});

  @override
  State<EventTriggersScreen> createState() => _EventTriggersScreenState();
}

class _EventTriggersScreenState extends State<EventTriggersScreen> {
  // SOP Updated (SYS-WF-01)
  final _sopDocIdController = TextEditingController();
  final _sopCourseVersionIdController = TextEditingController();
  final _sopReasonController = TextEditingController(text: 'SOP update - manual trigger');

  // Employee Created (SYS-WF-02)
  final _empUserIdController = TextEditingController();
  final _empDepartmentIdController = TextEditingController();
  final _empRoleIdController = TextEditingController();

  // Employee Transfer (SYS-WF-03)
  final _transferUserIdController = TextEditingController();
  final _transferOldRoleIdController = TextEditingController();
  final _transferNewRoleIdController = TextEditingController();
  final _transferOldDeptIdController = TextEditingController();
  final _transferNewDeptIdController = TextEditingController();

  // CAPA Training Complete (SYS-WF-06)
  final _capaIdController = TextEditingController();

  // Compliance Drop Alert (SYS-WF-08b)
  final _complianceThresholdController = TextEditingController(text: '90');

  // New Course Release (SYS-WF-09)
  final _courseVersionIdController = TextEditingController();

  // Loading states
  bool _sopLoading = false;
  bool _empLoading = false;
  bool _transferLoading = false;
  bool _capaLoading = false;
  bool _complianceAlertLoading = false;
  bool _courseReleaseLoading = false;

  @override
  void dispose() {
    _sopDocIdController.dispose();
    _sopCourseVersionIdController.dispose();
    _sopReasonController.dispose();
    _empUserIdController.dispose();
    _empDepartmentIdController.dispose();
    _empRoleIdController.dispose();
    _transferUserIdController.dispose();
    _transferOldRoleIdController.dispose();
    _transferNewRoleIdController.dispose();
    _transferOldDeptIdController.dispose();
    _transferNewDeptIdController.dispose();
    _capaIdController.dispose();
    _complianceThresholdController.dispose();
    _courseVersionIdController.dispose();
    super.dispose();
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.destructive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _triggerSopUpdated() async {
    final docId = _sopDocIdController.text.trim();
    final cvId = _sopCourseVersionIdController.text.trim();
    if (docId.isEmpty || cvId.isEmpty) {
      _showErrorSnackBar('Document ID and Course Version ID are required');
      return;
    }
    setState(() => _sopLoading = true);
    try {
      await client.event.triggerSopUpdated(
        documentId: docId,
        courseVersionId: cvId,
        reason: _sopReasonController.text.trim().isEmpty
            ? 'SOP update - manual trigger'
            : _sopReasonController.text.trim(),
      );
      _showSuccessSnackBar('SYS-WF-01: SOP Updated event triggered successfully');
    } catch (e) {
      _showErrorSnackBar('Failed: $e');
    } finally {
      if (mounted) setState(() => _sopLoading = false);
    }
  }

  Future<void> _triggerEmployeeCreated() async {
    final userId = _empUserIdController.text.trim();
    final deptId = _empDepartmentIdController.text.trim();
    final roleId = _empRoleIdController.text.trim();
    if (userId.isEmpty || deptId.isEmpty || roleId.isEmpty) {
      _showErrorSnackBar('User ID, Department ID, and Role ID are required');
      return;
    }
    setState(() => _empLoading = true);
    try {
      await client.event.triggerEmployeeCreated(
        userId: userId,
        departmentId: deptId,
        roleId: roleId,
      );
      _showSuccessSnackBar('SYS-WF-02: Employee Created event triggered successfully');
    } catch (e) {
      _showErrorSnackBar('Failed: $e');
    } finally {
      if (mounted) setState(() => _empLoading = false);
    }
  }

  Future<void> _triggerEmployeeTransferred() async {
    final userId = _transferUserIdController.text.trim();
    final oldRoleId = _transferOldRoleIdController.text.trim();
    final newRoleId = _transferNewRoleIdController.text.trim();
    final oldDeptId = _transferOldDeptIdController.text.trim();
    final newDeptId = _transferNewDeptIdController.text.trim();

    if (userId.isEmpty || oldRoleId.isEmpty || newRoleId.isEmpty) {
      _showErrorSnackBar('User ID, Old Role ID, and New Role ID are required');
      return;
    }
    setState(() => _transferLoading = true);
    try {
      await client.event.triggerEmployeeTransferred(
        userId: userId,
        oldRoleId: oldRoleId,
        newRoleId: newRoleId,
        oldDepartmentId: oldDeptId.isNotEmpty ? oldDeptId : '0',
        newDepartmentId: newDeptId.isNotEmpty ? newDeptId : '0',
      );
      _showSuccessSnackBar('SYS-WF-03: Employee Transferred event triggered successfully');
    } catch (e) {
      _showErrorSnackBar('Failed: $e');
    } finally {
      if (mounted) setState(() => _transferLoading = false);
    }
  }

  Future<void> _triggerCapaTrainingComplete() async {
    final capaId = _capaIdController.text.trim();
    if (capaId.isEmpty) {
      _showErrorSnackBar('CAPA ID is required');
      return;
    }
    final capaIdInt = int.tryParse(capaId);
    if (capaIdInt == null) {
      _showErrorSnackBar('CAPA ID must be a valid number');
      return;
    }
    setState(() => _capaLoading = true);
    try {
      final result = await client.event.triggerCapaTrainingComplete(
        capaId: capaIdInt,
      );
      if (result['success'] == true) {
        _showSuccessSnackBar('SYS-WF-06: CAPA Training Complete triggered successfully');
      } else {
        _showErrorSnackBar('Failed: ${result['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _showErrorSnackBar('Failed: $e');
    } finally {
      if (mounted) setState(() => _capaLoading = false);
    }
  }

  Future<void> _triggerComplianceDropAlert() async {
    final thresholdStr = _complianceThresholdController.text.trim();
    final threshold = double.tryParse(thresholdStr);
    if (threshold == null || threshold < 0 || threshold > 100) {
      _showErrorSnackBar('Threshold must be a number between 0 and 100');
      return;
    }
    setState(() => _complianceAlertLoading = true);
    try {
      final result = await client.event.triggerComplianceDropAlert(
        threshold: threshold / 100,
      );
      if (result['success'] == true) {
        final alertCount = result['alertCount'] ?? 0;
        _showSuccessSnackBar(
          'SYS-WF-08b: Compliance Drop Alert completed - $alertCount department(s) below threshold',
        );
      } else {
        _showErrorSnackBar('Failed: ${result['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _showErrorSnackBar('Failed: $e');
    } finally {
      if (mounted) setState(() => _complianceAlertLoading = false);
    }
  }

  Future<void> _triggerNewCourseRelease() async {
    final cvIdStr = _courseVersionIdController.text.trim();
    if (cvIdStr.isEmpty) {
      _showErrorSnackBar('Course Version ID is required');
      return;
    }
    final cvId = int.tryParse(cvIdStr);
    if (cvId == null) {
      _showErrorSnackBar('Course Version ID must be a valid number');
      return;
    }
    setState(() => _courseReleaseLoading = true);
    try {
      final result = await client.event.triggerNewCourseRelease(
        courseVersionId: cvId,
      );
      if (result['success'] == true) {
        final assignCount = result['assignmentsCreated'] ?? 0;
        _showSuccessSnackBar(
          'SYS-WF-09: New Course Release completed - $assignCount assignment(s) created',
        );
      } else {
        _showErrorSnackBar('Failed: ${result['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _showErrorSnackBar('Failed: $e');
    } finally {
      if (mounted) setState(() => _courseReleaseLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AWS-inspired dark header
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppColors.slate900,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  context.canPop() ? context.pop() : context.go('/admin'),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.slate900,
                      AppColors.slate800,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(56, 16, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.indigo600.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.bolt,
                                color: AppColors.indigo200,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Event Triggers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Domain Automation Testing Console',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.slate400,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Body content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.slate100, AppColors.slate50],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.indigo50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.indigo200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.indigo600),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Manual workflow testing without Kafka. Triggers domain events directly.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.indigo700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Event cards grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = constraints.maxWidth > 1200
                            ? 3
                            : constraints.maxWidth > 700
                                ? 2
                                : 1;
                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: crossAxisCount == 3 
                              ? 0.9 
                              : crossAxisCount == 2 
                                  ? 1.0 
                                  : 1.6,
                          children: [
                            _buildSopUpdatedCard(),
                            _buildEmployeeCreatedCard(),
                            _buildEmployeeTransferCard(),
                            _buildCapaTrainingCompleteCard(),
                            _buildComplianceDropAlertCard(),
                            _buildNewCourseReleaseCard(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String workflowId,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required List<Widget> fields,
    required String buttonLabel,
    required bool loading,
    required VoidCallback onTrigger,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate300.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: iconColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              workflowId,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.slate600,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Fields
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: fields
                      .map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: f,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          // Action button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: loading ? null : onTrigger,
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Icon(Icons.send, size: 18),
                label: Text(buttonLabel),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactTextField(TextEditingController controller, String label,
      {String? hint}) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.slate300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.slate300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.indigo600, width: 2),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildSopUpdatedCard() {
    return _buildEventCard(
      workflowId: 'SYS-WF-01',
      title: 'Trigger SOP Updated',
      description:
          'Initiates retraining workflow when an SOP document is updated. Creates assignments for affected users.',
      icon: Icons.description_outlined,
      iconColor: AppColors.indigo600,
      bgColor: AppColors.indigo50,
      loading: _sopLoading,
      buttonLabel: 'Trigger Event',
      onTrigger: _triggerSopUpdated,
      fields: [
        _buildCompactTextField(_sopDocIdController, 'Document ID', hint: 'e.g. 1'),
        _buildCompactTextField(_sopCourseVersionIdController, 'Course Version ID',
            hint: 'e.g. 1'),
        _buildCompactTextField(_sopReasonController, 'Reason'),
      ],
    );
  }

  Widget _buildEmployeeCreatedCard() {
    return _buildEventCard(
      workflowId: 'SYS-WF-02',
      title: 'Trigger Employee Created',
      description:
          'Assigns role-based onboarding training when a new employee joins the organization.',
      icon: Icons.person_add_outlined,
      iconColor: AppColors.teal600,
      bgColor: AppColors.teal50,
      loading: _empLoading,
      buttonLabel: 'Trigger Event',
      onTrigger: _triggerEmployeeCreated,
      fields: [
        _buildCompactTextField(_empUserIdController, 'User ID', hint: 'e.g. 1'),
        _buildCompactTextField(_empDepartmentIdController, 'Department ID',
            hint: 'e.g. 1'),
        _buildCompactTextField(_empRoleIdController, 'Role ID', hint: 'e.g. 1'),
      ],
    );
  }

  Widget _buildEmployeeTransferCard() {
    return _buildEventCard(
      workflowId: 'SYS-WF-03',
      title: 'Trigger Employee Transfer',
      description:
          'Archives old role assignments and creates delta training for new role requirements.',
      icon: Icons.swap_horiz_outlined,
      iconColor: AppColors.amber600,
      bgColor: const Color(0xFFFFF8E1),
      loading: _transferLoading,
      buttonLabel: 'Trigger Event',
      onTrigger: _triggerEmployeeTransferred,
      fields: [
        _buildCompactTextField(_transferUserIdController, 'User ID',
            hint: 'e.g. 1'),
        Row(
          children: [
            Expanded(
              child: _buildCompactTextField(
                  _transferOldRoleIdController, 'Old Role ID',
                  hint: 'e.g. 1'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCompactTextField(
                  _transferNewRoleIdController, 'New Role ID',
                  hint: 'e.g. 2'),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildCompactTextField(
                  _transferOldDeptIdController, 'Old Dept (opt)'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCompactTextField(
                  _transferNewDeptIdController, 'New Dept (opt)'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCapaTrainingCompleteCard() {
    return _buildEventCard(
      workflowId: 'SYS-WF-06',
      title: 'Trigger CAPA Training Complete',
      description:
          'Sets effectiveness check due date (90 days) and updates CAPA status after training completion.',
      icon: Icons.verified_outlined,
      iconColor: AppColors.destructive,
      bgColor: const Color(0xFFFEF2F2),
      loading: _capaLoading,
      buttonLabel: 'Trigger Event',
      onTrigger: _triggerCapaTrainingComplete,
      fields: [
        _buildCompactTextField(_capaIdController, 'CAPA ID', hint: 'e.g. 1'),
      ],
    );
  }

  Widget _buildComplianceDropAlertCard() {
    return _buildEventCard(
      workflowId: 'SYS-WF-08b',
      title: 'Compliance Drop Alert',
      description:
          'Checks departments below compliance threshold and notifies QA team for immediate action.',
      icon: Icons.trending_down,
      iconColor: AppColors.amber600,
      bgColor: const Color(0xFFFFFBEB),
      loading: _complianceAlertLoading,
      buttonLabel: 'Check Compliance',
      onTrigger: _triggerComplianceDropAlert,
      fields: [
        _buildCompactTextField(
          _complianceThresholdController, 
          'Threshold (%)', 
          hint: 'e.g. 90',
        ),
      ],
    );
  }

  Widget _buildNewCourseReleaseCard() {
    return _buildEventCard(
      workflowId: 'SYS-WF-09',
      title: 'New Course Release',
      description:
          'Assigns newly published course to all users based on training matrix job role mappings.',
      icon: Icons.school,
      iconColor: AppColors.teal600,
      bgColor: AppColors.teal50,
      loading: _courseReleaseLoading,
      buttonLabel: 'Release Course',
      onTrigger: _triggerNewCourseRelease,
      fields: [
        _buildCompactTextField(
          _courseVersionIdController, 
          'Course Version ID', 
          hint: 'e.g. 1',
        ),
      ],
    );
  }
}
