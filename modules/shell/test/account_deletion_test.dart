import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shell/res/legal_links.dart';
import 'package:shell/widget/account_deletion.dart';

class _FakeDeletion implements AccountDeletion {
  _FakeDeletion({required this.sends});

  final bool sends;
  final requests = <(String, String)>[];

  @override
  Future<bool> request({required String email, required String shelter}) async {
    requests.add((email, shelter));
    return sends;
  }
}

void main() {
  test('the support mail goes to the support address with percent-encoded fields', () {
    final uri = SupportMailAccountDeletion.mailFor(email: 'user@example.org', shelter: 'Приют №1');

    expect(uri.scheme, 'mailto');
    expect(uri.path, LegalLinks.supportEmail);
    expect(uri.query, isNot(contains('+')));
    expect(uri.query, startsWith('subject='));
    expect(Uri.decodeComponent(uri.query), contains('user@example.org'));
    expect(Uri.decodeComponent(uri.query), contains('Приют №1'));
  });

  test('a launcher failure is reported as not sent', () async {
    final deletion = SupportMailAccountDeletion(launch: (_) async => throw Exception('no mail app'));
    expect(await deletion.request(email: 'a@b.c', shelter: 's'), isFalse);
  });

  group('confirmAccountDeletion', () {
    late bool signedOut;
    late List<Uri> opened;

    setUp(() {
      signedOut = false;
      opened = [];
    });

    Future<void> start(WidgetTester tester, AccountDeletion deletion) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => confirmAccountDeletion(
                  context,
                  deletion: deletion,
                  email: 'user@example.org',
                  shelter: 'Shelter',
                  onRequested: () => signedOut = true,
                  openPage: (uri) async {
                    opened.add(uri);
                    return true;
                  },
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    }

    Finder action(int index) =>
        find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextButton)).at(index);

    testWidgets('cancel sends nothing and keeps the session', (tester) async {
      final deletion = _FakeDeletion(sends: true);
      await start(tester, deletion);

      await tester.tap(action(0));
      await tester.pumpAndSettle();

      expect(deletion.requests, isEmpty);
      expect(signedOut, isFalse);
    });

    testWidgets('a sent request signs the user out', (tester) async {
      final deletion = _FakeDeletion(sends: true);
      await start(tester, deletion);

      await tester.tap(action(1));
      await tester.pumpAndSettle();

      expect(deletion.requests, [('user@example.org', 'Shelter')]);
      expect(signedOut, isTrue);
      expect(opened, isEmpty);
    });

    testWidgets('without a mail app the public deletion page opens and the session stays', (tester) async {
      await start(tester, _FakeDeletion(sends: false));

      await tester.tap(action(1));
      await tester.pumpAndSettle();

      expect(signedOut, isFalse);
      expect(opened, [LegalLinks.accountDeletion]);
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
