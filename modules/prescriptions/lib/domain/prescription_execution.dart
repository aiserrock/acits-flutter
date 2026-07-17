/// Доменная модель исполнения назначения (одна доза/процедура во времени).
class PrescriptionExecution {
  const PrescriptionExecution({required this.executeAt, this.id, this.status});

  final int? id;
  final DateTime executeAt;

  /// Серверный статус исполнения (`IN_PROGRESS`/`DONE`/…), сырой wire-строкой.
  final String? status;

  PrescriptionExecution copyWith({int? id, DateTime? executeAt, String? status}) {
    return PrescriptionExecution(
      id: id ?? this.id,
      executeAt: executeAt ?? this.executeAt,
      status: status ?? this.status,
    );
  }
}
