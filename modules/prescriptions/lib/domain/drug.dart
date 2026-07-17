/// Доменная модель препарата из каталога приюта (поиск/пикер).
///
/// Плоская: поля каталожного препарата плюс опциональный остаток на складе.
class Drug {
  const Drug({
    required this.id,
    required this.name,
    required this.formOfDrug,
    required this.formOfDrugName,
    this.usageInstruction,
    this.drugResiduesCount,
  });

  final int id;
  final String name;
  final String? usageInstruction;
  final int formOfDrug;
  final String formOfDrugName;
  final int? drugResiduesCount;
}
