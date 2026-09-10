import '../../ports/dto/applicant_dto.dart';
import '../../ports/dto/applicant_write_dto.dart';
import '../../ports/dto/curator_dto.dart';
import '../../ports/dto/curator_write_dto.dart';
import '../../ports/staff_api_port.dart';
import 'generated/clients/applicants_client.dart';
import 'generated/clients/curators_client.dart';
import 'generated/models/applicant.dart';
import 'generated/models/curator.dart';

/// The ONLY place generated swagger_parser code is touched for the staff slice.
///
/// Applicants and curators map cleanly onto the typed generated clients, so
/// every call goes through them. Create/update reuse the generated read model
/// as the write body — exactly as the previous chopper code did (server-only
/// fields are read-only and ignored). Swapping generators = replace this file
/// with a new adapter implementing [StaffApiPort].
class StaffApiAdapter implements StaffApiPort {
  const StaffApiAdapter(this._applicants, this._curators);

  final ApplicantsClient _applicants;
  final CuratorsClient _curators;

  @override
  Future<List<ApplicantDto>> listApplicants({String? search, int? limit, int? offset, int? shelterId}) async {
    final page = await _applicants.v1ApplicantsList(
      xCurrentShelter: shelterId,
      search: search,
      limit: limit,
      offset: offset,
    );
    final results = page.results ?? const <Applicant>[];
    return results.map(_mapApplicant).toList(growable: false);
  }

  @override
  Future<ApplicantDto> getApplicant(int id, {int? shelterId}) async {
    final result = await _applicants.v1ApplicantsRetrieve(id: id, xCurrentShelter: shelterId);
    return _mapApplicant(result);
  }

  @override
  Future<ApplicantDto> createApplicant(ApplicantWriteDto body, {int? shelterId}) async {
    final result = await _applicants.v1ApplicantsCreate(body: _applicantBody(body), xCurrentShelter: shelterId);
    return _mapApplicant(result);
  }

  @override
  Future<ApplicantDto> updateApplicant(int id, ApplicantWriteDto body, {int? shelterId}) async {
    final result = await _applicants.v1ApplicantsUpdate(id: id, body: _applicantBody(body), xCurrentShelter: shelterId);
    return _mapApplicant(result);
  }

  @override
  Future<List<CuratorDto>> listCurators({String? search, int? limit, int? offset, int? shelterId}) async {
    final page = await _curators.v1CuratorsList(
      xCurrentShelter: shelterId,
      search: search,
      limit: limit,
      offset: offset,
    );
    final results = page.results ?? const <Curator>[];
    return results.map(_mapCurator).toList(growable: false);
  }

  @override
  Future<CuratorDto> getCurator(int id, {int? shelterId}) async {
    final result = await _curators.v1CuratorsRetrieve(id: id, xCurrentShelter: shelterId);
    return _mapCurator(result);
  }

  @override
  Future<CuratorDto> createCurator(CuratorWriteDto body, {int? shelterId}) async {
    final result = await _curators.v1CuratorsCreate(body: _curatorBody(body), xCurrentShelter: shelterId);
    return _mapCurator(result);
  }

  @override
  Future<CuratorDto> updateCurator(int id, CuratorWriteDto body, {int? shelterId}) async {
    final result = await _curators.v1CuratorsUpdate(id: id, body: _curatorBody(body), xCurrentShelter: shelterId);
    return _mapCurator(result);
  }

  // ── OUR write-DTO → generated body ──────────────────────────────────────────

  // `shelter` and the audit fields are required by the generated read model but
  // read-only server-side, so harmless placeholders keep the wire body
  // identical to the chopper one (which posted the whole record back).
  static final _epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  Applicant _applicantBody(ApplicantWriteDto d) => Applicant(
    id: d.id ?? 0,
    url: '',
    shelter: d.shelter ?? 0,
    firstName: d.firstName,
    lastName: d.lastName,
    email: d.email,
    phoneNumber: d.phoneNumber,
    contactDetails: d.contactDetails,
    createdBy: '',
    updatedBy: '',
    createdAt: _epoch,
    updatedAt: _epoch,
  );

  Curator _curatorBody(CuratorWriteDto d) => Curator(
    id: d.id ?? 0,
    url: '',
    shelter: d.shelter ?? '',
    firstName: d.firstName,
    lastName: d.lastName,
    email: d.email,
    phoneNumber: d.phoneNumber,
    address: d.address,
    createdBy: '',
    updatedBy: '',
    createdAt: _epoch,
    updatedAt: _epoch,
  );

  // ── generated → OUR read DTO ────────────────────────────────────────────────

  ApplicantDto _mapApplicant(Applicant a) => ApplicantDto(
    id: a.id ?? 0,
    url: a.url,
    shelter: a.shelter,
    firstName: a.firstName,
    lastName: a.lastName,
    email: a.email,
    phoneNumber: a.phoneNumber,
    contactDetails: a.contactDetails,
    createdBy: a.createdBy,
    updatedBy: a.updatedBy,
    createdAt: a.createdAt,
    updatedAt: a.updatedAt,
    animalId: a.animalId,
    applicantFiles: a.applicantFiles?.map((f) => f.toJson()).toList(growable: false),
  );

  CuratorDto _mapCurator(Curator c) => CuratorDto(
    id: c.id ?? 0,
    url: c.url,
    shelter: c.shelter,
    firstName: c.firstName,
    lastName: c.lastName,
    email: c.email,
    phoneNumber: c.phoneNumber,
    address: c.address,
    createdBy: c.createdBy,
    updatedBy: c.updatedBy,
    createdAt: c.createdAt,
    updatedAt: c.updatedAt,
  );
}
