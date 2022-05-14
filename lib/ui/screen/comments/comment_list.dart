import 'dart:async';

import 'package:acits_flutter/ui/screen/comments/comment_edit_screen_route.dart';
import 'package:acits_flutter/ui/widget/action_bs.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/subjects.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommentListWidget extends StatefulWidget {
  const CommentListWidget(
    this.animalId, {
    this.scrollController,
    this.onCreateCommentStream,
    Key? key,
  }) : super(key: key);

  final int animalId;
  final ScrollController? scrollController;
  final StreamController<AnimalNote>? onCreateCommentStream;

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

  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    widget.onCreateCommentStream?.stream.forEach(_onCreateComment);
    _init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(_onScroll);
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
                  ...(comments
                        ..sort((first, second) => (second.createdAt ?? DateTime.now())
                            .compareTo(first.createdAt ?? DateTime.now())))
                      .map<Widget>(
                    (comment) => _buildCommentItem(comment),
                  ),
                _buildPagingLoader(),
                const SizedBox(height: 64.0),
              ],
            ),
          );
        });
  }

  Widget _buildPagingLoader() {
    return StreamBuilder<WidgetState<Object>>(
      stream: _pagingState,
      builder: (_, partLoadingState) {
        if (partLoadingState.data?.hasError ?? false) {
          return SizedBox(
            height: 64.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: LottieBuilder.asset(LottieRes.crashScratch)),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: _loadNextPage,
                      child: Text(StringRes.current.commonReloadBtn),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (partLoadingState.data?.isLoading ?? false) {
          return SizedBox(
            height: 64.0,
            child: Center(child: LottieBuilder.asset(LottieRes.dogLoading)),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCommentItem(AnimalNote comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: ColorRes.foreground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildContent(comment),
                  if (comment.files?.isNotEmpty ?? false) _buildFileList(comment),
                  const SizedBox(height: 8.0),
                  _buildCaption(comment),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileList(AnimalNote comment) {
    return Column(
      children: comment.files
              ?.map<Widget>(
                (file) => CupertinoButton(
                  padding: const EdgeInsets.only(top: 8.0),
                  onPressed: () => _onFilePressed(file),
                  child: Text(
                    file.filename ?? '',
                    style: StyleRes.content.copyWith(
                      color: ColorRes.accent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
              .toList() ??
          [],
    );
  }

  Widget _buildContent(AnimalNote comment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text.rich(
            TextSpan(
              children: (TextUrlWrapper.fromString(comment.content ?? ''))
                  .map<TextSpan>(
                    (item) => TextSpan(
                      text: item.value,
                      style: item.isUrl
                          ? StyleRes.content.copyWith(
                              color: ColorRes.accent,
                              decoration: TextDecoration.underline,
                            )
                          : null,
                      recognizer: item.isUrl
                          ? (TapGestureRecognizer()..onTap = () => _onUrlPressed(item.value))
                          : null,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        if (comment.isUserCanEditOrDelete ?? false)
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CupertinoButton(
                onPressed: () => _onMorePressed(context, comment),
                padding: EdgeInsets.zero,
                minSize: .0,
                child: const Icon(
                  Icons.more_vert,
                  color: ColorRes.accent,
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildCaption(AnimalNote comment) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: comment.updatedAt?.toDateTimeHuman ?? '',
            style: StyleRes.caption,
          ),
          const TextSpan(
            text: ',  ',
            style: StyleRes.caption,
          ),
          TextSpan(
            text: comment.updatedBy ?? '',
            style: StyleRes.caption,
          ),
        ],
      ),
    );
  }

  void _onUrlPressed(String url) {
    launchUrlString(url);
  }

  void _onMorePressed(
    BuildContext context,
    AnimalNote comment,
  ) {
    final actions = bsSelectorActions(
      context,
      <Widget, dynamic Function()>{
        Text(
          StringRes.current.commonEdit,
          style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
        ): () async {
          final result = await Navigator.of(context).push(
            CommentEditScreenRoute(
              animalId: widget.animalId,
              comment: comment,
            ),
          );
          if (result != null) _onCommentEdited(result);
          Navigator.of(context).pop();
        },
        Text(
          StringRes.current.commonDelete,
          style: StyleRes.mainContent.copyWith(color: ColorRes.error),
        ): () {
          _deleteComment(context, comment);
          Navigator.of(context).pop();
        },
      },
    );

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) => actions,
    );
  }

  Future<void> _deleteComment(
    BuildContext context,
    AnimalNote comment,
  ) async {
    _animalService
        .deleteAnimalNote(id: comment.id!)
        .then((_) => _onCommentDeleted(comment))
        .catchError(
      (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(StringRes.current.commentDeletingFail)));
      },
    );
  }

  void _onCommentDeleted(AnimalNote comment) {
    if (!_widgetState.value.isContent) return;
    _widgetState.add(WidgetState(_widgetState.value.value?..remove(comment)));
  }

  void _onCommentEdited(AnimalNote editedComment) {
    if (!_widgetState.value.isContent) return;
    final commentList = _widgetState.value.value;
    final index = commentList?.indexWhere((comment) => comment.id == editedComment.id);
    if (index == null || index < 0) return;
    commentList?.replaceRange(index, index + 1, [editedComment]);
    _widgetState.add(WidgetState(_widgetState.value.value));
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_pagingState.value.isLoading) _loadNextPage();
  }

  void _init() {
    _widgetState.add(WidgetState()..loading());
    _animalService
        .fetchAnimalNotes(_animalId)
        .then((value) => _widgetState.add(WidgetState(value?.results ?? [])))
        .catchError((e) {
      _widgetState.add(WidgetState()..error = e);
    });
  }

  void _loadNextPage() {
    if (!_widgetState.value.isContent) return;
    _pagingState.add(WidgetState<Object>()..loading());
    _animalService
        .fetchAnimalNotes(
      _animalId,
      offset: _widgetState.value.value?.length,
    )
        .then((value) {
      _widgetState.add(WidgetState(_widgetState.value.value?..addAll(value?.results ?? [])));
      _pagingState.add(WidgetState());
    }).catchError((e) {
      _pagingState.add(WidgetState()..error = e);
    });
  }

  void _onFilePressed(AnimalNoteFile file) {
    final url = file.file;
    if (url != null) launchUrlString(url);
  }

  void _onCreateComment(AnimalNote comment) {
    if (!_widgetState.value.isContent) return;
    _widgetState.add(WidgetState(_widgetState.value.value?..add(comment)));
  }
}
