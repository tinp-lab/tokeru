import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/show_done_todo/show_done_todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/repository/todo/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_controller.g.dart';

/// 今日作成された[TodoItem]を返すController
///
/// ユーザーがログインしていない場合は、[TodoItem]は空の状態で返す。
@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  TodoRepository? todoRepository;
  Timer? _deleteDonesDebounce;
  Timer? _updateOrderDebounce;

  @override
  FutureOr<List<AppItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }
    todoRepository = ref.read(todoRepositoryProvider(user.value!.id));

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final showDoneTodos = ref.watch(showDoneTodoControllerProvider);
    final todos = await todoRepository!.fetchTodosAfter(
      date: todayStart,
      isDone: showDoneTodos ? null : false,
    );
    // index順に並び替える
    todos.sort((a, b) => a.index.compareTo(b.index));
    return todos;
  }

  /// [Todo]を追加する
  Future<void> add(
    int index, {
    String title = '',
  }) async {
    try {
      final todo = await todoRepository!.add(
        createdAt: DateTime.now(),
        index: index,
        title: title,
      );
      final tmp = [...state.value!];
      tmp.insert(index, todo);
      state = AsyncData(tmp);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// [Todo]のインデントを追加する
  Future<void> addIndent(AppTodoItem todo) async {
    try {
      todoRepository!.update(
        id: todo.id,
        indentLevel: todo.indentLevel + 1,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    final index = tmp.indexWhere((element) => element.id == todo.id);
    // todoがTodoクラスなので、tmp[index]もTodoでキャストして良い。
    final tmpTodo = tmp[index] as AppTodoItem;
    tmp[index] = tmpTodo.copyWith(indentLevel: tmpTodo.indentLevel + 1);
    state = AsyncData(tmp);
  }

  /// [Todo]のインデントを削除する
  Future<void> minusIndent(AppTodoItem todo) async {
    try {
      todoRepository!.update(
        id: todo.id,
        indentLevel: todo.indentLevel - 1,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    final index = tmp.indexWhere((element) => element.id == todo.id);
    // todoがTodoクラスなので、tmp[index]もTodoでキャストして良い。
    final tmpTodo = tmp[index] as AppTodoItem;
    tmp[index] = tmpTodo.copyWith(indentLevel: tmpTodo.indentLevel - 1);
    state = AsyncData(tmp);
  }

  /// [TodoItem]を削除する
  Future<void> delete(AppItem todo) async {
    try {
      todoRepository!.delete(id: todo.id);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    tmp.removeWhere((element) => element.id == todo.id);
    state = AsyncData(tmp);
  }

  /// [todoId]に一致する[Todo.title]を更新する
  Future<void> updateTodoTitle({
    required String todoId,
    required String title,
  }) async {
    final index = state.valueOrNull!.indexWhere((e) => e.id == todoId);
    final todo =
        (state.valueOrNull![index] as AppTodoItem).copyWith(title: title);
    try {
      await todoRepository!.update(
        id: todo.id,
        title: todo.title,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    // ショートカットのソートと被り、最初に取得したindexと変わっている場合があるので
    // ここで再度indexを取得する
    final newindex = state.valueOrNull!.indexWhere((e) => e.id == todoId);
    tmp[newindex] = todo;
    state = AsyncData(tmp);
  }

  /// [Todo]のisDoneを更新する。
  ///
  /// [Todo]の状態は更新するが、リストの中から削除はしない。
  /// - [todoId]: 更新する[Todo]のID
  /// - [isDone]: 更新するisDoneの値
  /// - [milliseconds]: デバウンスする時間。この時間内に複数回呼ばれた場合、最後の呼び出しのみが実行される。
  /// - [onUpdated]: 更新後に実行するコールバック。[showDoneTodoControllerProvider]がfalseの場合のみ実行される。
  Future<void> updateIsDone({
    required String todoId,
    bool isDone = true,
    int milliseconds = 1200,
    VoidCallback? onUpdated,
  }) async {
    final index = state.valueOrNull!.indexWhere((e) => e.id == todoId);
    final tmp = [...state.value!];
    final todo = (state.value![index] as AppTodoItem).copyWith(isDone: isDone);
    tmp[index] = todo;
    state = AsyncData(tmp);
    try {
      await todoRepository!.update(
        id: todo.id,
        isDone: isDone,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    if (!ref.read(showDoneTodoControllerProvider)) {
      _filterDoneIsTrueWithDebounce(
        milliseconds: milliseconds,
        onDeleted: onUpdated,
      );
    }
  }

  /// [oldIndex]の[TodoItem]を[newIndex]に移動する
  Future<void> reorder(int oldIndex, int newIndex) async {
    final tmp = [...state.value!];
    final item = tmp.removeAt(oldIndex);
    tmp.insert(newIndex, item);
    state = AsyncData(tmp);

    // indexを更新する
    await updateCurrentOrder();
  }

  /// 現在のListの順番をindexとして更新する。
  ///
  /// 新規作成後や削除後に並び替えをリセットするために使用する。
  /// ショートカットでの移動時に連続で呼ばれる可能性があるため、APIの呼び出しはデバウンスしている。
  Future<void> updateCurrentOrder() async {
    final tmp = state.value!;
    for (var i = 0; i < tmp.length; i++) {
      tmp[i] = tmp[i].copyWith(index: i);
    }
    state = AsyncData(tmp);

    // 既存のデバウンスタイマーをキャンセル
    _updateOrderDebounce?.cancel();

    _updateOrderDebounce = Timer(const Duration(milliseconds: 500), () async {
      await todoRepository!.updateOrder(todos: tmp);
    });
  }

  /// [Todo.isDone]がtrueのものをリストから削除する。
  ///
  /// このメソッドが[milliseconds]以内に複数回呼ばれた場合、最後の呼び出しのみが実行される。
  Future<void> _filterDoneIsTrueWithDebounce({
    int milliseconds = 1200,
    VoidCallback? onDeleted,
  }) async {
    // 既存のデバウンスタイマーをキャンセル
    _deleteDonesDebounce?.cancel();

    _deleteDonesDebounce =
        Timer(Duration(milliseconds: milliseconds), () async {
      final tmp = [
        ...state.value!.whereType<AppTodoItem>().where((e) => !e.isDone),
      ];
      state = AsyncData(tmp);
      onDeleted?.call();
    });
  }
}
