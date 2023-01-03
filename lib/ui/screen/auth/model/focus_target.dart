enum FocusTarget {
  name,
  password,
  another,
}

extension FocusTargetX on FocusTarget {
  bool get isPassword => this == FocusTarget.password;
  bool get isName => this == FocusTarget.name;
}
