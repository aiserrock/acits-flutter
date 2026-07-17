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

// Data
export 'data/document_repository.dart';

// Domain: ports + router contract + pdf fetcher typedef
export 'domain/pdf_doc_mixin.dart' show PdfDocFetcher, PdfDocumentMixin;
export 'domain/port/doc_exporter_port.dart';
export 'domain/port/media_shelter_provider.dart';
export 'domain/port/pdfjs_ready_port.dart';
export 'domain/router/media_router_service.dart';

// Domain: photo gallery item model (consumed by cubit; exported for tests)
export 'domain/gallery_item_data.dart';

// UI: screens
export 'ui/doc_viewer/cubit/doc_viewer_cubit.dart';
export 'ui/doc_viewer/doc_viewer_screen.dart';
export 'ui/photo_editor/photo_editor_screen.dart';
export 'ui/photo_gallery/cubit/photo_gallery_cubit.dart';
export 'ui/photo_gallery/cubit/photo_gallery_state.dart';
export 'ui/photo_gallery/photo_gallery_screen.dart';
export 'ui/search/cubit/search_spec_cubit.dart';
export 'ui/search/cubit/search_spec_state.dart';
export 'ui/search/search.dart' show Search, SearchTypeKey, SearchDeps, PagingFetchAdapter;
export 'ui/search/search_spec_screen.dart';
