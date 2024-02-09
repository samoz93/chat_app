import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'rooms_store.g.dart';

class RoomsStore = _RoomsStore with _$RoomsStore;

const DEFAULT_GROUPING_MAX = 60 * 24; // 24 hours
const DEFAULT_GROUPING_MIN = 5; // 5 minute
const DEFAULT_GROUPING_MIDDLE = 60; // 30 minutes
const grouping = {
  "max": DEFAULT_GROUPING_MAX,
  "min": DEFAULT_GROUPING_MIN,
  "middle": DEFAULT_GROUPING_MIDDLE,
};

abstract class _RoomsStore with Store {
  final _io = it.get<SocketService>();
  final storage = it.get<LocalStorage>();

  _RoomsStore() {
    _io.room_stream.listen((event) {
      final users =
          event.users.where((element) => element.id != storage.me?.id).toList();

      updateRoom(event.room, users);
    });

    _io.message_stream.listen((message) {
      appendMessage(message.room, message);
    });

    _io.old_messages_stream.listen((event) {
      messages = {
        ...messages,
        event.room: event.messages.where((element) {
          switch (element.runtimeType) {
            case AdminMessage():
              return false;
            default:
              return true;
          }
        }).toList()
      };
    });
  }

  @observable
  Map<String, List<User>> rooms = {};

  @observable
  Map<String, List<Message>> messages = {};

  List<(String, List<Message>)> messageGroups(roomId) {
    final List<(String, List<Message>)> groups = [];
    final megs = messages[roomId] ?? [];
    final List<Message> lastMessages = [];

    for (var i = 0; i < megs.length; i++) {
      final dateDiff = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(megs[i].createdAt))
          .inMinutes;
      Duration subDuration;
      DateFormat formatter;
      switch (dateDiff) {
        case > DEFAULT_GROUPING_MAX: // > 24 hours
          final groupCount = (dateDiff / DEFAULT_GROUPING_MAX).floor();
          subDuration = Duration(days: groupCount);
          formatter = DateFormat.MMMd();
          final dateGroup = DateTime.now().subtract(subDuration);
          final key = formatter.format(dateGroup);
          var data = groups.where((element) {
            return element.$1 == key;
          });
          if (data.isEmpty) {
            groups.add((key, [megs[i]]));
          } else {
            data.first.$2.add(megs[i]);
          }
          break;
        case > DEFAULT_GROUPING_MIDDLE:
          final groupCount = (dateDiff / DEFAULT_GROUPING_MAX).floor();
          subDuration = Duration(minutes: groupCount * DEFAULT_GROUPING_MIDDLE);
          formatter = DateFormat("MMMMd HH:mm");
          final dateGroup = DateTime.now().subtract(subDuration);
          final key = formatter.format(dateGroup);
          var data = groups.where((element) {
            return element.$1 == key;
          });
          if (data.isEmpty) {
            groups.add((key, [megs[i]]));
          } else {
            data.first.$2.add(megs[i]);
          }
        case > DEFAULT_GROUPING_MIN:
          final groupCount = (dateDiff / DEFAULT_GROUPING_MIN).floor();
          subDuration = Duration(minutes: groupCount * DEFAULT_GROUPING_MIN);
          formatter = DateFormat.Hm();
          final dateGroup = DateTime.now().subtract(subDuration);
          final key = formatter.format(dateGroup);
          var data = groups.where((element) {
            return element.$1 == key;
          });
          if (data.isEmpty) {
            groups.add((key, [megs[i]]));
          } else {
            data.first.$2.add(megs[i]);
          }
          break;
        default:
          lastMessages.add(megs[i]);
      }
    }
    groups.add(("Now", lastMessages));
    return groups;
  }

  List<(String, List<Message>)> messageGroups2(roomId) {
    final megs = messages[roomId] ?? [];
    List<(String, List<Message>)> list = [];
    List<Message> leftOver = [];
    final breakPoints = {};
    final data = megs.forEach((p0) {
      final date = DateTime.fromMillisecondsSinceEpoch(p0.createdAt);
      final dateDiff = DateTime.now().difference(date).inMinutes;
      switch (dateDiff) {
        case > 24 * 60:
          var entry =
              list.firstWhereOrNull((element) => element.$1 == "yesterday");
          if (entry == null) {
            list.add(("yesterday", [p0]));
          } else {
            entry.$2.add(p0);
          }
        case > 12 * 60:
          var entry = list.firstWhereOrNull((element) => element.$1 == "today");
          if (entry == null) {
            list.add(("today", [p0]));
          } else {
            entry.$2.add(p0);
          }
        case > 6 * 60:
          if (!breakPoints.containsKey("12")) {
            breakPoints["12"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['12']);
          if (entry == null) {
            list.add((breakPoints['12'], [p0]));
          } else {
            entry.$2.add(p0);
          }
        case > 3 * 60:
          if (!breakPoints.containsKey("6")) {
            breakPoints["6"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['6']);
          if (entry == null) {
            list.add((breakPoints['6'], [p0]));
          } else {
            entry.$2.add(p0);
          }
        case > 1 * 60:
          if (!breakPoints.containsKey("3")) {
            breakPoints["3"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['3']);
          if (entry == null) {
            list.add((breakPoints['3'], [p0]));
          } else {
            entry.$2.add(p0);
          }
        case > 15:
          if (!breakPoints.containsKey("1")) {
            breakPoints["1"] = DateFormat.Hm().format(date);
          }
          var entry = list
              .firstWhereOrNull((element) => element.$1 == breakPoints['1']);
          if (entry == null) {
            list.add((breakPoints['1'], [p0]));
          } else {
            entry.$2.add(p0);
          }
        default:
          leftOver.add(p0);
        // var entry = list
        //     .firstWhereOrNull((element) => element.$1 == breakPoints["Now"]);
        // if (entry == null) {
        //   list.add(("Now", [p0]));
        // } else {
        //   entry.$2.add(p0);
        // }
      }
    });
    return list..add(("Now", leftOver));
  }

  @action
  void updateRoom(String room, List<User> users) {
    rooms = {...rooms, room: users};
  }

  @action
  void appendMessage(String room, Message message) {
    final newMessages = (messages[room] ?? [])..add(message);
    messages = {...messages, room: newMessages};
  }

  @action
  void leaveRoom(String room) {
    _io.leaveRoom(room);
    rooms.remove(room);
    messages.remove(room);
  }

  @action
  void joinRoom(String room) {
    _io.joinRoom(room);
  }

  @action
  void sendMessage(String message, String room) {
    _io.sendMessageToRoom(message, room);
  }
}
