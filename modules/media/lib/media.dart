/// Media feature module: animal photo gallery + cross-platform photo editor,
/// the cross-platform PDF document viewer, and the generic cross-feature
/// search/picker (animals, applicants, curators, drugs, shelters, species) with
/// its paging adapters.
///
/// Public API barrel. Screens, the generic [Search] widget + its [SearchTypeKey]
/// / [SearchDeps], the [DocumentRepository] data service, the router contract
/// and platform ports (doc export / pdf.js ready / shelter provider) are
/// exported for the root app to wire. The module depends on the leaf feature
/// modules (animals/applicants/prescriptions) whose data its search pages — no
/// cycle: those modules do not import media.
library;

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
