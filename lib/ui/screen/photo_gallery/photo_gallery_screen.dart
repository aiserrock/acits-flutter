import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/widget/gallery_item_data_x.dart';

part './widget/corner_clipper.dart';
part './widget/gallery_item.dart';

const _maxCountImages = 6;

final _galleryImageSet = [
  Assets.gallery.avatarAlpaka,
  Assets.gallery.avatarCat0,
  Assets.gallery.avatarCat1,
  Assets.gallery.avatarDog,
  Assets.gallery.avatarDolphin,
  Assets.gallery.avatarEagle,
  Assets.gallery.avatarMouse,
];

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({
    required this.animalId,
    Key? key,
  }) : super(key: key);

  final int animalId;

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState(animalId);
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  _PhotoGalleryScreenState(this._animalId) : _animalService = getIt<AnimalService>();

  final int _animalId;
  final AnimalService _animalService;
  final _screenState = BehaviorSubject<WidgetState<List<GalleryItemData>>>()
    ..add(WidgetState()..loading());
  final _isSelectorChanged = BehaviorSubject<bool>.seeded(false);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _screenState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Choose the photos',
          style: TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
      ),
      floatingActionButton: StreamBuilder<bool>(
          stream: _isSelectorChanged,
          builder: (_, state) => (state.data ?? false)
              ? FloatingActionButton(
                  child: const Icon(
                    Icons.done_all,
                    color: Colors.white,
                  ),
                  onPressed: () => _submit(context),
                  backgroundColor: ColorRes.accent,
                )
              : const SizedBox()),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<WidgetState<List<GalleryItemData>>>(
      stream: _screenState.stream,
      builder: (_, v) {
        if (v.data?.hasError ?? false) return ErrorHolderWidget(onPressed: _init);
        if (v.data?.isContent ?? false) return _buildContent(v.data?.value);
        return const LoaderHolderWidget();
      },
    );
  }

  Widget _buildContent(List<GalleryItemData>? list) {
    list = list ?? [];
    return GridView(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      children: [
        _GalleryItemWidget(
          const Icon(
            Icons.add_a_photo_outlined,
            size: 48.0,
            color: ColorRes.accent,
          ),
          onPressed: () => _addPhoto(ImageSource.camera),
        ),
        _GalleryItemWidget(
          const Icon(
            Icons.photo_library_outlined,
            size: 48.0,
            color: ColorRes.accent,
          ),
          onPressed: () => _addPhoto(ImageSource.gallery),
        ),
        ...list.map<Widget>(
          (e) => _GalleryItemWidget(
            e.widget,
            onPressed: () => _chooseItem(e),
            isChoosed: e.isChoosed,
          ),
        ),
      ],
    );
  }

  Future<void> _init() async {
    _screenState.add(WidgetState()..loading());
    await _animalService.fetchAnimalDetail(id: _animalId).then((animal) {
      final items = <GalleryItemData>[
        ...(animal.images?.map<GalleryItemData>((e) => GalleryItemData.fromAnimalImage(e)) ?? []),
        ..._galleryImageSet.map<GalleryItemData>((e) => GalleryItemData(assetPath: e.path))
      ];
      _screenState.add(
        WidgetState(items.toList()),
      );
    }).catchError((e, _) {
      _screenState.add(WidgetState()..error = e);
    });
  }

  void _chooseItem(GalleryItemData item) {
    if (!_screenState.value.isContent) return;
    final currentList = _screenState.value.value;
    final index = currentList?.indexOf(item);
    if (index == null || index < 0) return;
    currentList?.replaceRange(index, index + 1, [item.copyWith(isChoosed: !item.isChoosed)]);
    _screenState.add(WidgetState(currentList));
    _isSelectorChanged.add(true);
  }

  void _addPhoto(ImageSource source) {
    if (!_screenState.value.isContent) return;
    ImagePicker().pickImage(source: source).then((xFile) {
      if (xFile == null) return;
      _screenState.add(
        WidgetState(
          _screenState.value.value
            ?..insert(
              0,
              GalleryItemData(
                filePath: xFile.path,
                isChoosed: true,
              ),
            ),
        ),
      );
      _isSelectorChanged.add(true);
    });
  }

  void _submit(BuildContext context) {
    final list = _screenState.value.value;
    if (list == null) return;
    if (list.countChoosedItems > 6) {
      final ctx = _scaffoldKey.currentContext ?? context;
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Max count images for animal is $_maxCountImages'),
        ),
      );
      return;
    }
    _screenState.add(WidgetState()..loading());
    _animalService
        .changeAnimalPhotos(
          _animalId,
          list,
        )
        .then((_) => Navigator.of(context).pop(true))
        .catchError(
      (e, _) {
        _screenState.add(WidgetState()..error = e);
      },
    );
  }
}
