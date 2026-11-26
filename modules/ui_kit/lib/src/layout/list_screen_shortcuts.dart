import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Keyboard shortcuts of a list screen, for tablets with a keyboard and desktop
/// browsers:
///
/// * `/`, Ctrl/⌘+F — [onSearch];
/// * Ctrl/⌘+N — [onCreate];
/// * F5, Ctrl/⌘+R — [onRefresh];
/// * Escape — [onEscape] (e.g. close the search field).
///
/// A null callback disables its shortcut. Shortcuts fire only while focus is
/// inside [child] and not in a text field — typing `/` in a search box stays
/// text.
class ListScreenShortcuts extends StatelessWidget {
  const ListScreenShortcuts({
    required this.child,
    this.onSearch,
    this.onCreate,
    this.onRefresh,
    this.onEscape,
    super.key,
  });

  final Widget child;
  final VoidCallback? onSearch;
  final VoidCallback? onCreate;
  final VoidCallback? onRefresh;
  final VoidCallback? onEscape;

  static bool get _isApple => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => true,
    _ => false,
  };

  SingleActivator _cmd(LogicalKeyboardKey key) =>
      _isApple ? SingleActivator(key, meta: true) : SingleActivator(key, control: true);

  /// Whether keyboard focus sits in a text field, where `/` and plain keys are
  /// text. The focused node belongs to the field's internals, so look up from it.
  static bool _typingInText() {
    final focused = FocusManager.instance.primaryFocus?.context;
    if (focused == null) return false;
    if (focused.widget is EditableText) return true;
    return focused.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback? outsideText(VoidCallback? action) => action == null
        ? null
        : () {
            if (_typingInText()) return;
            action();
          };

    final search = outsideText(onSearch);
    final create = outsideText(onCreate);
    final refresh = outsideText(onRefresh);
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.slash): ?search,
        _cmd(LogicalKeyboardKey.keyF): ?onSearch,
        _cmd(LogicalKeyboardKey.keyN): ?create,
        const SingleActivator(LogicalKeyboardKey.f5): ?refresh,
        _cmd(LogicalKeyboardKey.keyR): ?refresh,
        const SingleActivator(LogicalKeyboardKey.escape): ?onEscape,
      },
      // Gives the screen a focus target so shortcuts work before anything is
      // tapped, but only when nothing inside asks for focus itself: an
      // autofocused search field keeps its focus.
      child: FocusScope(autofocus: true, child: child),
    );
  }
}
