// ignore_for_file: use_build_context_synchronously

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/comments/cubit/comment_edit_cubit.dart';
import 'package:acits_flutter/ui/screen/comments/cubit/comment_edit_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _allowedFileAttachExtensions = ['pdf', 'doc', 'docx', 'txt', 'xls', 'xlsx'];

class CommentEditScreen extends StatelessWidget {
  const CommentEditScreen({required this.animalId, this.comment, super.key});

  final int animalId;
  final AnimalNote? comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentEditCubit(animalId: animalId, comment: comment),
      child: const _CommentEditView(),
    );
  }
}

class _CommentEditView extends StatefulWidget {
  const _CommentEditView();

  @override
  State<_CommentEditView> createState() => _CommentEditViewState();
}

class _CommentEditViewState extends State<_CommentEditView> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = context.read<CommentEditCubit>().comment?.content ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentEditCubit, CommentEditState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: _buildAppBar(context, state.attachedFile),
          floatingActionButton: _buildFab(context, state),
          body: _buildBody(context),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, PlatformFile? attachedFile) {
    final cubit = context.read<CommentEditCubit>();
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shadowColor: Colors.transparent,
      leading: GestureDetector(
        child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
        onTap: () => Navigator.of(context).pop(),
      ),
      title: Text(
        cubit.isEdit ? LocaleKeys.commentTitleEdit.tr() : LocaleKeys.commentTitleNew.tr(),
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      centerTitle: true,
      actions: [
        CupertinoButton(
          onPressed: _pickFile,
          child: Icon(Icons.attach_file_rounded, color: Theme.of(context).colorScheme.primary),
        ),
      ],
      bottom: _buildFileBar(context, attachedFile),
    );
  }

  Widget _buildFab(BuildContext context, CommentEditState state) {
    return state.isSubmitting
        ? const SizedBox()
        : FloatingActionButton(
            onPressed: () => _onSubmit(context),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.send_rounded, color: Theme.of(context).colorScheme.onPrimary),
          );
  }

  PreferredSizeWidget? _buildFileBar(BuildContext context, PlatformFile? file) {
    final fileName = file?.name;
    return fileName == null
        ? null
        : AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shadowColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    fileName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            actions: [
              CupertinoButton(
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
                onPressed: () {
                  context.read<CommentEditCubit>().clearAttachedFile();
                },
              ),
            ],
          );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if (_sourceFileName != null)
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              shadowColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      _sourceFileName ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: context.appColors.textSecondary,
                        decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.cloud_done, color: context.appColors.textSecondary),
                ),
              ],
            ),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _textController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                border: InputBorder.none,
              ),
              expands: true,
              maxLines: null,
              minLines: null,
              onEditingComplete: () => _onSubmit(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit(BuildContext context) async {
    final cubit = context.read<CommentEditCubit>();
    try {
      final comment = await cubit.submit(_textController.text);
      if (!mounted) return;
      Navigator.of(context).pop(comment);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(LocaleKeys.commonErrorTryAgainMessage.tr())));
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedFileAttachExtensions,
      // withData: байты кладутся в PlatformFile.bytes на всех платформах —
      // на web это единственный способ получить содержимое (path == null).
      withData: true,
    );
    if (result != null) {
      if (!mounted) return;
      context.read<CommentEditCubit>().attachFile(result.files[0]);
    }
  }

  String? get _sourceFileName =>
      context.read<CommentEditCubit>().comment?.files?.firstOrNull?.filename;
}
