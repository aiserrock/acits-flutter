import 'dart:async';

import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

class PhotoGalleryScreen extends StatefulWidget {
  PhotoGalleryScreen({
    required this.animalId,
    Key? key,
  }) : super(key: key);

  final int animalId;

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final _screenState = StreamController<WidgetState<List<AnimalImageWrite>>>()
    ..add(WidgetState()..loading());

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          'Choose the photos',
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.done_all,
          color: Colors.white,
        ),
        onPressed: () {},
        backgroundColor: ColorRes.accent,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }

  void _init() {}
}
