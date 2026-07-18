import 'package:navigation/acits_navigation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Routes builders', () {
    test('animal detail/edit paths', () {
      expect(Routes.animalDetailPath(42), '/animals/42');
      expect(Routes.animalEditPath(42), '/animals/42/edit');
    });

    test('nested animal sub-routes', () {
      expect(Routes.commentsPath(7), '/animals/7/comments');
      expect(Routes.photosPath(7), '/animals/7/photos');
    });

    test('search carries type in query', () {
      expect(Routes.searchPath('animal'), '/search?type=animal');
    });
  });

  group('RouteParams', () {
    test('requireId parses path int', () {
      expect(RouteParams.requireId({'id': '42'}), 42);
    });

    test('requireId throws on non-int', () {
      expect(() => RouteParams.requireId({'id': 'x'}), throwsArgumentError);
      expect(() => RouteParams.requireId(const {}), throwsArgumentError);
    });

    test('optionalInt tolerates missing/invalid', () {
      expect(RouteParams.optionalInt({'id': '5'}, 'id'), 5);
      expect(RouteParams.optionalInt(const {}, 'id'), isNull);
      expect(RouteParams.optionalInt({'id': 'x'}, 'id'), isNull);
    });

    test('boolFlag and optionalString', () {
      expect(RouteParams.boolFlag({'changePass': 'true'}, 'changePass'), isTrue);
      expect(RouteParams.boolFlag(const {}, 'changePass'), isFalse);
      expect(RouteParams.optionalString({'q': ''}, 'q'), isNull);
      expect(RouteParams.optionalString({'q': 'cat'}, 'q'), 'cat');
    });
  });

  group('AuthGuard', () {
    test('unauthenticated is redirected to login from a private route', () {
      final guard = AuthGuard(isAuthenticated: () => false);
      expect(guard.redirect(Routes.animals), Routes.login);
    });

    test('public routes pass through when unauthenticated', () {
      final guard = AuthGuard(isAuthenticated: () => false);
      expect(guard.redirect(Routes.login), isNull);
      expect(guard.redirect(Routes.splash), isNull);
    });

    test('authenticated passes through everywhere', () {
      final guard = AuthGuard(isAuthenticated: () => true);
      expect(guard.redirect(Routes.animals), isNull);
    });
  });
}
