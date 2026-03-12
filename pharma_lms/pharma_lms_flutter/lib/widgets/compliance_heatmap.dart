import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/theme/app_colors.dart';

/// Treemap-style compliance heatmap: block size ∝ totalEmployees, color by rate.
/// Red &lt;90%, Yellow 90–95%, Green ≥95%.
class ComplianceHeatmap extends StatelessWidget {
  const ComplianceHeatmap({
    super.key,
    required this.departments,
    this.height = 200,
  });

  final List<DepartmentComplianceSummary> departments;
  final double height;

  static Color _colorForRate(double rate) {
    if (rate >= 95) return AppColors.success;
    if (rate >= 90) return AppColors.warning;
    return AppColors.destructive;
  }

  @override
  Widget build(BuildContext context) {
    if (departments.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No compliance data')),
      );
    }

    final total = departments.fold<int>(0, (s, d) => s + d.totalEmployees);
    if (total == 0) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No employees')),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final dept in departments) ...[
              if (dept != departments.first) const SizedBox(width: 4),
              Expanded(
                flex: dept.totalEmployees.clamp(1, 0x7fffffff),
                child: Tooltip(
                  message: '${dept.departmentName ?? 'Dept'}: '
                      '${dept.complianceRate.toStringAsFixed(1)}% '
                      '(${dept.compliant}/${dept.totalEmployees})',
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: _colorForRate(dept.complianceRate),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            dept.departmentName ?? '?',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${dept.complianceRate.toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
