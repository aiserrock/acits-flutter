import 'dart:typed_data';

enum UploadStatus { pending, uploading, success, failure }

class UploadTask {
  const UploadTask({required this.id, required this.name, this.bytes, this.path});

  final String id;
  final String name;
  final Uint8List? bytes;
  final String? path;
}

class UploadProgress {
  const UploadProgress({required this.taskId, required this.fraction, required this.status});

  final String taskId;

  /// Прогресс 0..1.
  final double fraction;
  final UploadStatus status;
}

class UploadResult {
  const UploadResult({required this.taskId, required this.success, this.error});

  final String taskId;
  final bool success;
  final Object? error;
}

abstract interface class PhotoUploadService {
  Future<void> enqueue(List<UploadTask> tasks);
  Stream<UploadProgress> get progress;
  Future<void> cancel(String taskId);
}
