// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_done_todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayDoneTodoControllerHash() =>
    r'b7db0aa8b7f85b0311a4e82fc637e37647290123';

/// 今日の完了済みの[TodoItem]を取得するコントローラー
///
/// Copied from [TodayDoneTodoController].
@ProviderFor(TodayDoneTodoController)
final todayDoneTodoControllerProvider = AutoDisposeAsyncNotifierProvider<
    TodayDoneTodoController, List<TodoItem>>.internal(
  TodayDoneTodoController.new,
  name: r'todayDoneTodoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayDoneTodoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodayDoneTodoController = AutoDisposeAsyncNotifier<List<TodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member