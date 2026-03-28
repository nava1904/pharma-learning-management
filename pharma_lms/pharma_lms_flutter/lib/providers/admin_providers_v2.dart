// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — ADMIN PORTAL PROVIDERS V2
// ═══════════════════════════════════════════════════════════════════════════════
// Real backend connections via Serverpod client
// FDA 21 CFR Part 11 · GMP Annex 11 · ALCOA+
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import '../core/client.dart';
import 'user_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 0: DASHBOARD PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════

/// Dashboard KPI data provider
final adminDashboardKpiProvider = FutureProvider<AdminDashboardKpi>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) {
      return AdminDashboardKpi.empty();
    }

    final users = await client.organization.listUsers(organizationId: user.organizationId);
    final courses = await client.course.listCourses(organizationId: user.organizationId);
    final pendingQA = courses
        .where((c) => c.status == 'pending_qa' || c.status == 'under_review')
        .length;

    final kpis = await client.analytics.getAdminDashboardKpis();
    final totalEnrollments = (kpis['totalEnrollments'] as num?)?.toInt() ?? 0;
    final complianceRate = (kpis['complianceRatePercent'] as num?)?.toInt() ?? 0;
    final overdueCount = (kpis['overdueEnrollments'] as num?)?.toInt() ?? 0;

    return AdminDashboardKpi(
      totalUsers: users.length,
      totalCourses: courses.length,
      totalEnrollments: totalEnrollments,
      complianceRate: complianceRate,
      pendingQaCount: pendingQA,
      overdueCount: overdueCount,
    );
  } catch (e) {
    return AdminDashboardKpi.empty();
  }
});

/// Priority queues for dashboard
final adminPriorityQueuesProvider = FutureProvider<List<PriorityQueueItem>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];

    final courses = await client.course.listCourses(organizationId: user.organizationId);
    final pendingApprovals = courses
        .where((c) => c.status == 'pending_qa' || c.status == 'under_review')
        .length;

    final sopQueue = await client.analytics.getSopRetrainingQueue();
    final openCapas = await client.analytics.getOpenCapasRequiringTraining();

    return [
      PriorityQueueItem(
        name: 'Course Approvals',
        count: pendingApprovals,
        sla: '24h',
        owner: 'QA Team',
        route: '/admin/courses/approval',
      ),
      PriorityQueueItem(
        name: 'Access Reviews',
        count: 0,
        sla: '7d',
        owner: 'Admin',
        route: '/admin/users/access-review',
      ),
      PriorityQueueItem(
        name: 'SOP Retraining Queue',
        count: sopQueue.length,
        sla: '5d',
        owner: 'QA / Training',
        route: '/admin/reports/compliance',
      ),
      PriorityQueueItem(
        name: 'CAPA Actions',
        count: openCapas.length,
        sla: '3d',
        owner: 'Compliance',
        route: '/admin/audit/capa',
      ),
    ];
  } catch (e) {
    return [];
  }
});

/// Recent audit events for dashboard
final adminRecentAuditProvider = FutureProvider<List<AuditTrail>>((ref) async {
  try {
    return await client.audit.getAuditTrail(limit: 10);
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 1: USER & IDENTITY MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Parameters for users list provider
class UsersListParams {
  final int page;
  final int perPage;
  final String? role;
  final String? status;
  final String? search;
  final int? organizationId;
  final int? departmentId;

  const UsersListParams({
    this.page = 1,
    this.perPage = 20,
    this.role,
    this.status,
    this.search,
    this.organizationId,
    this.departmentId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersListParams &&
          page == other.page &&
          perPage == other.perPage &&
          role == other.role &&
          status == other.status &&
          search == other.search &&
          organizationId == other.organizationId &&
          departmentId == other.departmentId;

  @override
  int get hashCode => Object.hash(page, perPage, role, status, search, organizationId, departmentId);
}

/// All users list provider
final adminUsersProvider = FutureProvider<List<PharmaUser>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.organization.listUsers(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Paginated users with filters
final adminUsersListProvider = FutureProvider.family<List<PharmaUser>, UsersListParams>((ref, params) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    
    final orgId = params.organizationId ?? user.organizationId;
    final allUsers = await client.organization.listUsers(organizationId: orgId);
    
    // Apply filters
    var filtered = allUsers.where((u) {
      // Search filter
      if (params.search != null && params.search!.isNotEmpty) {
        final searchLower = params.search!.toLowerCase();
        final nameMatch = '${u.firstName} ${u.lastName}'.toLowerCase().contains(searchLower);
        final emailMatch = u.email.toLowerCase().contains(searchLower);
        final empIdMatch = u.employeeId?.toLowerCase().contains(searchLower) ?? false;
        if (!nameMatch && !emailMatch && !empIdMatch) return false;
      }
      
      // Status filter
      if (params.status != null && params.status!.isNotEmpty) {
        if (u.status.toLowerCase() != params.status!.toLowerCase()) return false;
      }
      
      // Department filter
      if (params.departmentId != null) {
        if (u.departmentId != params.departmentId) return false;
      }
      
      return true;
    }).toList();
    
    // Pagination
    final start = (params.page - 1) * params.perPage;
    final end = start + params.perPage;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, end.clamp(0, filtered.length));
  } catch (e) {
    return [];
  }
});

/// User count provider
final adminUserCountProvider = FutureProvider<int>((ref) async {
  try {
    final users = await ref.watch(adminUsersProvider.future);
    return users.length;
  } catch (e) {
    return 0;
  }
});

/// Provider to create a new user
final adminCreateUserProvider = FutureProvider.family<PharmaUser, Map<String, dynamic>>((ref, params) async {
  return client.adminUserManagement.createUser(
    email: params['email'] as String,
    firstName: params['firstName'] as String,
    lastName: params['lastName'] as String,
    employeeId: params['employeeId'] as String?,
    organizationId: params['organizationId'] as int?,
    departmentId: params['departmentId'] as int?,
    jobRoleId: params['jobRoleId'] as int?,
    siteId: params['siteId'] as int?,
  );
});

/// Provider to update an existing user
final adminUpdateUserProvider = FutureProvider.family<PharmaUser?, Map<String, dynamic>>((ref, params) async {
  try {
    // params: userId, firstName, lastName, organizationId, departmentId
    return await client.adminUserManagement.updateUser(
      userId: params['userId'],
      firstName: params['firstName'],
      lastName: params['lastName'],
      organizationId: params['organizationId'],
      departmentId: params['departmentId'],
    );
  } catch (e) {
    return null;
  }
});

/// Provider to deactivate a user
final adminDeactivateUserProvider = FutureProvider.family<bool, int>((ref, userId) async {
  try {
    return await client.adminUserManagement.deactivateUser(userId: userId);
  } catch (e) {
    return false;
  }
});

/// Single user detail provider
final adminUserDetailProvider = FutureProvider.family<PharmaUser?, int>((ref, userId) async {
  try {
    return await client.adminUserManagement.getUser(userId: userId);
  } catch (e) {
    return null;
  }
});

/// Organizations (for admin user forms).
final adminOrganizationsListProvider = FutureProvider<List<Organization>>((ref) async {
  try {
    return await client.organization.listOrganizations();
  } catch (e) {
    return [];
  }
});

/// Department + site mapping for an organization (flattened for dropdowns).
class AdminDepartmentOption {
  const AdminDepartmentOption({
    required this.departmentId,
    required this.siteId,
    required this.name,
  });
  final int departmentId;
  final int siteId;
  final String name;
}

final adminDepartmentOptionsForOrgProvider =
    FutureProvider.family<List<AdminDepartmentOption>, int>((ref, organizationId) async {
  try {
    final sites = await client.organization.listSites(organizationId);
    final out = <AdminDepartmentOption>[];
    for (final site in sites) {
      final sid = site.id;
      if (sid == null) continue;
      final depts = await client.organization.listDepartments(sid);
      for (final d in depts) {
        final did = d.id;
        if (did == null) continue;
        out.add(AdminDepartmentOption(departmentId: did, siteId: sid, name: d.name));
      }
    }
    return out;
  } catch (e) {
    return [];
  }
});

final adminJobRolesForDepartmentProvider =
    FutureProvider.family<List<JobRole>, int>((ref, departmentId) async {
  try {
    return await client.organization.listJobRoles(departmentId);
  } catch (e) {
    return [];
  }
});

/// User roles for a specific user (from job role)
final adminUserRolesProvider = FutureProvider.family<List<String>, int>((ref, userId) async {
  try {
    final user = await ref.watch(adminUserDetailProvider(userId).future);
    if (user == null) return [];
    // Return job role name as the role (job role defines training requirements)
    return user.jobRole != null ? [user.jobRole!.name] : [];
  } catch (e) {
    return [];
  }
});

/// All available roles (defined roles in the system)
final adminRolesProvider = FutureProvider<List<String>>((ref) async {
  // Hardcoded role list since there's no endpoint for listing roles
  return ['admin', 'trainer', 'qa', 'employee', 'manager', 'compliance_officer', 'system_admin'];
});

/// Organizations list
final adminOrganizationsProvider = FutureProvider<List<Organization>>((ref) async {
  try {
    return await client.organization.listOrganizations();
  } catch (e) {
    return [];
  }
});

/// Departments list (requires siteId, uses first site)
final adminDepartmentsProvider = FutureProvider<List<Department>>((ref) async {
  try {
    final sites = await ref.watch(adminSitesProvider.future);
    if (sites.isEmpty) return [];
    // Get departments from first site
    return await client.organization.listDepartments(sites.first.id!);
  } catch (e) {
    return [];
  }
});

/// Sites list
final adminSitesProvider = FutureProvider<List<Site>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.organization.listSites(user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Job roles list (requires departmentId, uses first department)
final adminJobRolesProvider = FutureProvider<List<JobRole>>((ref) async {
  try {
    final departments = await ref.watch(adminDepartmentsProvider.future);
    if (departments.isEmpty) return [];
    // Get job roles from first department
    return await client.organization.listJobRoles(departments.first.id!);
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 2: COURSE & CONTENT MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Parameters for course list
class CourseListParams {
  final int page;
  final int perPage;
  final String? status;
  final String? search;
  final int? categoryId;

  const CourseListParams({
    this.page = 1,
    this.perPage = 20,
    this.status,
    this.search,
    this.categoryId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseListParams &&
          page == other.page &&
          perPage == other.perPage &&
          status == other.status &&
          search == other.search &&
          categoryId == other.categoryId;

  @override
  int get hashCode => Object.hash(page, perPage, status, search, categoryId);
}

/// All courses provider
final adminCoursesProvider = FutureProvider<List<Course>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.course.listCourses(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Paginated courses with filters
final adminCoursesListProvider = FutureProvider.family<List<Course>, CourseListParams>((ref, params) async {
  try {
    final allCourses = await ref.watch(adminCoursesProvider.future);
    
    // Apply filters
    var filtered = allCourses.where((c) {
      // Search filter
      if (params.search != null && params.search!.isNotEmpty) {
        final searchLower = params.search!.toLowerCase();
        final titleMatch = c.title.toLowerCase().contains(searchLower);
        if (!titleMatch) return false;
      }
      
      // Status filter
      if (params.status != null && params.status!.isNotEmpty) {
        if (c.status.toLowerCase() != params.status!.toLowerCase()) return false;
      }
      
      return true;
    }).toList();
    
    // Pagination
    final start = (params.page - 1) * params.perPage;
    final end = start + params.perPage;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, end.clamp(0, filtered.length));
  } catch (e) {
    return [];
  }
});

/// Courses pending approval
final adminPendingApprovalCoursesProvider = FutureProvider<List<Course>>((ref) async {
  try {
    final courses = await ref.watch(adminCoursesProvider.future);
    return courses.where((c) => 
        c.status == 'pending_qa' || 
        c.status == 'under_review' ||
        c.status == 'pending_approval').toList();
  } catch (e) {
    return [];
  }
});

/// Course versions provider
final adminCourseVersionsProvider = FutureProvider.family<List<CourseVersion>, int>((ref, courseId) async {
  try {
    return await client.course.getCourseVersions(courseId);
  } catch (e) {
    return [];
  }
});

/// Course detail provider
final adminCourseDetailProvider = FutureProvider.family<Course?, int>((ref, courseId) async {
  try {
    final courses = await ref.watch(adminCoursesProvider.future);
    return courses.where((c) => c.id == courseId).firstOrNull;
  } catch (e) {
    return null;
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 3: ENROLLMENT MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Parameters for enrollment list
class EnrollmentListParams {
  final int page;
  final int perPage;
  final String? status;
  final int? userId;
  final int? courseId;
  final bool? overdue;

  const EnrollmentListParams({
    this.page = 1,
    this.perPage = 20,
    this.status,
    this.userId,
    this.courseId,
    this.overdue,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnrollmentListParams &&
          page == other.page &&
          perPage == other.perPage &&
          status == other.status &&
          userId == other.userId &&
          courseId == other.courseId &&
          overdue == other.overdue;

  @override
  int get hashCode => Object.hash(page, perPage, status, userId, courseId, overdue);
}

/// Training assignments provider (uses existing endpoint)
final adminTrainingAssignmentsProvider = FutureProvider<List<TrainingAssignment>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null || user.id == null) return [];
    return await client.training.getAssignmentsForUser(user.id!);
  } catch (e) {
    return [];
  }
});

/// All user enrollments (for a specific user)
final adminUserEnrollmentsProvider = FutureProvider.family<List<Enrollment>, int>((ref, userId) async {
  try {
    return await client.training.getEnrollmentsForUser(userId);
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 6: ASSESSMENT MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Question banks provider
final adminQuestionBanksProvider = FutureProvider<List<QuestionBank>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.assessment.listQuestionBanks(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Questions for a specific question bank
final adminQuestionsProvider = FutureProvider.family<List<Question>, int>((ref, questionBankId) async {
  try {
    return await client.assessment.getQuestions(questionBankId);
  } catch (e) {
    return [];
  }
});

/// Admin: list assessments visible to an org.
final adminAssessmentsProvider = FutureProvider.family<List<Assessment>, int>((ref, organizationId) async {
  try {
    return await client.assessmentBuilder.listAssessments(
      organizationId: organizationId,
      limit: 200,
    );
  } catch (e) {
    return [];
  }
});

/// Admin: list attempts for an assessment.
final adminAssessmentAttemptsProvider = FutureProvider.family<List<AssessmentAttempt>, int>((ref, assessmentId) async {
  try {
    return await client.assessmentBuilder.listAssessmentAttempts(
      assessmentId: assessmentId,
      limit: 200,
    );
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 7: CERTIFICATE MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// User certificates (for a specific user)
final adminUserCertificatesProvider = FutureProvider.family<List<Certificate>, int>((ref, userId) async {
  try {
    return await client.training.getCertificatesForUser(userId);
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 10: AUDIT TRAIL & CAPA MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Audit trail provider
final adminAuditTrailProvider = FutureProvider.family<List<AuditTrail>, AuditTrailParams>((ref, params) async {
  try {
    return await client.audit.getAuditTrail(
      userId: params.userId,
      entityType: params.entityType,
      entityId: params.entityId,
      from: params.from,
      to: params.to,
      limit: params.limit,
    );
  } catch (e) {
    return [];
  }
});

class AuditTrailParams {
  final int? userId;
  final String? entityType;
  final String? entityId;
  final DateTime? from;
  final DateTime? to;
  final int limit;

  const AuditTrailParams({
    this.userId,
    this.entityType,
    this.entityId,
    this.from,
    this.to,
    this.limit = 100,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditTrailParams &&
          userId == other.userId &&
          entityType == other.entityType &&
          entityId == other.entityId &&
          from == other.from &&
          to == other.to &&
          limit == other.limit;

  @override
  int get hashCode => Object.hash(userId, entityType, entityId, from, to, limit);
}

/// Org-scoped training assignments (admin view of enrollments / assignments).
final adminOrgAssignmentsProvider = FutureProvider<List<TrainingAssignment>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.training.getAllAssignments(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Controlled documents for current organization.
final adminDocumentsProvider = FutureProvider<List<Document>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.document.listDocuments(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Saved report definitions from analytics module.
final adminReportDefinitionsProvider = FutureProvider<List<ReportDefinition>>((ref) async {
  try {
    return await client.analytics.listReportDefinitions();
  } catch (e) {
    return [];
  }
});

/// CAPA register (all capas; filter in UI if needed).
final adminCapasProvider = FutureProvider<List<Capa>>((ref) async {
  try {
    return await client.qualityEvent.listCapas();
  } catch (e) {
    return [];
  }
});

/// Training matrix rows (org-wide when siteId is null).
final adminTrainingMatrixEntriesProvider = FutureProvider<List<TrainingMatrix>>((ref) async {
  try {
    return await client.admin.listTrainingMatrixEntries(siteId: null);
  } catch (e) {
    return [];
  }
});

/// Department-level compliance summary for gap-style views.
final adminDepartmentComplianceSummaryProvider = FutureProvider<List<DepartmentComplianceSummary>>((ref) async {
  try {
    return await client.analytics.getDepartmentComplianceSummary();
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE 12: ANALYTICS & REPORTING
// ═══════════════════════════════════════════════════════════════════════════════

/// Training analytics provider
final adminTrainingAnalyticsProvider = FutureProvider<TrainingAnalytics>((ref) async {
  try {
    final courses = await ref.watch(adminCoursesProvider.future);
    final users = await ref.watch(adminUsersProvider.future);
    
    return TrainingAnalytics(
      totalCourses: courses.length,
      totalUsers: users.length,
      completionRate: 0,
      passRate: 0,
      averageScore: 0,
    );
  } catch (e) {
    return TrainingAnalytics.empty();
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// DATA CLASSES
// ═══════════════════════════════════════════════════════════════════════════════

class AdminDashboardKpi {
  final int totalUsers;
  final int totalCourses;
  final int totalEnrollments;
  final int complianceRate;
  final int pendingQaCount;
  final int overdueCount;

  AdminDashboardKpi({
    required this.totalUsers,
    required this.totalCourses,
    required this.totalEnrollments,
    required this.complianceRate,
    required this.pendingQaCount,
    required this.overdueCount,
  });
  
  factory AdminDashboardKpi.empty() => AdminDashboardKpi(
    totalUsers: 0,
    totalCourses: 0,
    totalEnrollments: 0,
    complianceRate: 0,
    pendingQaCount: 0,
    overdueCount: 0,
  );
}

class PriorityQueueItem {
  final String name;
  final int count;
  final String sla;
  final String owner;
  final String route;

  PriorityQueueItem({
    required this.name,
    required this.count,
    required this.sla,
    required this.owner,
    required this.route,
  });
}

class ComplianceGap {
  final int userId;
  final String userName;
  final int jobRoleId;
  final int courseVersionId;
  final DateTime? dueDate;

  ComplianceGap({
    required this.userId,
    required this.userName,
    required this.jobRoleId,
    required this.courseVersionId,
    this.dueDate,
  });
}

class ComplianceKpi {
  final int totalUsers;
  final int compliantUsers;
  final int complianceRate;
  final int overdueTrainings;
  final int upcomingDue30Days;

  ComplianceKpi({
    required this.totalUsers,
    required this.compliantUsers,
    required this.complianceRate,
    required this.overdueTrainings,
    required this.upcomingDue30Days,
  });
}

class TrainingAnalytics {
  final int totalCourses;
  final int totalUsers;
  final int completionRate;
  final int passRate;
  final int averageScore;

  TrainingAnalytics({
    required this.totalCourses,
    required this.totalUsers,
    required this.completionRate,
    required this.passRate,
    required this.averageScore,
  });
  
  factory TrainingAnalytics.empty() => TrainingAnalytics(
    totalCourses: 0,
    totalUsers: 0,
    completionRate: 0,
    passRate: 0,
    averageScore: 0,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE: TRAINING BATCHES MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Parameters for batch list filtering
class BatchListParams {
  final int page;
  final int perPage;
  final String? status;
  final String? search;
  final int? courseVersionId;

  const BatchListParams({
    this.page = 1,
    this.perPage = 20,
    this.status,
    this.search,
    this.courseVersionId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchListParams &&
          page == other.page &&
          perPage == other.perPage &&
          status == other.status &&
          search == other.search &&
          courseVersionId == other.courseVersionId;

  @override
  int get hashCode => Object.hash(page, perPage, status, search, courseVersionId);
}

/// All training batches for admin portal
final adminBatchesProvider = FutureProvider<List<TrainingBatch>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.trainingBatch.listBatches(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Paginated batches with filters
final adminBatchesListProvider = FutureProvider.family<List<TrainingBatch>, BatchListParams>((ref, params) async {
  try {
    final batches = await ref.watch(adminBatchesProvider.future);
    
    // Apply filters
    var filtered = batches.where((b) {
      // Search filter
      if (params.search != null && params.search!.isNotEmpty) {
        final searchLower = params.search!.toLowerCase();
        final nameMatch = b.name.toLowerCase().contains(searchLower);
        final locationMatch = b.location?.toLowerCase().contains(searchLower) ?? false;
        if (!nameMatch && !locationMatch) return false;
      }
      
      // Status filter
      if (params.status != null && params.status!.isNotEmpty) {
        if (b.status.toLowerCase() != params.status!.toLowerCase()) return false;
      }
      
      // Course version filter
      if (params.courseVersionId != null) {
        if (b.courseVersionId != params.courseVersionId) return false;
      }
      
      return true;
    }).toList();
    
    // Pagination
    final start = (params.page - 1) * params.perPage;
    final end = start + params.perPage;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, end.clamp(0, filtered.length));
  } catch (e) {
    return [];
  }
});

/// Batch stats for dashboard
final adminBatchStatsProvider = FutureProvider<BatchStats>((ref) async {
  try {
    final batches = await ref.watch(adminBatchesProvider.future);
    return BatchStats(
      total: batches.length,
      scheduled: batches.where((b) => b.status == 'scheduled').length,
      inProgress: batches.where((b) => b.status == 'in_progress').length,
      completed: batches.where((b) => b.status == 'completed').length,
      cancelled: batches.where((b) => b.status == 'cancelled').length,
    );
  } catch (e) {
    return BatchStats.empty();
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE: CERTIFICATES MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Parameters for certificate list filtering
class CertificateListParams {
  final int page;
  final int perPage;
  final String? status;
  final String? search;
  final int? userId;
  final int? courseVersionId;

  const CertificateListParams({
    this.page = 1,
    this.perPage = 20,
    this.status,
    this.search,
    this.userId,
    this.courseVersionId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateListParams &&
          page == other.page &&
          perPage == other.perPage &&
          status == other.status &&
          search == other.search &&
          userId == other.userId &&
          courseVersionId == other.courseVersionId;

  @override
  int get hashCode => Object.hash(page, perPage, status, search, userId, courseVersionId);
}

/// All certificates for admin portal
final adminCertificatesProvider = FutureProvider<List<Certificate>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.certificate.listCertificates(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Paginated certificates with filters
final adminCertificatesListProvider = FutureProvider.family<List<Certificate>, CertificateListParams>((ref, params) async {
  try {
    final certificates = await ref.watch(adminCertificatesProvider.future);
    
    // Apply filters
    var filtered = certificates.where((c) {
      // Status filter
      if (params.status != null && params.status!.isNotEmpty) {
        if (c.status.toLowerCase() != params.status!.toLowerCase()) return false;
      }
      
      // User filter
      if (params.userId != null) {
        if (c.userId != params.userId) return false;
      }
      
      // Course version filter
      if (params.courseVersionId != null) {
        if (c.courseVersionId != params.courseVersionId) return false;
      }
      
      return true;
    }).toList();
    
    // Pagination
    final start = (params.page - 1) * params.perPage;
    final end = start + params.perPage;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, end.clamp(0, filtered.length));
  } catch (e) {
    return [];
  }
});

/// Certificate stats for dashboard
final adminCertificateStatsProvider = FutureProvider<CertificateStats>((ref) async {
  try {
    final certificates = await ref.watch(adminCertificatesProvider.future);
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));
    
    return CertificateStats(
      total: certificates.length,
      active: certificates.where((c) => c.status == 'active').length,
      expired: certificates.where((c) => c.status == 'expired').length,
      revoked: certificates.where((c) => c.status == 'revoked').length,
      expiringIn30Days: certificates.where((c) => 
        c.status == 'active' && 
        c.expiresAt != null && 
        c.expiresAt!.isAfter(now) && 
        c.expiresAt!.isBefore(thirtyDaysFromNow)
      ).length,
    );
  } catch (e) {
    return CertificateStats.empty();
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE: NOTIFICATION TEMPLATES MANAGEMENT
// ═══════════════════════════════════════════════════════════════════════════════

/// Parameters for notification template list filtering
class NotificationTemplateListParams {
  final int page;
  final int perPage;
  final String? status;
  final String? type;
  final String? channel;
  final String? search;

  const NotificationTemplateListParams({
    this.page = 1,
    this.perPage = 20,
    this.status,
    this.type,
    this.channel,
    this.search,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTemplateListParams &&
          page == other.page &&
          perPage == other.perPage &&
          status == other.status &&
          type == other.type &&
          channel == other.channel &&
          search == other.search;

  @override
  int get hashCode => Object.hash(page, perPage, status, type, channel, search);
}

/// All notification templates for admin portal
final adminNotificationTemplatesProvider = FutureProvider<List<NotificationTemplate>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.notificationTemplate.listTemplates(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

/// Paginated notification templates with filters
final adminNotificationTemplatesListProvider = FutureProvider.family<List<NotificationTemplate>, NotificationTemplateListParams>((ref, params) async {
  try {
    final templates = await ref.watch(adminNotificationTemplatesProvider.future);
    
    // Apply filters
    var filtered = templates.where((t) {
      // Search filter
      if (params.search != null && params.search!.isNotEmpty) {
        final searchLower = params.search!.toLowerCase();
        final nameMatch = t.name.toLowerCase().contains(searchLower);
        final subjectMatch = t.subject?.toLowerCase().contains(searchLower) ?? false;
        if (!nameMatch && !subjectMatch) return false;
      }
      
      // Status filter
      if (params.status != null && params.status!.isNotEmpty) {
        if (t.status.toLowerCase() != params.status!.toLowerCase()) return false;
      }
      
      // Type filter
      if (params.type != null && params.type!.isNotEmpty) {
        if (t.type.toLowerCase() != params.type!.toLowerCase()) return false;
      }
      
      // Channel filter
      if (params.channel != null && params.channel!.isNotEmpty) {
        if (t.channel.toLowerCase() != params.channel!.toLowerCase()) return false;
      }
      
      return true;
    }).toList();
    
    // Pagination
    final start = (params.page - 1) * params.perPage;
    final end = start + params.perPage;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, end.clamp(0, filtered.length));
  } catch (e) {
    return [];
  }
});

/// Notification template stats for dashboard
final adminNotificationTemplateStatsProvider = FutureProvider<NotificationTemplateStats>((ref) async {
  try {
    final templates = await ref.watch(adminNotificationTemplatesProvider.future);
    return NotificationTemplateStats(
      total: templates.length,
      active: templates.where((t) => t.status == 'active').length,
      draft: templates.where((t) => t.status == 'draft').length,
      inactive: templates.where((t) => t.status == 'inactive').length,
      emailTemplates: templates.where((t) => t.channel == 'email').length,
      pushTemplates: templates.where((t) => t.channel == 'push').length,
      smsTemplates: templates.where((t) => t.channel == 'sms').length,
      inAppTemplates: templates.where((t) => t.channel == 'in_app').length,
    );
  } catch (e) {
    return NotificationTemplateStats.empty();
  }
});

/// All notifications (sent) for admin viewing
final adminNotificationsProvider = FutureProvider<List<Notification>>((ref) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];
    return await client.notification.listNotifications(organizationId: user.organizationId);
  } catch (e) {
    return [];
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// STATS MODEL CLASSES
// ═══════════════════════════════════════════════════════════════════════════════

class BatchStats {
  final int total;
  final int scheduled;
  final int inProgress;
  final int completed;
  final int cancelled;

  BatchStats({
    required this.total,
    required this.scheduled,
    required this.inProgress,
    required this.completed,
    required this.cancelled,
  });
  
  factory BatchStats.empty() => BatchStats(
    total: 0,
    scheduled: 0,
    inProgress: 0,
    completed: 0,
    cancelled: 0,
  );
}

class CertificateStats {
  final int total;
  final int active;
  final int expired;
  final int revoked;
  final int expiringIn30Days;

  CertificateStats({
    required this.total,
    required this.active,
    required this.expired,
    required this.revoked,
    required this.expiringIn30Days,
  });
  
  factory CertificateStats.empty() => CertificateStats(
    total: 0,
    active: 0,
    expired: 0,
    revoked: 0,
    expiringIn30Days: 0,
  );
}

class NotificationTemplateStats {
  final int total;
  final int active;
  final int draft;
  final int inactive;
  final int emailTemplates;
  final int pushTemplates;
  final int smsTemplates;
  final int inAppTemplates;

  NotificationTemplateStats({
    required this.total,
    required this.active,
    required this.draft,
    required this.inactive,
    required this.emailTemplates,
    required this.pushTemplates,
    required this.smsTemplates,
    required this.inAppTemplates,
  });
  
  factory NotificationTemplateStats.empty() => NotificationTemplateStats(
    total: 0,
    active: 0,
    draft: 0,
    inactive: 0,
    emailTemplates: 0,
    pushTemplates: 0,
    smsTemplates: 0,
    inAppTemplates: 0,
  );
}
