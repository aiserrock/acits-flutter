import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';

class CommentListWidget extends StatefulWidget {
  const CommentListWidget(
    this.animalId, {
    Key? key,
  }) : super(key: key);

  final int animalId;

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState(animalId);
}

class _CommentListWidgetState extends State<CommentListWidget> {
  _CommentListWidgetState(this._animalId) : _animalService = getIt<AnimalService>();

  final int _animalId;
  final AnimalService _animalService;

  final _widgetState =
      BehaviorSubject<WidgetState<List<AnimalNote>>>.seeded(WidgetState()..loading());
  final _pagingState = BehaviorSubject<WidgetState<Object>>.seeded(WidgetState(Object()));

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _widgetState.close();
    _pagingState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WidgetState<List<AnimalNote>>>(
        stream: _widgetState,
        builder: (_, snapshot) {
          final comments = snapshot.data?.value;
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                if (snapshot.data?.isLoading ?? false)
                  const SizedBox(
                    height: 240.0,
                    child: LoaderHolderWidget(),
                  ),
                if (snapshot.data?.hasError ?? false)
                  SizedBox(
                    height: 240.0,
                    child: ErrorHolderWidget(
                      onPressed: _init,
                    ),
                  ),
                if (comments != null && comments.isNotEmpty)
                  ...comments.map<Widget>((comment) => _buildCommentItem(comment. content ?? ''))
              ],
            ),
          );
        });
  }

  Widget _buildCommentItem(String text) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: ColorRes.textSecondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Text(text),
          ),
        ),
      ],
    );
  }

  void _onScroll() {}

  void _init() {
    _widgetState.add(WidgetState()..loading());
    _animalService
        .fetchAnimalNotes(_animalId)
        .then((value) => _widgetState.add(WidgetState(value?.results ?? [])))
        .catchError((e) {
      _widgetState.add(WidgetState().error = e);
    });
  }
}
