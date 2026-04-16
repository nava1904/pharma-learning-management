import 'package:flutter/material.dart';
import '../utils/inline_question_parser.dart';
// Update the import path if the file exists elsewhere, for example:
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';

Widget buildQuestionWidget({
  required InlineQuestion question,
  required int questionNumber,
  required dynamic currentAnswer,
  required ValueChanged<dynamic> onChanged,
  required bool readOnly,
}) {
  switch (question.type) {
    case 'mcq':
    case 'multiple_choice':
      return MCQQuestionWidget(
        question: question,
        questionNumber: questionNumber,
        selectedIndex: currentAnswer as int?,
        onChanged: onChanged,
        readOnly: readOnly,
      );
    case 'true_false':
      return TrueFalseQuestionWidget(
        question: question,
        questionNumber: questionNumber,
        selected: currentAnswer as bool?,
        onChanged: onChanged,
        readOnly: readOnly,
      );
    case 'short_answer':
      return ShortAnswerQuestionWidget(
        question: question,
        questionNumber: questionNumber,
        answer: currentAnswer as String?,
        onChanged: onChanged,
        readOnly: readOnly,
      );
    default:
      return OpenEndedQuestionWidget(
        question: question,
        questionNumber: questionNumber,
        answer: currentAnswer as String?,
        onChanged: onChanged,
        readOnly: readOnly,
      );
  }
}

class MCQQuestionWidget extends StatelessWidget {
  final InlineQuestion question;
  final int questionNumber;
  final int? selectedIndex;
  final ValueChanged<int?> onChanged;
  final bool readOnly;
  const MCQQuestionWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selectedIndex,
    required this.onChanged,
    required this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    final options = question.options ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  Text('Q$questionNumber: ${question.text}', style: PharmaTypography.bodyMedium),
        const SizedBox(height: 8),
        ...List.generate(options.length, (i) {
          final label = String.fromCharCode(65 + i);
          final selected = selectedIndex == i;
          return GestureDetector(
            onTap: readOnly ? null : () => onChanged(i),
            child: Card(
              color: selected ? PharmaColors.emerald100 : PharmaColors.cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: PharmaRadius.cardRadius,
                side: BorderSide(color: selected ? PharmaColors.emerald600 : PharmaColors.borderLight),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: selected ? PharmaColors.emerald600 : PharmaColors.borderLight,
                  child: Text(label, style: PharmaTypography.bodyMedium.copyWith(color: Colors.white)),
                ),
                title: Text(options[i], style: PharmaTypography.body),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class TrueFalseQuestionWidget extends StatelessWidget {
  final InlineQuestion question;
  final int questionNumber;
  final bool? selected;
  final ValueChanged<bool?> onChanged;
  final bool readOnly;
  const TrueFalseQuestionWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selected,
    required this.onChanged,
    required this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  Text('Q$questionNumber: ${question.text}', style: PharmaTypography.bodyMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: readOnly ? null : () => onChanged(true),
                child: Card(
                  color: selected == true ? PharmaColors.emerald100 : PharmaColors.cardBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: PharmaRadius.cardRadius,
                    side: BorderSide(color: selected == true ? PharmaColors.emerald600 : PharmaColors.borderLight),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text('True', style: PharmaTypography.body)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: readOnly ? null : () => onChanged(false),
                child: Card(
                  color: selected == false ? PharmaColors.emerald100 : PharmaColors.cardBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: PharmaRadius.cardRadius,
                    side: BorderSide(color: selected == false ? PharmaColors.emerald600 : PharmaColors.borderLight),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text('False', style: PharmaTypography.body)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShortAnswerQuestionWidget extends StatelessWidget {
  final InlineQuestion question;
  final int questionNumber;
  final String? answer;
  final ValueChanged<String?> onChanged;
  final bool readOnly;
  const ShortAnswerQuestionWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.answer,
    required this.onChanged,
    required this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  Text('Q$questionNumber: ${question.text}', style: PharmaTypography.bodyMedium),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: answer),
          onChanged: readOnly ? null : onChanged,
          readOnly: readOnly,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your answer',
          ),
        ),
      ],
    );
  }
}

class OpenEndedQuestionWidget extends StatelessWidget {
  final InlineQuestion question;
  final int questionNumber;
  final String? answer;
  final ValueChanged<String?> onChanged;
  final bool readOnly;
  const OpenEndedQuestionWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.answer,
    required this.onChanged,
    required this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  Text('Q$questionNumber: ${question.text}', style: PharmaTypography.bodyMedium),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: answer),
          onChanged: readOnly ? null : onChanged,
          readOnly: readOnly,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your answer',
          ),
        ),
      ],
    );
  }
}
