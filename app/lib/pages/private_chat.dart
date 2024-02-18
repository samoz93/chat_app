import 'dart:io';

import 'package:app/components/chat_sliver.dart';
import 'package:app/components/user_avatar.dart';
import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/friends_manager.dart';
import 'package:app/stores/private_chat_store.dart';
import 'package:app/utils/throttler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivateChatPage extends StatefulWidget {
  static const route = "/private";
  final String peerId;
  const PrivateChatPage({super.key, required this.peerId});

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  late final PrivateChatStore _store;
  final _scrlCtrl = ScrollController();
  late ReactionDisposer dis;
  @override
  void initState() {
    _store = it.get<FriendsManager>().stores[widget.peerId]!;

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
    _scrlCtrl.removeListener(scrollListener);
    dis();
    super.dispose();
  }

  Widget _buildHeader(BuildContext context) {
    final padding = Platform.isAndroid
        ? EdgeInsets.only(top: 10.sp)
        : EdgeInsets.only(top: 25.sp, left: 20.sp, right: 20.sp);
    return PreferredSize(
      preferredSize: Size.fromHeight(30.sp),
      child: Container(
        padding: padding,
        child: Observer(
          builder: (context) {
            return SizedBox(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10.sp,
                    direction: Axis.horizontal,
                    children: [
                      ..._store.users.map(
                        (e) {
                          return UsersAvatar(user: e);
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ..._store.users.map(
                        (e) {
                          return Text(
                            e.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Platform.isAndroid ? _buildHeader(context) : null,
        flexibleSpace: Platform.isIOS ? _buildHeader(context) : null,
        backgroundColor: Colors.transparent,
        leading: Platform.isAndroid ? null : const SizedBox(),
      ),
      body: SafeArea(
        child: ChatSliver<PrivateChatStore>(
          store: _store,
          scrlController: _scrlCtrl,
        ),
      ),
    );
  }
}
