part of 'todo_screen.dart';

class _TodaySection extends HookConsumerWidget {
  const _TodaySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(todayCalendarEventControllerProvider);

    return asyncValue.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _FreeTimes(titleEvents: data),
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}

class _FreeTimes extends HookConsumerWidget {
  const _FreeTimes({
    required this.titleEvents,
  });

  final List<TitleEvent> titleEvents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final start = DateTime.now();
    final end = DateTime(start.year, start.month, start.day, 23, 59, 59);
    final freeEvents = ref.watch(
      freeCalendarEventControllerProvider(
        titleEvents,
        start,
        end,
        const Duration(minutes: 1),
      ),
    );
    // 残りの分数
    final freeTimeMinitues = freeEvents.fold(
      0,
      (previousValue, element) => previousValue + element.duration.inMinutes,
    );

    return Row(
      children: [
        Text(
          convertToMinutesAndSeconds(freeTimeMinitues),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(width: 12),
        const _JustNowEvent(),
        const Spacer(),
        // 更新ボタン
        IconButton(
          focusNode: FocusNode(skipTraversal: true),
          onPressed: () {
            ref.invalidate(todayCalendarEventControllerProvider);
          },
          icon: const Icon(Icons.refresh),
        ),
        // ログインボタン
        // IconButton(
        //   focusNode: FocusNode(skipTraversal: true),
        //   onPressed: () {
        //     ref.read(googleSignInControllerProvider).valueOrNull!.signIn();
        //   },
        //   icon: const Icon(Icons.login),
        // ),
        // IconButton(
        //   focusNode: FocusNode(skipTraversal: true),
        //   onPressed: () {
        //     ref.read(googleSignInControllerProvider).valueOrNull!.signOut();
        //   },
        //   icon: const Icon(Icons.logout),
        // ),
      ],
    );
  }

  /// 分数を分:秒の形式に変換する
  String convertToMinutesAndSeconds(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}"; // 分:秒の形式で返す
  }
}

class _JustNowEvent extends HookConsumerWidget {
  const _JustNowEvent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final justNowEvents = ref.watch(justNowEventControllerProvider);

    return justNowEvents.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("作業中..."),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: justNowEvents
                .map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      "${event.title} ${event.start.hour}:${event.start.minute} ~ ${event.end.hour}:${event.end.minute}",
                    ),
                  ),
                )
                .toList(),
          );
  }
}
