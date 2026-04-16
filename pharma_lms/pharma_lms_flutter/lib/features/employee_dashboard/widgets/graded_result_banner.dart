import 'package:flutter/material.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';

class GradedResultBanner extends StatelessWidget {
  final int? grade;
  final String? feedback;
  final DateTime? gradedAt;
  const GradedResultBanner({super.key, this.grade, this.feedback, this.gradedAt});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: PharmaColors.cardBg,
      shape: RoundedRectangleBorder(borderRadius: PharmaRadius.cardRadius),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (grade != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: PharmaColors.emerald100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('$grade/100', style: PharmaTypography.headingSmall),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (feedback != null && feedback!.isNotEmpty)
                    Text('Trainer feedback:', style: PharmaTypography.caption),
                  if (feedback != null && feedback!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 8),
                      child: Text(feedback!, style: PharmaTypography.body),
                    ),
                  if (gradedAt != null)
                    Text('Graded on: ${gradedAt!.toLocal().toString().split(" ")[0]}', style: PharmaTypography.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
