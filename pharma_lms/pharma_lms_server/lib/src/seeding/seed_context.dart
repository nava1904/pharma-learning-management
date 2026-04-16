/// Carries IDs created during early seed phases so later phases can reference
/// them without re-querying the database.
class SeedContext {
  SeedContext({
    required this.orgId,
    required this.siteIds,
    required this.deptIds,
    required this.jobRoleIds,
    required this.roleIds,
    required this.trainerIds,
    required this.learnerIds,
    required this.qaUserIds,
    required this.adminUserIds,
    required this.courseVersionIds,
    required this.courseIds,
    required this.assessmentIds,
    required this.enrollmentIds,
    required this.materialIds,
    required this.questionBankIds,
    required this.documentIds,
    required this.documentVersionIds,
    required this.baseDate,
    required this.hmacSecret,
    required this.completionMeaning,
  });

  final int orgId;
  final List<int> siteIds;
  final List<int> deptIds;
  final List<int> jobRoleIds;

  /// Role code → role row ID.
  final Map<String, int> roleIds;

  final List<int> trainerIds;
  final List<int> learnerIds;
  final List<int> qaUserIds;
  final List<int> adminUserIds;

  final List<int> courseVersionIds;
  final List<int> courseIds;
  final List<int> assessmentIds;
  final List<int> enrollmentIds;
  final List<int> materialIds;
  final List<int> questionBankIds;
  final List<int> documentIds;
  final List<int> documentVersionIds;

  final DateTime baseDate;
  final String hmacSecret;
  final String completionMeaning;

  /// Helper: offset from [baseDate] by [days].
  DateTime dt(int days) => baseDate.add(Duration(days: days));
}
