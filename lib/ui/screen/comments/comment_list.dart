// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/file/file_service.dart';
import 'package:acits_flutter/ui/screen/comments/cubit/comment_list_cubit.dart';
import 'package:acits_flutter/ui/screen/comments/cubit/comment_list_state.dart';
import 'package:acits_flutter/ui/widget/action_bs.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';

class CommentListWidget extends StatelessWidget {
  const CommentListWidget(
    this.animalId, {
    this.scrollController,
    this.onCreateCommentStream,
    super.key,
  });

  final int animalId;
  final ScrollController? scrollController;
  final StreamController<AnimalNote>? onCreateCommentStream;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentListCubit(
        animalId: animalId,
        onCreateCommentStream: onCreateCommentStream?.stream,
      ),
      child: _CommentListView(animalId: animalId, scrollController: scrollController),
    );
  }
}

class _CommentListView extends StatefulWidget {
  const _CommentListView({required this.animalId, this.scrollController});

  final int animalId;
  final ScrollController? scrollController;

  @override
  State<_CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<_CommentListView> {
  final FileService _fileService = getIt<FileService>();

  late final ScrollController _scrollController;
  bool _ownsScrollController = false;

  @override
  void initState() {
    super.initState();
    _ownsScrollController = widget.scrollController == null;
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (_ownsScrollController) _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentListCubit, CommentListState>(
      builder: (_, state) {
        return DataStateBuilder<List<AnimalNote>>(
          state: state.data,
          loader: (_) =>
              const SliverToBoxAdapter(child: SizedBox(height: 240.0, child: LoaderHolderWidget())),
          errorBuilder: (_, _) => SliverToBoxAdapter(
            child: SizedBox(
              height: 240.0,
              child: ErrorHolderWidget(onPressed: () => context.read<CommentListCubit>().init()),
            ),
          ),
          builder: (_, comments) => _buildList(state, comments),
        );
      },
    );
  }

  Widget _buildList(CommentListState state, List<AnimalNote> comments) {
    final sorted = List<AnimalNote>.from(comments)
      ..sort(
        (first, second) =>
            (second.createdAt ?? DateTime.now()).compareTo(first.createdAt ?? DateTime.now()),
      );
    return SliverList(
      delegate: SliverChildListDelegate([
        ...sorted.map<Widget>((comment) => _buildCommentItem(comment)),
        _buildPagingLoader(state),
        const SizedBox(height: 64.0),
      ]),
    );
  }

  Widget _buildPagingLoader(CommentListState state) {
    return DataStateBuilder<Object?>(
      state: state.page,
      loader: (_) =>
          SizedBox(height: 64.0, child: Center(child: LottieBuilder.asset(LottieRes.dogLoading))),
      errorBuilder: (_, _) => SizedBox(
        height: 64.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(child: LottieBuilder.asset(LottieRes.crashScratch)),
              Expanded(
                child: PrimaryButton(
                  onPressed: () => context.read<CommentListCubit>().loadNextPage(),
                  child: Text(StringRes.current.commonReloadBtn),
                ),
              ),
            ],
          ),
        ),
      ),
      builder: (_, _) => const SizedBox(),
    );
  }

  Widget _buildCommentItem(AnimalNote comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: ColorRes.foreground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4.0)],
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
      children:
          comment.files
              ?.map<Widget>(
                (file) => CupertinoButton(
                  padding: const EdgeInsets.only(top: 8.0),
                  onPressed: () => _onFilePressed(context, file).catchError((e) {
                    _onError(context, StringRes.current.commonErrorStubMsg);
                  }),
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
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CupertinoButton(
                  onPressed: () => _onMorePressed(context, comment),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  child: const Icon(Icons.more_vert, color: ColorRes.accent),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildCaption(AnimalNote comment) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: comment.updatedAt?.toDateTimeHuman ?? '', style: StyleRes.caption),
          const TextSpan(text: ',  ', style: StyleRes.caption),
          TextSpan(text: comment.updatedBy ?? '', style: StyleRes.caption),
        ],
      ),
    );
  }

  void _onMorePressed(BuildContext context, AnimalNote comment) {
    final cubit = context.read<CommentListCubit>();
    final actions = bsSelectorActions(context, <Widget, dynamic Function()>{
      Text(
        StringRes.current.commonEdit,
        style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
      ): () async {
        final result = await context.push<AnimalNote>(
          AppRoutes.commentEditPath(widget.animalId),
          extra: comment,
        );
        if (result != null) cubit.onCommentEdited(result);
        Navigator.of(context).pop();
      },
      Text(
        StringRes.current.commonDelete,
        style: StyleRes.mainContent.copyWith(color: ColorRes.error),
      ): () {
        _deleteComment(context, comment);
        Navigator.of(context).pop();
      },
    });

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) => actions,
    );
  }

  Future<void> _deleteComment(BuildContext context, AnimalNote comment) async {
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<CommentListCubit>().deleteComment(comment);
    if (!success) {
      messenger.showSnackBar(SnackBar(content: Text(StringRes.current.commentDeletingFail)));
    }
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      context.read<CommentListCubit>().loadNextPage();
    }
  }

  Future<void> _onFilePressed(BuildContext context, AnimalNoteFile file) async {
    final url = file.file;
    final fileName = file.filename;

    if (url == null || fileName == null) return;
    final File localFile;
    try {
      localFile = await _fileService.loadFile(url, fileName);
    } catch (_) {
      _onError(context, StringRes.current.commentDeletingFail);
      return;
    }

    final openResult = await OpenFilex.open(localFile.absolute.path);
    String errorMsg = '';
    switch (openResult.type) {
      case ResultType.noAppToOpen:
        errorMsg = StringRes.current.commonNoAppToOpenFileMsg;
        break;
      case ResultType.error:
        errorMsg = StringRes.current.commonErrorTryAgainMessage;
        break;
      default:
    }
    if (errorMsg.isNotEmpty) _onError(context, errorMsg);
  }

  Future<void> _onUrlPressed(String url) async {
    FlutterWebBrowser.openWebPage(url: url);
  }

  void _onError(BuildContext context, String? msg) {
    if (msg == null || msg.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
