import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:acits_flutter/domain/gallery_item_data.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/cubit/photo_gallery_cubit.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/cubit/photo_gallery_state.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/widget/gallery_item_data_x.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';

part './widget/corner_clipper.dart';
part './widget/gallery_item.dart';

const _maxCountImages = 6;

/// Экран выбора фотографий животного.
class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({required this.animalId, super.key});

  final int animalId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoGalleryCubit(animalId: animalId),
      child: const _PhotoGalleryView(),
    );
  }
}

class _PhotoGalleryView extends StatefulWidget {
  const _PhotoGalleryView();

  @override
  State<_PhotoGalleryView> createState() => _PhotoGalleryViewState();
}

class _PhotoGalleryViewState extends State<_PhotoGalleryView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Choose the photos',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      floatingActionButton: BlocBuilder<PhotoGalleryCubit, PhotoGalleryState>(
        buildWhen: (prev, next) => prev.isSelectorChanged != next.isSelectorChanged,
        builder: (_, state) => state.isSelectorChanged
            ? FloatingActionButton(
                onPressed: _onSubmit,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.done_all, color: Theme.of(context).colorScheme.onPrimary),
              )
            : const SizedBox(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PhotoGalleryCubit, PhotoGalleryState>(
      buildWhen: (prev, next) => prev.data != next.data,
      builder: (context, state) => DataStateBuilder<List<GalleryItemData>>(
        state: state.data,
        loader: (_) => const LoaderHolderWidget(),
        errorBuilder: (context, _) =>
            ErrorHolderWidget(onPressed: () => context.read<PhotoGalleryCubit>().reload()),
        builder: (_, list) => _buildContent(list),
      ),
    );
  }

  Widget _buildContent(List<GalleryItemData> list) {
    final cubit = context.read<PhotoGalleryCubit>();
    // Ленивый builder вместо GridView(children:[...map]) — ячейки (в т.ч.
    // декодирование картинок) строятся по мере прокрутки, а не все сразу.
    // Первые две ячейки — кнопки «камера» и «галерея».
    const controlsCount = 2;
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: list.length + controlsCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _GalleryItemWidget(
            Icon(
              Icons.add_a_photo_outlined,
              size: 48.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => cubit.addPhoto(ImageSource.camera),
          );
        }
        if (index == 1) {
          return _GalleryItemWidget(
            Icon(
              Icons.photo_library_outlined,
              size: 48.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => cubit.addPhoto(ImageSource.gallery),
          );
        }
        final e = list[index - controlsCount];
        return _GalleryItemWidget(
          e.widget,
          onPressed: () => cubit.chooseItem(e),
          isChoosed: e.isChoosed,
        );
      },
    );
  }

  Future<void> _onSubmit() async {
    final cubit = context.read<PhotoGalleryCubit>();
    if (cubit.choosedCount > _maxCountImages) {
      final ctx = _scaffoldKey.currentContext ?? context;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('${LocaleKeys.animalMaxImagesCountIs.tr()} $_maxCountImages')),
      );
      return;
    }
    final navigator = Navigator.of(context);
    final success = await cubit.submit();
    if (success) navigator.pop(true);
  }
}
