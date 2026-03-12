import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/document_repository.dart';
import '../repositories/material_repository.dart';
import '../repositories/quality_event_repository.dart';
import '../repositories/training_repository.dart';

/// Training (enrollments, certificates, e-signatures, assignments).
final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  return TrainingRepository();
});

/// Quality events and CAPA.
final qualityEventRepositoryProvider = Provider<QualityEventRepository>((ref) {
  return QualityEventRepository();
});

/// Documents and lifecycle.
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepository();
});

/// Materials and progress.
final materialRepositoryProvider = Provider<MaterialRepository>((ref) {
  return MaterialRepository();
});
