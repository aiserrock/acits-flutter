/// Core module: domain + api. Merges the former `acits_domain` (entities,
/// exceptions, the [Transformable] mapper contract, repository interfaces,
/// RouterService base) with the former `acits_api` (ports, our DTOs, and the
/// swagger_parser adapter binding).
///
/// Depends on `base` only (Dio/Result) — never on any feature module.
library;

export 'domain.dart';
export 'api.dart';
