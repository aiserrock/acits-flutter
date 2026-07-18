import 'dart:async';

import 'package:base/base.dart';
import 'package:ui_kit/acits_ui_kit.dart';
import 'package:animals/animals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AnimalRepository {}

class _FakeShelter implements CurrentShelterProvider {
  @override
  int? get shelterId => 50;
}

class _NoopRouter implements AnimalsRouterService {
  @override
  void openDetail(int id) {}
  @override
  Future<bool?> openCreate() async => false;
  @override
  void openEdit(int id) {}
  @override
  void openAnimalPdf(int id) {}
}

class _AllPermissions implements AnimalPermissions {
  @override
  bool get canEdit => true;
  @override
  bool get canDelete => true;
}

class _StubLabels implements AnimalStatusLabels {
  @override
  String? label(AnimalStatus status) => 'В приюте';
}

AnimalListItem _item(int id) => AnimalListItem(
  id: id,
  name: 'Барсик$id',
  status: AnimalStatus.inTheShelter,
  speciesParentName: 'Кошки',
  speciesName: 'Кошка домашняя',
  dateJoined: DateTime.utc(2024, 1, 15),
);

void _stubList(_MockRepo repo, Result<Failure, List<AnimalListItem>> result) {
  when(
    () => repo.list(
      shelterId: any(named: 'shelterId'),
      search: any(named: 'search'),
      ordering: any(named: 'ordering'),
      limit: any(named: 'limit'),
      offset: any(named: 'offset'),
    ),
  ).thenAnswer((_) async => result);
}

Widget _wrap(AnimalsCubit cubit) {
  return MaterialApp(
    theme: AppTheme.light,
    home: BlocProvider.value(
      value: cubit,
      child: AnimalsView(router: _NoopRouter(), permissions: _AllPermissions(), statusLabels: _StubLabels()),
    ),
  );
}

void main() {
  late _MockRepo repo;
  final shelter = _FakeShelter();

  setUp(() => repo = _MockRepo());

  testWidgets('renders cards from content state', (tester) async {
    _stubList(repo, Ok([_item(1), _item(2)]));
    final cubit = AnimalsCubit(repo, shelter);
    addTearDown(cubit.close);

    await tester.pumpWidget(_wrap(cubit));
    await tester.pump(); // отработать первую загрузку

    expect(find.byType(AnimalCardWidget), findsNWidgets(2));
  });

  testWidgets('shows empty state when list is empty', (tester) async {
    _stubList(repo, const Ok(<AnimalListItem>[]));
    final cubit = AnimalsCubit(repo, shelter);
    addTearDown(cubit.close);

    await tester.pumpWidget(_wrap(cubit));
    await tester.pump();

    expect(find.byType(AnimalCardWidget), findsNothing);
    // Пустое состояние = RefreshIndicator со скроллом, без карточек.
    expect(find.byType(RefreshIndicator), findsWidgets);
  });

  testWidgets('shows skeleton loader while loading', (tester) async {
    // list() «висит» (Completer без завершения) → состояние остаётся loading,
    // без pending-таймеров, которые ломают тест.
    final completer = Completer<Result<Failure, List<AnimalListItem>>>();
    when(
      () => repo.list(
        shelterId: any(named: 'shelterId'),
        search: any(named: 'search'),
        ordering: any(named: 'ordering'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) => completer.future);
    final cubit = AnimalsCubit(repo, shelter);
    addTearDown(() {
      if (!completer.isCompleted) completer.complete(const Ok(<AnimalListItem>[]));
      cubit.close();
    });

    await tester.pumpWidget(_wrap(cubit));
    await tester.pump();

    expect(find.byType(Skeleton), findsWidgets);
  });
}
