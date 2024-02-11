import 'dart:io';

import 'package:app/components/chat_sliver.dart';
import 'package:app/components/user_avatar.dart';
import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/stores/rooms_store.dart';
import 'package:app/utils/throttler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoomChatPage extends StatefulWidget {
  static const route = "/chat";
  final String roomId;
  const RoomChatPage({super.key, required this.roomId});

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  late final RoomsStore _store;
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
        child: ChatSliver<RoomsStore>(
          store: _store,
          scrlController: _scrlCtrl,
        ),
      ),
    );
  }
}
