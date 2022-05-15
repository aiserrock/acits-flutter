import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

const _allowedFileAttachExtensions = [
  'pdf',
  'doc',
  'docx',
  'txt',
  'xls',
  'xlsx',
  'png',
  'jpg',
];

class CommentEditScreen extends StatefulWidget {
  const CommentEditScreen({
    required this.animalId,
    this.comment,
    Key? key,
  }) : super(key: key);

  final int animalId;
  final AnimalNote? comment;

  @override
  State<CommentEditScreen> createState() => _CommentEditScreenState();
}

class _CommentEditScreenState extends State<CommentEditScreen> {
  _CommentEditScreenState() : _animalService = getIt<AnimalService>();

  final AnimalService _animalService;
  final _attachState = BehaviorSubject<PlatformFile?>();
  final _submitState = BehaviorSubject<WidgetState<Object>>.seeded(WidgetState());

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.comment?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlatformFile?>(
        stream: _attachState.stream,
        builder: (_, attachSnaphot) {
          return Scaffold(
            backgroundColor: ColorRes.background,
            appBar: _buildAppBar(context, attachSnaphot),
            floatingActionButton: _buildFab(context),
            body: _buildBody(context),
          );
        });
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, AsyncSnapshot<PlatformFile?> attachSnaphot) {
    return AppBar(
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
        _isEdit ? StringRes.current.commentTitleEdit : StringRes.current.commentTitleNew,
        style: const TextStyle(color: ColorRes.textPrimary),
      ),
      centerTitle: true,
      actions: [
        CupertinoButton(
          child: const Icon(
            Icons.attach_file_rounded,
            color: ColorRes.accent,
          ),
          onPressed: _pickFile,
        )
      ],
      bottom: _buildFileBar(attachSnaphot.data),
    );
  }

  Widget _buildFab(BuildContext context) {
    return StreamBuilder<WidgetState<Object>>(
        stream: _submitState,
        builder: (_, isSubmit) {
          return (isSubmit.data?.isLoading ?? true)
              ? const SizedBox()
              : FloatingActionButton(
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => _onSubmit(context),
                  backgroundColor: ColorRes.accent,
                );
        });
  }

  PreferredSizeWidget? _buildFileBar(PlatformFile? file) {
    final fileName = file?.name;
    return fileName == null
        ? null
        : AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorRes.foreground,
            shadowColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    fileName,
                    style: StyleRes.content.copyWith(
                      color: ColorRes.accent,
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
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: ColorRes.error,
                ),
                onPressed: () {
                  _attachState.add(null);
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
              backgroundColor: ColorRes.foreground,
              shadowColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      _sourceFileName ?? '',
                      style: StyleRes.content.copyWith(
                        color: ColorRes.textSecondary,
                        decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.cloud_done,
                    color: ColorRes.textSecondary,
                  ),
                )
              ],
            ),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _textController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
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

  bool get _isEdit => widget.comment != null;

  void _onSubmit(BuildContext context) {
    _submitState.add(WidgetState()..loading());
    final source = widget.comment;
    final file = _attachState.valueOrNull;
    if (source != null) {
      _animalService
          .patchAnimalNote(
            id: source.id!,
            animalId: source.animal!,
            text: _textController.text,
            files: file != null ? [file] : [],
          )
          .then((comment) => _exit(context, comment))
          .catchError((e) => _onError(context, e));
    } else {
      _animalService
          .createAnimalNote(
            animalId: widget.animalId,
            text: _textController.text,
            files: file != null ? [file] : [],
          )
          .then((comment) => _exit(context, comment))
          .catchError((e) => _onError(context, e));
    }
  }

  void _exit(
    BuildContext context,
    AnimalNote? comment,
  ) {
    Navigator.of(context).pop(comment);
  }

  void _onError(
    BuildContext context,
    Object error,
  ) {
    _submitState.add(WidgetState()..error = error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(StringRes.current.commonErrorTryAgainMessage),
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedFileAttachExtensions,
    );
    if (result != null) {
      _attachState.add(result.files[0]);
    }
  }

  String? get _sourceFileName => widget.comment?.files?.firstOrNull?.filename;
}
