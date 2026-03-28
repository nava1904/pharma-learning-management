import 'dart:convert';

import 'package:pharma_lms_client/pharma_lms_client.dart';

/// Parsed catalog fields from [Course.customMetadataJson] for discovery UI / filters.
class CourseCatalogMetadata {
  const CourseCatalogMetadata({
    this.department,
    this.difficulty,
    this.creditHours,
    this.estimatedMinutes,
    this.dueDate,
    this.isMandatory,
    this.imageUrl,
  });

  final String? department;
  final CatalogDifficulty? difficulty;
  final double? creditHours;
  final int? estimatedMinutes;
  final DateTime? dueDate;
  final bool? isMandatory;
  final String? imageUrl;

  static CourseCatalogMetadata fromCourse(Course course) {
    final raw = course.customMetadataJson;
    if (raw == null || raw.trim().isEmpty) {
      return const CourseCatalogMetadata();
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return const CourseCatalogMetadata();
      }
      return CourseCatalogMetadata.fromJson(decoded);
    } catch (_) {
      return const CourseCatalogMetadata();
    }
  }

  factory CourseCatalogMetadata.fromJson(Map<String, dynamic> json) {
    CatalogDifficulty? diff;
    final d = json['difficulty']?.toString().toLowerCase();
    if (d == 'beginner') {
      diff = CatalogDifficulty.beginner;
    } else if (d == 'intermediate') {
      diff = CatalogDifficulty.intermediate;
    } else if (d == 'advanced') {
      diff = CatalogDifficulty.advanced;
    }

    final chRaw = json['creditHours'] ?? json['credit_hours'];
    final double? ch = chRaw is num ? chRaw.toDouble() : null;

    int? em;
    final emRaw = json['estimatedMinutes'] ?? json['estimated_minutes'];
    if (emRaw is num) {
      em = emRaw.toInt();
    } else {
      final dh = json['durationHours'] ?? json['duration_hours'];
      if (dh is num) {
        em = (dh.toDouble() * 60).round();
      }
    }

    bool? mandatory;
    if (json['isMandatory'] is bool) {
      mandatory = json['isMandatory'] as bool;
    } else {
      final tt = json['trainingType']?.toString().toLowerCase();
      if (tt == 'mandatory') {
        mandatory = true;
      } else if (tt == 'elective') {
        mandatory = false;
      }
    }

    final url = json['imageUrl'] ?? json['image_url'];

    DateTime? due;
    final dueDateRaw = json['dueDate'] ?? json['due_date'];
    if (dueDateRaw is String) {
      try {
        due = DateTime.tryParse(dueDateRaw);
      } catch (_) {
        due = null;
      }
    } else if (dueDateRaw is DateTime) {
      due = dueDateRaw;
    }

    return CourseCatalogMetadata(
      department: json['department']?.toString(),
      difficulty: diff,
      creditHours: ch,
      estimatedMinutes: em,
      dueDate: due,
      isMandatory: mandatory,
      imageUrl: url?.toString(),
    );
  }

  bool matchesCreditBucket(CatalogCreditBucket bucket) {
    if (bucket == CatalogCreditBucket.all) return true;
    final ch = creditHours;
    if (ch == null) return false;
    switch (bucket) {
      case CatalogCreditBucket.lt5:
        return ch < 5;
      case CatalogCreditBucket.between5and10:
        return ch >= 5 && ch <= 10;
      case CatalogCreditBucket.gt10:
        return ch > 10;
      case CatalogCreditBucket.all:
        return true;
    }
  }

  bool matchesDifficultyFilter(CatalogDifficulty? selected) {
    if (selected == null) return true;
    return difficulty == selected;
  }

  bool matchesDepartmentFilter(String selectedDept) {
    if (selectedDept == kCatalogFilterAll) return true;
    final dept = department?.trim();
    if (dept == null || dept.isEmpty) return false;
    return dept == selectedDept;
  }

  String difficultyDisplayLabel() {
    return switch (difficulty) {
      CatalogDifficulty.beginner => 'Beginner',
      CatalogDifficulty.intermediate => 'Intermediate',
      CatalogDifficulty.advanced => 'Advanced',
      null => '',
    };
  }

  /// Short label for estimated time (e.g. "4 h", "45 m").
  String? formattedEstimatedTime() {
    final m = estimatedMinutes;
    if (m == null || m <= 0) return null;
    if (m >= 60 && m % 60 == 0) {
      final h = m ~/ 60;
      return '$h ${h == 1 ? 'hour' : 'hours'}';
    }
    if (m >= 60) {
      final h = m ~/ 60;
      final rem = m % 60;
      if (rem == 0) return '$h h';
      return '${h}h ${rem}m';
    }
    return '$m min';
  }

  /// Credit hours for display; null means omit pill.
  String? creditHoursLabel() {
    final ch = creditHours;
    if (ch == null) return null;
    if (ch == ch.roundToDouble()) {
      return '${ch.round()} Credit Hours';
    }
    return '${ch.toStringAsFixed(1)} Credit Hours';
  }
}

const String kCatalogFilterAll = 'All';

enum CatalogDifficulty { beginner, intermediate, advanced }

enum CatalogCreditBucket {
  all,
  lt5,
  between5and10,
  gt10,
}

extension CatalogCreditBucketLabels on CatalogCreditBucket {
  String get menuKey => switch (this) {
        CatalogCreditBucket.all => 'all',
        CatalogCreditBucket.lt5 => 'lt5',
        CatalogCreditBucket.between5and10 => '5_10',
        CatalogCreditBucket.gt10 => 'gt10',
      };

  String get menuLabel => switch (this) {
        CatalogCreditBucket.all => 'All Credit Hours',
        CatalogCreditBucket.lt5 => 'Less than 5',
        CatalogCreditBucket.between5and10 => '5\u2013 10',
        CatalogCreditBucket.gt10 => 'Greater than 10',
      };
}

CatalogCreditBucket catalogCreditBucketFromMenuKey(String key) {
  return switch (key) {
    'lt5' => CatalogCreditBucket.lt5,
    '5_10' => CatalogCreditBucket.between5and10,
    'gt10' => CatalogCreditBucket.gt10,
    _ => CatalogCreditBucket.all,
  };
}
