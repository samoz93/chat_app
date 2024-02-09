import 'dart:io';

import 'package:app/components/custom_input.dart';
import 'package:app/components/message_tile.dart';
import 'package:app/components/user_avatar.dart';
import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/stores/rooms_store.dart';
import 'package:app/utils/throttler.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatPage extends StatefulWidget {
  static const route = "/chat";
  final String roomId;
  const ChatPage({super.key, required this.roomId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final RoomsStore _store;
  final _txtCtrl = TextEditingController();
  final _scrlCtrl = ScrollController();
  late ReactionDisposer dis;
  @override
  void initState() {
    _store = RoomsStore(roomId: widget.roomId);
    _store.joinRoom();
    Future.delayed(500.ms, () {
      _scrlCtrl.jumpTo(
        _scrlCtrl.position.maxScrollExtent,
      );
    });
    _scrlCtrl.addListener(scrollListener);
    dis = autorun((_) {
      final finalMessage = _store.messages.last;
      if (finalMessage is AdminMessage) return;
      _scrlCtrl.animateTo(
        _scrlCtrl.position.maxScrollExtent + 40.sp,
        duration: 100.ms,
        curve: Curves.decelerate,
      );
    });

    super.initState();
  }

  final throttler = Throttler(duration: 300.ms);

  scrollListener() {
    throttler.run(() {
      if (_scrlCtrl.offset < -15) {
        _store.loadMoreMessages();
      }
    });
  }

  @override
  void dispose() {
    _store.leaveRoom();
    _scrlCtrl.removeListener(scrollListener);
    dis();
    super.dispose();
  }

  List<Widget> getSlivers(String key, List<Message> messages) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PreferredSize(
          preferredSize: Size.fromHeight(30.sp),
          child: Observer(
            builder: (context) {
              return SizedBox(
                height: 30.sp,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: _store.users.length,
                  itemBuilder: (context, index) {
                    final user = _store.users.elementAt(index);
                    return UsersAvatar(user: user, index: index);
                  },
                ),
              );
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: Platform.isAndroid ? null : const SizedBox(),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10.sp,
            vertical: 5.sp,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Observer(builder: (context) {
                  final messages = _store.messageGroups;
                  return CustomScrollView(
                    controller: _scrlCtrl,
                    dragStartBehavior: DragStartBehavior.down,
                    slivers: [
                      ...messages.map(
                        (data) {
                          return getSlivers(data.$1, data.$2);
                        },
                      ).expand((element) => element)
                    ],
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        onChanged: (value) {},
                        label: "Type a message",
                        suffixIcon: Icons.send,
                        controller: _txtCtrl,
                        onSuffixClicked: () {
                          if (_txtCtrl.value.text.isEmpty) {
                            return;
                          }
                          _store.sendMessage(
                            _txtCtrl.value.text,
                          );
                          _txtCtrl.value = TextEditingValue.empty;
                        },
                      ),
                    ),
                    IconBox(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
