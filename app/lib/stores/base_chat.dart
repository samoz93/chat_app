import 'dart:async';

import 'package:app/models/private_messsage_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'base_chat.g.dart';

const DEFAULT_GROUPING_MAX = 60 * 24; // 24 hours
const DEFAULT_GROUPING_MIN = 5; // 5 minute
const DEFAULT_GROUPING_MIDDLE = 60; // 30 minutes
const grouping = {
  "max": DEFAULT_GROUPING_MAX,
  "min": DEFAULT_GROUPING_MIN,
  "middle": DEFAULT_GROUPING_MIDDLE,
};

abstract class BaseChat<T extends Message> extends BaseChatBase<T>
    with _$BaseChat<T> {}

abstract class BaseChatBase<T extends Message> with Store {
  @protected
  final io = it.get<SocketService>();
  @protected
  final List<StreamSubscription<dynamic>> disposers = [];

  @observable
  int unreadCount = 0;

  @protected
  final me = it.get<LocalStorage>().me!;

// Don't keep track of unread messages if we are in the chat
  bool _isActiveInChat = false;

  set isActive(bool value) {
    _isActiveInChat = value;
  }

  bool get isActive => _isActiveInChat;

  BaseChatBase() {
    final dis2 = io.newMessageStream
        .where((event) => event is T && filter(event))
        .listen((message) {
      appendMessage(message as T);
      // Add unread messages for messages that are not originated from me
      if (message is PrivateMessageDto &&
          message.sender.id != me.id &&
          !isActive) {
        unreadCount++;
      }
    });

    disposers.add(dis2);
  }

  @observable
  List<T> messages = [];

  @observable
  int _page = 0;

  final _pgItems = 15;

  @computed
  int get totalPages {
    return (messages.length / _pgItems).floor() - 1;
  }

  @computed
  List<T> get messageChunck {
    final start = _page > totalPages ? 0 : totalPages - _page;
    return messages.sublist(start * _pgItems);
  }

  @observable
  List<User> users = [];

  @action
  void updateUsers(List<User> users) {
    this.users = users;
  }

  @action
  void loadMoreMessages() {
    _page = _page + 1;
  }

  @computed
  List<(String, List<T>)> get messageGroups {
    List<(String, List<T>)> list = [];
    List<T> leftOver = [];
    final breakPoints = {};
    for (var msg in messageChunck) {
      final date = DateTime.fromMillisecondsSinceEpoch(msg.createdAt);
      final dateDiff = DateTime.now().difference(date).inMinutes;
      switch (dateDiff) {
        case > 24 * 60:
          var entry =
              list.firstWhereOrNull((element) => element.$1 == "yesterday");
          if (entry == null) {
            list.add(("yesterday", [msg]));
          } else {
            entry.$2.add(msg);
          }
        case > 12 * 60:
          var entry = list.firstWhereOrNull((element) => element.$1 == "today");
          if (entry == null) {
            list.add(("today", [msg]));
          } else {
            entry.$2.add(msg);
          }
        case > 6 * 60:
          if (!breakPoints.containsKey("12")) {
            breakPoints["12"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['12']);
          if (entry == null) {
            list.add((breakPoints['12'], [msg]));
          } else {
            entry.$2.add(msg);
          }
        case > 3 * 60:
          if (!breakPoints.containsKey("6")) {
            breakPoints["6"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['6']);
          if (entry == null) {
            list.add((breakPoints['6'], [msg]));
          } else {
            entry.$2.add(msg);
          }
        case > 1 * 60:
          if (!breakPoints.containsKey("3")) {
            breakPoints["3"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['3']);
          if (entry == null) {
            list.add((breakPoints['3'], [msg]));
          } else {
            entry.$2.add(msg);
          }
        case > 15:
          if (!breakPoints.containsKey("1")) {
            breakPoints["1"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['1']);
          if (entry == null) {
            list.add((breakPoints['1'], [msg]));
          } else {
            entry.$2.add(msg);
          }
        default:
          leftOver.add(msg);
      }
    }
    return list..add(("Now", leftOver));
  }

  @action
  void appendMessage(T message) {
    messages = [...messages, message];
  }

  @protected
  bool filter(T event);

  void dispose() {
    for (var disposer in disposers) {
      disposer.cancel();
    }
  }

  sendMessage(String text);

  @action
  clearUnread() {
    unreadCount = 0;
  }
}
