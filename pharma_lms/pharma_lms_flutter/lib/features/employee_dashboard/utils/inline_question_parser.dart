import 'dart:convert';

class InlineQuestion {
  final String text;
  final String type;
  final List<String>? options;
  final int? correctIndex;
  final String? correctAnswer;

  InlineQuestion({
    required this.text,
    required this.type,
    this.options,
    this.correctIndex,
    this.correctAnswer,
  });

  factory InlineQuestion.fromJson(Map<String, dynamic> json) => InlineQuestion(
        text: json['text'] ?? '',
        type: json['type'] ?? 'open_ended',
        options: (json['options'] as List?)?.map((e) => e.toString()).toList(),
        correctIndex: json['correctIndex'],
        correctAnswer: json['correctAnswer'],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'type': type,
        if (options != null) 'options': options,
        if (correctIndex != null) 'correctIndex': correctIndex,
        if (correctAnswer != null) 'correctAnswer': correctAnswer,
      };
}

class ParsedInstructions {
  final String plainText;
  final List<InlineQuestion> questions;
  ParsedInstructions({required this.plainText, required this.questions});
}

ParsedInstructions parseInstructions(String? instructions) {
  if (instructions == null) {
    return ParsedInstructions(plainText: '', questions: []);
  }
  final regex = RegExp(r'<!-- QUESTIONS_JSON -->([\s\S]*?)<!-- /QUESTIONS_JSON -->');
  final match = regex.firstMatch(instructions);
  if (match != null) {
    final jsonBlock = match.group(1)?.trim();
    try {
      final List<dynamic> arr = json.decode(jsonBlock!);
      final questions = arr.map((e) => InlineQuestion.fromJson(e)).toList();
      final plainText = instructions.replaceAll(regex, '').trim();
      return ParsedInstructions(plainText: plainText, questions: questions);
    } catch (_) {}
  }
  return ParsedInstructions(plainText: instructions.trim(), questions: []);
}
