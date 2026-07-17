/// Доменная модель препарата в назначении (имя + дозировка + форма).
class PrescriptionDrug {
  const PrescriptionDrug({
    required this.drugId,
    required this.drugName,
    required this.drugDosage,
    this.usageInstruction,
    this.formOfDrug,
  });

  final int drugId;
  final String drugName;
  final double drugDosage;
  final String? usageInstruction;
  final String? formOfDrug;
}
