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
import 'package:acits_flutter/util/data_state.dart';

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
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: const Text('Choose the photos', style: TextStyle(color: ColorRes.textPrimary)),
        centerTitle: true,
      ),
      floatingActionButton: BlocBuilder<PhotoGalleryCubit, PhotoGalleryState>(
        buildWhen: (prev, next) => prev.isSelectorChanged != next.isSelectorChanged,
        builder: (_, state) => state.isSelectorChanged
            ? FloatingActionButton(
                onPressed: _onSubmit,
                backgroundColor: ColorRes.accent,
                child: const Icon(Icons.done_all, color: Colors.white),
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
    return GridView(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      children: [
        _GalleryItemWidget(
          const Icon(Icons.add_a_photo_outlined, size: 48.0, color: ColorRes.accent),
          onPressed: () => cubit.addPhoto(ImageSource.camera),
        ),
        _GalleryItemWidget(
          const Icon(Icons.photo_library_outlined, size: 48.0, color: ColorRes.accent),
          onPressed: () => cubit.addPhoto(ImageSource.gallery),
        ),
        ...list.map<Widget>(
          (e) => _GalleryItemWidget(
            e.widget,
            onPressed: () => cubit.chooseItem(e),
            isChoosed: e.isChoosed,
          ),
        ),
      ],
    );
  }

  Future<void> _onSubmit() async {
    final cubit = context.read<PhotoGalleryCubit>();
    if (cubit.choosedCount > _maxCountImages) {
      final ctx = _scaffoldKey.currentContext ?? context;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('${StringRes.current.animalMaxImagesCountIs} $_maxCountImages')),
      );
      return;
    }
    final navigator = Navigator.of(context);
    final success = await cubit.submit();
    if (success) navigator.pop(true);
  }
}
