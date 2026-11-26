import 'package:animals/animals.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:media/presentation/photo_gallery/photo_gallery.dart';
import 'package:mocktail/mocktail.dart';
import 'package:util/util.dart';

class _MockRepo extends Mock implements AnimalRepository {}

class _FakeShelter implements CurrentShelterProvider {
  @override
  int? get shelterId => 50;
}

const _animal = Animal(
  id: 501,
  name: 'Барсик',
  shelterId: 50,
  status: AnimalStatus.inTheShelter,
  images: [],
  attributes: {},
);

Future<void> _pumpGallery(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final repo = _MockRepo();
  when(() => repo.getById(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => const Ok(_animal));

  await tester.pumpWidget(
    MaterialApp(
      home: PhotoGalleryScreen(animalId: 501, repository: repo, shelterProvider: _FakeShelter()),
    ),
  );
  await tester.pump();
  await tester.pump();
}

SliverGridDelegate _delegate(WidgetTester tester) => tester.widget<GridView>(find.byType(GridView)).gridDelegate;

void main() {
  testWidgets('gallery shows 3 columns on a 390 px phone', (tester) async {
    await _pumpGallery(tester, const Size(390, 800));

    final layout = _delegate(tester).getLayout(
      const SliverConstraints(
        axisDirection: AxisDirection.down,
        growthDirection: GrowthDirection.forward,
        userScrollDirection: ScrollDirection.idle,
        scrollOffset: 0,
        precedingScrollExtent: 0,
        overlap: 0,
        remainingPaintExtent: 800,
        crossAxisExtent: 390 - 16,
        crossAxisDirection: AxisDirection.right,
        viewportMainAxisExtent: 800,
        remainingCacheExtent: 800,
        cacheOrigin: 0,
      ),
    );
    expect(layout, isA<SliverGridRegularTileLayout>());
    final regular = layout as SliverGridRegularTileLayout;
    expect(regular.crossAxisCount, 3);
    expect(regular.childCrossAxisExtent, regular.childMainAxisExtent, reason: 'tiles stay square');
  });

  testWidgets('gallery grows to 8 square columns on a 1300 px window', (tester) async {
    await _pumpGallery(tester, const Size(1300, 800));

    final layout = _delegate(tester).getLayout(
      const SliverConstraints(
        axisDirection: AxisDirection.down,
        growthDirection: GrowthDirection.forward,
        userScrollDirection: ScrollDirection.idle,
        scrollOffset: 0,
        precedingScrollExtent: 0,
        overlap: 0,
        remainingPaintExtent: 800,
        crossAxisExtent: 1300 - 16,
        crossAxisDirection: AxisDirection.right,
        viewportMainAxisExtent: 800,
        remainingCacheExtent: 800,
        cacheOrigin: 0,
      ),
    );
    final regular = layout as SliverGridRegularTileLayout;
    expect(regular.crossAxisCount, 8);
    expect(regular.childCrossAxisExtent, regular.childMainAxisExtent);
    expect(regular.childCrossAxisExtent, lessThanOrEqualTo(galleryTileMaxExtent));
  });
}
