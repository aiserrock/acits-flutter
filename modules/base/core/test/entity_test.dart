import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Curator', () {
    test('fullName joins first and last', () {
      const c = Curator(id: 1, firstName: 'Ann', lastName: 'Lee', phoneNumber: '+70000000000');
      expect(c.fullName, 'Ann Lee');
    });

    test('value equality by props', () {
      const a = Curator(id: 1, firstName: 'Ann', lastName: 'Lee', phoneNumber: '+7');
      const b = Curator(id: 1, firstName: 'Ann', lastName: 'Lee', phoneNumber: '+7');
      const c = Curator(id: 2, firstName: 'Ann', lastName: 'Lee', phoneNumber: '+7');
      expect(a, b);
      expect(a, isNot(c));
    });
  });

  group('Animal', () {
    Animal make({int id = 1}) =>
        Animal(id: id, name: 'Rex', shelterId: 50, dateJoined: DateTime(2024, 1, 1), sex: AnimalSex.male);

    test('equal when all props equal', () {
      expect(make(), make());
    });

    test('differ by id', () {
      expect(make(id: 1), isNot(make(id: 2)));
    });

    test('canBeShared defaults to false', () {
      expect(make().canBeShared, isFalse);
    });
  });
}
