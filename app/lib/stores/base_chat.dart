import 'dart:async';

import 'package:app/models/sealed_classes.dart';
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

class BaseChat extends BaseChatBase with _$BaseChat {
  @override
  bool filter(event) {
    // TODO: implement filter
    throw UnimplementedError();
  }
}

abstract class BaseChatBase with Store {
  final _io = it.get<SocketService>();
  @protected
  final List<StreamSubscription<dynamic>> disposers = [];
  BaseChatBase() {
    final dis2 = _io.message_stream.where(filter).listen((message) {
      appendMessage(message);
    });

    disposers.add(dis2);
  }

  @observable
  List<Message> messages = [];

  @observable
  int _page = 0;

  final _pgItems = 15;

  @computed
  int get totalPages {
    return (messages.length / _pgItems).floor() - 1;
  }

  @computed
  List<Message> get messageChunck {
    final start = _page > totalPages ? 0 : totalPages - _page;
    return messages.sublist(start * _pgItems);
  }

  @action
  void loadMoreMessages() {
    _page = _page + 1;
  }

  @computed
  List<(String, List<Message>)> get messageGroups {
    List<(String, List<Message>)> list = [];
    List<Message> leftOver = [];
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
  void appendMessage(Message message) {
    messages = [...messages, message];
  }

  @protected
  bool filter(event);

  void dispose() {
    for (var disposer in disposers) {
      disposer.cancel();
    }
  }
}