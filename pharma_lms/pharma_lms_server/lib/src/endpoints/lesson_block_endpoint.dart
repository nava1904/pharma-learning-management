import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/rbac_helper.dart';

class LessonBlockEndpoint extends Endpoint {
  Future<List<LessonBlock>> listBlocks(
    Session session, {
    required int lessonId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    return await LessonBlock.db.find(
      session,
      where: (t) => t.lessonId.equals(lessonId),
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<LessonBlock> createBlock(
    Session session, {
    required int lessonId,
    required String blockType,
    required String contentJson,
    int orderIndex = 0,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final block = LessonBlock(
      lessonId: lessonId,
      blockType: blockType,
      contentJson: contentJson,
      orderIndex: orderIndex,
    );
    final result = await LessonBlock.db.insertRow(session, block);
    await AuditService.log(
      session,
      entityType: 'lesson_block',
      entityId: result.id.toString(),
      action: 'LessonBlockCreated',
      newValueJson: '{"lessonId":$lessonId,"blockType":"$blockType","orderIndex":$orderIndex}',
    );
    return result;
  }

  Future<LessonBlock> updateBlock(
    Session session, {
    required int blockId,
    String? contentJson,
    int? orderIndex,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final block = await LessonBlock.db.findById(session, blockId);
    if (block == null) throw Exception('Block not found');
    final updated = block.copyWith(
      contentJson: contentJson ?? block.contentJson,
      orderIndex: orderIndex ?? block.orderIndex,
    );
    final result = await LessonBlock.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'lesson_block',
      entityId: blockId.toString(),
      action: 'LessonBlockUpdated',
      oldValueJson: jsonEncode({
        'lessonId': block.lessonId,
        'blockType': block.blockType,
        'orderIndex': block.orderIndex,
        ..._lessonBlockContentAuditFields(block.contentJson),
      }),
      newValueJson: jsonEncode({
        'lessonId': result.lessonId,
        'blockType': result.blockType,
        'orderIndex': result.orderIndex,
        ..._lessonBlockContentAuditFields(result.contentJson),
      }),
    );
    return result;
  }

  Future<bool> deleteBlock(
    Session session, {
    required int blockId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final block = await LessonBlock.db.findById(session, blockId);
    if (block == null) throw Exception('Block not found');
    await LessonBlock.db.deleteRow(session, block);
    await AuditService.log(
      session,
      entityType: 'lesson_block',
      entityId: blockId.toString(),
      action: 'LessonBlockDeleted',
      oldValueJson: '{"blockType":"${block.blockType}","lessonId":${block.lessonId}}',
    );
    return true;
  }

  Future<bool> reorderBlocks(
    Session session, {
    required int lessonId,
    required List<int> blockIds,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    for (int i = 0; i < blockIds.length; i++) {
      final block = await LessonBlock.db.findById(session, blockIds[i]);
      if (block == null) continue;
      if (block.lessonId != lessonId) continue;
      final updated = block.copyWith(orderIndex: i);
      await LessonBlock.db.updateRow(session, updated);
    }
    return true;
  }
}

/// Avoid storing full block HTML/JSON in audit rows; log length + hash prefix only.
Map<String, dynamic> _lessonBlockContentAuditFields(String? contentJson) {
  final s = contentJson ?? '';
  final hash = sha256.convert(utf8.encode(s)).toString();
  return {
    'contentLen': s.length,
    'contentSha256Prefix': hash.substring(0, 16),
  };
}
