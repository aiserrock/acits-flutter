/// What the installed build has to do before the app can be used.
enum UpdateRequirement {
  /// Nothing: carry on.
  none,

  /// A newer build is available; the user may skip it.
  recommended,

  /// This build is too old to talk to the backend: update or stop.
  required,

  /// The app is switched off for every build (kill-switch), e.g. during an
  /// incident on the backend. Nothing to install; try again later.
  blocked,
}

/// Remote limits for the installed build, compared by build number.
///
/// Build numbers are shared by the three stores and only grow (see
/// `doc/release.md`), so a single integer orders every release.
class UpdateLimits {
  const UpdateLimits({this.minSupportedBuild = 0, this.recommendedBuild = 0, this.killSwitch = false, this.message});

  /// Builds below this one must update.
  final int minSupportedBuild;

  /// Builds below this one are told an update is available.
  final int recommendedBuild;

  /// Switches the app off for everyone.
  final bool killSwitch;

  /// Optional text shown on the blocking screen (already localised remotely).
  final String? message;

  /// Requirement for [build]. An unknown build (0: web, or a dev run without a
  /// build number) is never forced to update: only the kill-switch applies.
  UpdateRequirement requirementFor(int build) {
    if (killSwitch) return UpdateRequirement.blocked;
    if (build <= 0) return UpdateRequirement.none;
    if (build < minSupportedBuild) return UpdateRequirement.required;
    if (build < recommendedBuild) return UpdateRequirement.recommended;
    return UpdateRequirement.none;
  }
}

/// Port to the remote update policy.
abstract interface class AppUpdatePolicy {
  /// The requirement for this build. Must never throw and must answer
  /// [UpdateRequirement.none] when the remote source is unreachable: a
  /// network problem may not lock users out.
  Future<UpdateRequirement> check();

  /// Message for the blocking screen, when the remote source provides one.
  String? get message;

  /// Opens the store page of the app for this platform.
  Future<void> openStore();
}
