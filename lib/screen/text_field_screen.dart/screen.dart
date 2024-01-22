import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/method_channel.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final alwaysFloating = useState(true);
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 4, right: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      channel.invokeMethod(AppMethodChannel.windowToLeft.name);
                    },
                    icon: const Icon(Icons.arrow_circle_left_outlined)),
                IconButton(
                  onPressed: () {
                    alwaysFloating.value = !alwaysFloating.value;
                    if (alwaysFloating.value) {
                      channel
                          .invokeMethod(AppMethodChannel.alwaysFloatingOn.name);
                    } else {
                      channel.invokeMethod(
                          AppMethodChannel.alwaysFloatingOff.name);
                    }
                  },
                  icon: Icon(alwaysFloating.value
                      ? Icons.bookmark
                      : Icons.bookmark_outline),
                  color: alwaysFloating.value
                      ? context.colorScheme.primary
                      : context.colorScheme.secondary,
                ),
                IconButton(
                    onPressed: () {
                      channel.invokeMethod(AppMethodChannel.windowToRight.name);
                    },
                    icon: const Icon(Icons.arrow_circle_right_outlined)),
              ],
            ),
            Expanded(
              child: MarkdownTextField(
                controller: useMarkdownTextEditingController(),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
