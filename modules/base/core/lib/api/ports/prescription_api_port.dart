import 'dto/drug_dto.dart';
import 'dto/prescription_dto.dart';
import 'dto/prescription_execution_today_dto.dart';
import 'dto/prescription_write_dto.dart';

/// Stable port for the prescriptions + drugs slice — expressed in OUR DTOs.
///
/// Never mentions the generated swagger_parser types; swapping the generator
/// means writing a new adapter that implements this interface, with zero
/// changes to ports, DTOs, or features.
abstract interface class PrescriptionApiPort {
  /// Lists prescriptions for an animal. [isActual]/[isOld] map to the local-day
  /// `execute_at` window filters the backend expects. Returns the unwrapped
  /// `results` list (pagination envelope handled by the adapter).
  Future<List<PrescriptionDto>> listByAnimal(
    int animalId, {
    bool? isActual,
    bool? isOld,
    int? limit,
    int? offset,
    int? shelterId,
  });

  /// Lists prescription executions scheduled for "today" (main feed).
  Future<List<PrescriptionExecutionTodayDto>> todayExecutions({
    String? search,
    String? ordering,
    int? limit,
    int? offset,
    int? shelterId,
  });

  /// Fetches a single prescription by its numeric [id].
  Future<PrescriptionDto> getById(int id, {int? shelterId});

  /// Creates a prescription from [body]; returns the created prescription.
  Future<PrescriptionDto> create(PrescriptionWriteDto body, {int? shelterId});

  /// Replaces the prescription [id] with [body]; returns the updated one.
  Future<PrescriptionDto> update(int id, PrescriptionWriteDto body, {int? shelterId});

  /// Lists drugs from the shelter catalogue, filtered by [search].
  Future<List<DrugDto>> listDrugs({String? search, int? limit, int? offset, int? shelterId});
}
