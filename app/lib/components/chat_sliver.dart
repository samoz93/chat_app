import 'package:app/components/custom_input.dart';
import 'package:app/components/message_tile.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/stores/base_chat.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatSliver<T extends BaseChat> extends StatefulWidget {
  final T store;
  final ScrollController scrlController;
  const ChatSliver(
      {super.key, required this.store, required this.scrlController});

  @override
  State<ChatSliver<T>> createState() => _ChatSliverState<T>();
}

class _ChatSliverState<T extends BaseChat> extends State<ChatSliver<T>> {
  final _txtCtrl = TextEditingController();

  List<Widget> getSlivers(
      String key, List<Message> messages, BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 30.sp,
          child: Center(
            child: Text(
              key,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final message = messages[index];
            return MessageTile(
              message: message,
            );
          },
          childCount: messages.length,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.sp,
        vertical: 5.sp,
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Observer(builder: (context) {
              final messages = widget.store.messageGroups;
              return CustomScrollView(
                controller: widget.scrlController,
                dragStartBehavior: DragStartBehavior.down,
                slivers: [
                  ...messages.map(
                    (data) {
                      return getSlivers(data.$1, data.$2, context);
                    },
                  ).expand((element) => element)
                ],
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomInput(
                    onChanged: (value) {},
                    label: "Type a message",
                    suffixIcon: Icons.send,
                    controller: _txtCtrl,
                    onSuffixClicked: () {
                      if (_txtCtrl.value.text.isEmpty) {
                        return;
                      }
                      widget.store.sendMessage(
                        _txtCtrl.value.text,
                      );
                      _txtCtrl.clear();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconBox(
                    onClick: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Camera not implemented"),
                        ),
                      );
                    },
                    icon: Icons.camera,
                    type: IconType.suffix,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
