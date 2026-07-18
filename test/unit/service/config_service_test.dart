import 'package:core/api.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/service/shared_pref/preference_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSelectionApiPort extends Mock implements SelectionApiPort {}

class MockAuthService extends Mock implements AuthService {}

class MockPreferenceStorage extends Mock implements PreferenceStorage {}

SelectionValuesDto _values() => SelectionValuesDto({
  'animal_status': [
    {'value': 'IN_THE_SHELTER', 'display_name': 'В приюте'},
    {'value': 'RELEASED', 'display_name': 'Выпущено'},
  ],
  'prescription_types': [
    {'value': 'VACCINATION', 'display_name': 'Вакцинация'},
  ],
});

void main() {
  late MockSelectionApiPort port;
  late MockAuthService auth;
  late MockPreferenceStorage prefs;
  late ConfigService service;

  setUp(() {
    port = MockSelectionApiPort();
    auth = MockAuthService();
    prefs = MockPreferenceStorage();
    when(() => auth.currentShelterId).thenReturn(50);
    service = ConfigService(port, auth, prefs);
  });

  test('getTypeValues stores the raw body and drives status/type name lookup by wire', () async {
    when(() => port.valuesForSelection(shelterId: any(named: 'shelterId'))).thenAnswer((_) async => _values());

    await service.getTypeValues();

    expect(service.getStatus131Name('IN_THE_SHELTER'), 'В приюте');
    expect(service.getStatus131Name('RELEASED'), 'Выпущено');
    expect(service.getMyTypeName('VACCINATION'), 'Вакцинация');
    // Unknown wire → null (no crash).
    expect(service.getStatus131Name('SOME_FUTURE'), isNull);
    expect(service.getStatus131Name(null), isNull);
  });

  test('getAnimalAttr caches per shelter and returns the attribute catalog', () async {
    when(
      () => port.animalAttributes(shelterId: any(named: 'shelterId')),
    ).thenAnswer((_) async => const [AttributeDto(id: 1, name: 'sex', isRequired: true)]);

    final first = await service.getAnimalAttr();
    expect(first.single.name, 'sex');
    expect(service.animalAttributes, isNotNull);

    // Second call for the same shelter is served from cache.
    await service.getAnimalAttr();
    verify(() => port.animalAttributes(shelterId: 50)).called(1);
  });
}
