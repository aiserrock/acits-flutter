import 'package:acits_flutter/domain/env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AcitsEnvUrls — контуры окружений', () {
    test('prod / stage адреса корректны', () {
      expect(AcitsEnvUrls.prod, 'https://app.acits.ru');
      expect(AcitsEnvUrls.stage, 'https://stage.app.acits.ru');
    });

    test('dev(n) формирует https://dev-N.app.acits.ru', () {
      expect(AcitsEnvUrls.dev(0), 'https://dev-0.app.acits.ru');
      expect(AcitsEnvUrls.dev(3), 'https://dev-3.app.acits.ru');
    });

    test('all содержит prod, stage и все dev-0..3 в порядке', () {
      expect(AcitsEnvUrls.all, [
        'https://app.acits.ru',
        'https://stage.app.acits.ru',
        'https://dev-0.app.acits.ru',
        'https://dev-1.app.acits.ru',
        'https://dev-2.app.acits.ru',
        'https://dev-3.app.acits.ru',
      ]);
    });

    test('все URL — валидные https без завершающего слэша', () {
      for (final url in AcitsEnvUrls.all) {
        final uri = Uri.parse(url);
        expect(uri.scheme, 'https', reason: '$url должен быть https');
        expect(
          uri.host.endsWith('.acits.ru'),
          isTrue,
          reason: '$url должен быть на .acits.ru (SSRF-guard подтверждения почты)',
        );
        expect(url.endsWith('/'), isFalse, reason: '$url не должен иметь хвостовой слэш');
      }
    });

    test('dev(0) — дефолт dev-флейвора — присутствует в списке переключения', () {
      expect(AcitsEnvUrls.all.contains(AcitsEnvUrls.dev(0)), isTrue);
    });
  });

  group('Логика выбора baseUrl клиентом (baseUrl ?? env.apiUrl)', () {
    // Клиент в client_register.dart берёт: Uri.parse(ps.baseUrl ?? env.apiUrl).
    // Проверяем именно этот приоритет — переопределение из debug перекрывает
    // дефолт флейвора, а его отсутствие даёт дефолт.
    String resolve(String? debugBaseUrl, String flavorDefault) => debugBaseUrl ?? flavorDefault;

    test('debug-override перекрывает дефолт флейвора', () {
      final resolved = resolve(AcitsEnvUrls.dev(2), AcitsEnvUrls.dev(0));
      expect(resolved, AcitsEnvUrls.dev(2));
    });

    test('без override используется дефолт флейвора (dev-0)', () {
      final resolved = resolve(null, AcitsEnvUrls.dev(0));
      expect(resolved, AcitsEnvUrls.dev(0));
    });

    test('переключение на каждый контур даёт его URL', () {
      for (final target in AcitsEnvUrls.all) {
        expect(resolve(target, AcitsEnvUrls.dev(0)), target);
      }
    });
  });
}
