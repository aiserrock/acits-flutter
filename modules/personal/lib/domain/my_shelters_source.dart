import 'package:core/domain.dart' show Shelter;
import 'package:util/util.dart' show Failure, Result;

/// Port of the «My organisations» screen: the shelters the signed-in user
/// belongs to and the one that is current. The app implements it over its
/// session service, so the feature module stays free of auth.
abstract interface class MySheltersSource {
  /// Loads the shelters the user belongs to.
  Future<Result<Failure, List<Shelter>>> load();

  /// Id of the shelter the session works in, `null` before one is picked.
  int? get currentShelterId;
}
