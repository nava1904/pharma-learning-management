import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// Training Batch management endpoint for Admin Portal.
/// Manages training batches/cohorts for instructor-led training.
class TrainingBatchEndpoint extends Endpoint {
  /// List all training batches for an organization.
  Future<List<TrainingBatch>> listBatches(
    Session session, {
    required int organizationId,
    String? status,
    int? courseVersionId,
    int? limit,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    
    var whereExpr = TrainingBatch.t.organizationId.equals(organizationId);
    
    if (status != null && status.isNotEmpty) {
      whereExpr = whereExpr & TrainingBatch.t.status.equals(status);
    }
    
    if (courseVersionId != null) {
      whereExpr = whereExpr & TrainingBatch.t.courseVersionId.equals(courseVersionId);
    }
    
    return await TrainingBatch.db.find(
      session,
      where: (t) => whereExpr,
      include: TrainingBatch.include(
        organization: Organization.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        instructor: PharmaUser.include(),
      ),
      orderBy: (t) => t.startDate,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Get a single training batch by ID.
  Future<TrainingBatch?> getBatch(Session session, int batchId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return null;
    
    return await TrainingBatch.db.findById(
      session,
      batchId,
      include: TrainingBatch.include(
        organization: Organization.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        instructor: PharmaUser.include(),
      ),
    );
  }

  /// Create a new training batch.
  Future<TrainingBatch?> createBatch(
    Session session, {
    required int organizationId,
    required int courseVersionId,
    required String name,
    int? instructorId,
    required DateTime startDate,
    required DateTime endDate,
    required int capacity,
    String? location,
    String? notes,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'create')) return null;
    
    final batch = TrainingBatch(
      organizationId: organizationId,
      courseVersionId: courseVersionId,
      name: name,
      instructorId: instructorId ?? 0,
      startDate: startDate,
      endDate: endDate,
      capacity: capacity,
      enrolledCount: 0,
      completedCount: 0,
      status: 'scheduled',
      location: location,
      notes: notes,
    );
    
    return await TrainingBatch.db.insertRow(session, batch);
  }

  /// Update a training batch.
  Future<TrainingBatch?> updateBatch(
    Session session,
    int batchId, {
    String? name,
    int? instructorId,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    String? status,
    String? location,
    String? notes,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return null;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'update')) return null;
    
    final existing = await TrainingBatch.db.findById(session, batchId);
    if (existing == null) return null;
    
    final updated = existing.copyWith(
      name: name ?? existing.name,
      instructorId: instructorId ?? existing.instructorId,
      startDate: startDate ?? existing.startDate,
      endDate: endDate ?? existing.endDate,
      capacity: capacity ?? existing.capacity,
      status: status ?? existing.status,
      location: location ?? existing.location,
      notes: notes ?? existing.notes,
    );
    
    return await TrainingBatch.db.updateRow(session, updated);
  }

  /// Delete a training batch.
  Future<bool> deleteBatch(Session session, int batchId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'delete')) return false;
    
    final deleted = await TrainingBatch.db.deleteWhere(
      session,
      where: (t) => t.id.equals(batchId),
    );
    
    return deleted.isNotEmpty;
  }

  /// Get batch statistics for dashboard.
  Future<Map<String, int>> getBatchStats(Session session, int organizationId) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return {};
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return {};
    
    final batches = await TrainingBatch.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    
    return {
      'total': batches.length,
      'scheduled': batches.where((b) => b.status == 'scheduled').length,
      'in_progress': batches.where((b) => b.status == 'in_progress').length,
      'completed': batches.where((b) => b.status == 'completed').length,
      'cancelled': batches.where((b) => b.status == 'cancelled').length,
    };
  }
}
