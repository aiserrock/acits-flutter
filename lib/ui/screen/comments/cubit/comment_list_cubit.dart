import 'dart:async';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/comments/cubit/comment_list_state.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acits_flutter/util/bloc_ext.dart';

/// Cubit экрана списка комментариев к животному.
///
/// Владеет состоянием списка [DataState], пагинацией (offset) и логикой
/// добавления/редактирования/удаления комментариев. Подписывается на внешний
/// поток создания комментариев ([onCreateCommentStream]) и отменяет подписку
/// в [close] — устраняет утечку, при которой обработчик дописывал в уже
/// закрытый subject после dispose. ScrollController остаётся во
/// [StatefulWidget] экрана.
class CommentListCubit extends Cubit<CommentListState> {
  CommentListCubit({required this.animalId, Stream<AnimalNote>? onCreateCommentStream})
    : _animalService = getIt<AnimalService>(),
      super(const CommentListState()) {
    _createCommentSub = onCreateCommentStream?.listen(_onCreateComment);
    _init();
  }

  final AnimalService _animalService;

  /// ID животного, к которому относятся комментарии.
  final int animalId;

  StreamSubscription<AnimalNote>? _createCommentSub;

  /// Первичная загрузка списка комментариев.
  Future<void> init() => _init();

  Future<void> _init() async {
    Log.debug('CommentListCubit.init animalId=$animalId');
    safeEmit(state.copyWith(data: const DataState.loading()));
    try {
      final value = await _animalService.fetchAnimalNotes(animalId);
      final results = value?.results ?? [];
      Log.info('CommentListCubit.init ok: count=${results.length}');
      safeEmit(state.copyWith(data: DataState.content(results)));
    } catch (e, s) {
      Log.error('CommentListCubit.init failed', e, s);
      safeEmit(state.copyWith(data: DataState.error(e)));
    }
  }

  /// Догрузить следующую страницу комментариев (infinite scroll).
  Future<void> loadNextPage() async {
    final current = state.data.valueOrNull;
    if (current == null || state.page.isLoading) return;
    Log.debug('CommentListCubit.loadNextPage animalId=$animalId offset=${current.length}');
    safeEmit(state.copyWith(page: const DataState.loading()));
    try {
      final value = await _animalService.fetchAnimalNotes(animalId, offset: current.length);
      final newList = <AnimalNote>[...current, ...?value?.results];
      Log.info('CommentListCubit.loadNextPage ok: count=${newList.length}');
      safeEmit(
        state.copyWith(data: DataState.content(newList), page: const DataState.content(null)),
      );
    } catch (e, s) {
      Log.error('CommentListCubit.loadNextPage failed', e, s);
      safeEmit(state.copyWith(page: DataState.error(e)));
    }
  }

  /// Удалить комментарий и убрать его из списка при успехе.
  ///
  /// Возвращает `true` при успехе; `false` — если запрос упал (виджет
  /// показывает snackbar).
  Future<bool> deleteComment(AnimalNote comment) async {
    Log.debug('CommentListCubit.deleteComment id=${comment.id}');
    try {
      await _animalService.deleteAnimalNote(id: comment.id!);
      final current = state.data.valueOrNull;
      if (current != null) {
        final newList = List<AnimalNote>.from(current)..remove(comment);
        safeEmit(state.copyWith(data: DataState.content(newList)));
      }
      Log.info('CommentListCubit.deleteComment ok: id=${comment.id}');
      return true;
    } catch (e, s) {
      Log.error('CommentListCubit.deleteComment failed', e, s);
      return false;
    }
  }

  /// Заменить в списке отредактированный комментарий.
  void onCommentEdited(AnimalNote editedComment) {
    final current = state.data.valueOrNull;
    if (current == null) return;
    final index = current.indexWhere((comment) => comment.id == editedComment.id);
    if (index < 0) return;
    final newList = List<AnimalNote>.from(current)..replaceRange(index, index + 1, [editedComment]);
    safeEmit(state.copyWith(data: DataState.content(newList)));
  }

  void _onCreateComment(AnimalNote comment) {
    final current = state.data.valueOrNull;
    if (current == null) return;
    safeEmit(state.copyWith(data: DataState.content(<AnimalNote>[...current, comment])));
  }

  @override
  Future<void> close() {
    _createCommentSub?.cancel();
    return super.close();
  }
}
