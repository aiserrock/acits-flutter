import 'dto/applicant_dto.dart';
import 'dto/applicant_write_dto.dart';
import 'dto/curator_dto.dart';
import 'dto/curator_write_dto.dart';

/// Stable port for the staff slice (applicants + curators) — expressed in OUR
/// DTOs.
///
/// Never mentions the generated swagger_parser types; swapping the generator
/// means writing a new adapter that implements this interface, with zero
/// changes to ports, DTOs, or features. All calls are authed and scoped by
/// [shelterId] (the `x-current-shelter` header). List calls return the
/// unwrapped `results` list (pagination envelope handled by the adapter).
abstract interface class StaffApiPort {
  /// `GET /api/v1/applicants/` — applicants for the shelter, filtered by [search].
  Future<List<ApplicantDto>> listApplicants({String? search, int? limit, int? offset, int? shelterId});

  /// `GET /api/v1/applicants/{id}/` — a single applicant.
  Future<ApplicantDto> getApplicant(int id, {int? shelterId});

  /// `POST /api/v1/applicants/` — creates an applicant; returns the created one.
  Future<ApplicantDto> createApplicant(ApplicantWriteDto body, {int? shelterId});

  /// `PUT /api/v1/applicants/{id}/` — replaces an applicant; returns the updated one.
  Future<ApplicantDto> updateApplicant(int id, ApplicantWriteDto body, {int? shelterId});

  /// `GET /api/v1/curators/` — curators for the shelter, filtered by [search].
  Future<List<CuratorDto>> listCurators({String? search, int? limit, int? offset, int? shelterId});

  /// `GET /api/v1/curators/{id}/` — a single curator.
  Future<CuratorDto> getCurator(int id, {int? shelterId});

  /// `POST /api/v1/curators/` — creates a curator; returns the created one.
  Future<CuratorDto> createCurator(CuratorWriteDto body, {int? shelterId});

  /// `PUT /api/v1/curators/{id}/` — replaces a curator; returns the updated one.
  Future<CuratorDto> updateCurator(int id, CuratorWriteDto body, {int? shelterId});
}
