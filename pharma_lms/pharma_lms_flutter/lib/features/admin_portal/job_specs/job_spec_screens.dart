import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show JobRole;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// JOB SPEC LIST SCREEN - Real data from backend
// ═══════════════════════════════════════════════════════════════════════════════

class AdminJobSpecListScreen extends ConsumerStatefulWidget {
  const AdminJobSpecListScreen({super.key});

  @override
  ConsumerState<AdminJobSpecListScreen> createState() => _AdminJobSpecListScreenState();
}

class _AdminJobSpecListScreenState extends ConsumerState<AdminJobSpecListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final jobRolesAsync = ref.watch(adminJobRolesProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(context),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Filters Row
          _buildFiltersRow(),
          SizedBox(height: PharmaSpacing.md),

          // Job Specs Grid
          jobRolesAsync.when(
            data: (roles) => _buildJobSpecsGrid(roles),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Job Specifications', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Role competency and mandatory curriculum mapping',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => _showCreateJobSpecDialog(context),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Job Spec'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search job roles...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.sm),
              ),
            ),
          ),
          SizedBox(width: PharmaSpacing.md),
          // Info about filtering
          Container(
            padding: EdgeInsets.all(PharmaSpacing.sm),
            decoration: BoxDecoration(
              color: PharmaColors.infoBg,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 16, color: PharmaColors.info),
                SizedBox(width: PharmaSpacing.xs),
                Text(
                  'Showing roles from default department',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.info),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobSpecsGrid(List<JobRole> roles) {
    final filteredRoles = roles.where((r) =>
      _searchQuery.isEmpty || r.name.toLowerCase().contains(_searchQuery)
    ).toList();

    if (filteredRoles.isEmpty) {
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
              Icon(Icons.work_outline, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No job specifications found',
                style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textTertiary),
              ),
              SizedBox(height: PharmaSpacing.md),
              ElevatedButton.icon(
                onPressed: () => _showCreateJobSpecDialog(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create First Job Spec'),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredRoles.length,
      itemBuilder: (context, index) => _buildJobSpecCard(filteredRoles[index]),
    );
  }

  Widget _buildJobSpecCard(JobRole role) {
    // Simulate competency data - in production would come from backend
    final requiredCourses = (role.id ?? 1) * 2 + 3;
    final complianceRate = 70 + ((role.id ?? 1) * 5 % 25);

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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PharmaColors.emerald50,
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                child: Icon(Icons.badge_outlined, color: PharmaColors.emerald600, size: 20),
              ),
              SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Text(
                  role.name,
                  style: PharmaTypography.headingSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 18),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          // Required Courses
          Row(
            children: [
              Icon(Icons.school, size: 16, color: PharmaColors.textTertiary),
              SizedBox(width: PharmaSpacing.xs),
              Text('$requiredCourses required courses', style: PharmaTypography.caption),
            ],
          ),
          SizedBox(height: PharmaSpacing.sm),
          // Compliance Rate Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Compliance', style: PharmaTypography.caption),
                  Text(
                    '$complianceRate%',
                    style: PharmaTypography.caption.copyWith(
                      color: complianceRate >= 80 ? PharmaColors.success : PharmaColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: PharmaSpacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: complianceRate / 100,
                  backgroundColor: PharmaColors.gray200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    complianceRate >= 80 ? PharmaColors.success : PharmaColors.warning,
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateJobSpecDialog(BuildContext context) {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Job Specification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Job Title',
                hintText: 'e.g., Quality Assurance Analyst',
              ),
            ),
            SizedBox(height: PharmaSpacing.md),
            const Text(
              'After creating, you can map required courses and competencies.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Creating job spec: ${nameController.text}')),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Failed to load job specifications', style: PharmaTypography.bodyMedium),
            Text(error, style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton(
              onPressed: () => ref.invalidate(adminJobRolesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE JOB SPEC SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminJobSpecCreateScreen extends StatelessWidget {
  const AdminJobSpecCreateScreen({super.key});
  @override
  Widget build(BuildContext context) => const _JobSpecTemplate(
        title: 'Create Job Spec',
        subtitle: 'Define role expectations and required training.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// TRAINING MATRIX SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminTrainingMatrixScreen extends StatelessWidget {
  const AdminTrainingMatrixScreen({super.key});
  @override
  Widget build(BuildContext context) => const _JobSpecTemplate(
        title: 'Training Matrix',
        subtitle: 'Department and role-level compliance matrix.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// GAP ANALYSIS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminGapAnalysisScreen extends StatelessWidget {
  const AdminGapAnalysisScreen({super.key});
  @override
  Widget build(BuildContext context) => const _JobSpecTemplate(
        title: 'Gap Analysis',
        subtitle: 'Identify missing training against role requirements.',
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// PLACEHOLDER TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════════

class _JobSpecTemplate extends StatelessWidget {
  const _JobSpecTemplate({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: title,
        subtitle: subtitle,
        children: const [
          AdminSectionCard(
            title: 'Coming Soon',
            child: AdminPlaceholderTable(
              columns: ['Feature', 'Status', 'ETA'],
              rows: [
                ['Full implementation', 'In Progress', 'Q2 2026'],
              ],
            ),
          ),
        ],
      );
}
