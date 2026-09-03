/// Shared data-layer helpers for repository implementations.
///
/// Imported by feature `data/` layers only — the seam where transport
/// exceptions become a typed [Failure]. Nothing above a repository imports it.
library;

export 'data/repository_guard.dart';
