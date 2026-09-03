import 'dart:async';

import 'package:util/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/presentation/comments/comments.dart';
import 'package:personal/util/util.dart';

/// Cubit экрана списка комментариев к животному.
///
/// Владеет состоянием списка [DataState], пагинацией (offset) и логикой
/// добавления/редактирования/удаления комментариев. Данные — доменные
/// [AnimalNote] из [CommentsRepository] (Result, без DTO). Подписывается на
/// внешний поток создания комментариев ([onCreateCommentStream]) и отменяет
/// подписку в [close] — устраняет утечку, при которой обработчик дописывал в уже
/// закрытый subject после dispose. ScrollController остаётся во
/// [StatefulWidget] экрана.
class CommentListCubit extends Cubit<CommentListState> {
  CommentListCubit({
    required CommentsRepository repository,
    required this.animalId,
    Stream<AnimalNote>? onCreateCommentStream,
  }) : _repository = repository,
       super(const CommentListState()) {
    _createCommentSub = onCreateCommentStream?.listen(_onCreateComment);
    _init();
  }

  final CommentsRepository _repository;

  /// ID животного, к которому относятся комментарии.
  final int animalId;

  StreamSubscription<AnimalNote>? _createCommentSub;

  /// Сортировка по дате создания (новые сверху). Делается здесь, в источнике
  /// правды, один раз на изменение данных — раньше список сортировался в build()
  /// на каждый ребилд списка.
  static List<AnimalNote> _sorted(List<AnimalNote> notes) {
    final copy = List<AnimalNote>.of(notes);
    copy.sort((a, b) {
      final da = a.createdAt, db = b.createdAt;
      // Записи без даты — в конец, стабильно.
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return db.compareTo(da);
    });
    return copy;
  }

  /// Первичная загрузка списка комментариев.
  Future<void> init() => _init();

  Future<void> _init() async {
    Log.debug('CommentListCubit.init animalId=$animalId');
    safeEmit(state.copyWith(data: const DataState.loading()));
    final result = await _repository.listByAnimal(animalId);
    result.fold(
      (failure) {
        Log.error('CommentListCubit.init failed: $failure');
        safeEmit(state.copyWith(data: DataState.error(failure)));
      },
      (results) {
        Log.info('CommentListCubit.init ok: count=${results.length}');
        safeEmit(state.copyWith(data: DataState.content(_sorted(results))));
      },
    );
  }

  /// Догрузить следующую страницу комментариев (infinite scroll).
  Future<void> loadNextPage() async {
    final current = state.data.valueOrNull;
    if (current == null || state.page.isLoading) return;
    Log.debug('CommentListCubit.loadNextPage animalId=$animalId offset=${current.length}');
    safeEmit(state.copyWith(page: const DataState.loading()));
    final result = await _repository.listByAnimal(animalId, offset: current.length);
    result.fold(
      (failure) {
        Log.error('CommentListCubit.loadNextPage failed: $failure');
        safeEmit(state.copyWith(page: DataState.error(failure)));
      },
      (value) {
        final newList = <AnimalNote>[...current, ...value];
        Log.info('CommentListCubit.loadNextPage ok: count=${newList.length}');
        safeEmit(state.copyWith(data: DataState.content(_sorted(newList)), page: const DataState.content(null)));
      },
    );
  }

  /// Удалить комментарий и убрать его из списка при успехе.
  ///
  /// Возвращает `true` при успехе; `false` — если запрос упал (виджет
  /// показывает snackbar).
  Future<bool> deleteComment(AnimalNote comment) async {
    Log.debug('CommentListCubit.deleteComment id=${comment.id}');
    final result = await _repository.delete(comment.id);
    return result.fold(
      (failure) {
        Log.error('CommentListCubit.deleteComment failed: $failure');
        return false;
      },
      (_) {
        final current = state.data.valueOrNull;
        if (current != null) {
          final newList = List<AnimalNote>.from(current)..remove(comment);
          safeEmit(state.copyWith(data: DataState.content(newList)));
        }
        Log.info('CommentListCubit.deleteComment ok: id=${comment.id}');
        return true;
      },
    );
  }

  /// Заменить в списке отредактированный комментарий.
  void onCommentEdited(AnimalNote editedComment) {
    final current = state.data.valueOrNull;
    if (current == null) return;
    final index = current.indexWhere((comment) => comment.id == editedComment.id);
    if (index < 0) return;
    final newList = List<AnimalNote>.from(current)..replaceRange(index, index + 1, [editedComment]);
    safeEmit(state.copyWith(data: DataState.content(_sorted(newList))));
  }

  void _onCreateComment(AnimalNote comment) {
    final current = state.data.valueOrNull;
    if (current == null) return;
    safeEmit(state.copyWith(data: DataState.content(_sorted(<AnimalNote>[...current, comment]))));
  }

  @override
  Future<void> close() {
    _createCommentSub?.cancel();
    return super.close();
  }
}
