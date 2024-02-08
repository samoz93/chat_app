import 'package:app/models/user_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:mobx/mobx.dart';

part 'rooms_store.g.dart';

class RoomsStore = _RoomsStore with _$RoomsStore;

abstract class _RoomsStore with Store {
  final _io = it.get<SocketService>();

  _RoomsStore() {
    _io.room_stream.listen((event) {
      final storage = it.get<LocalStorage>();
      prettyPrint(event.room, event.type, storage.me?.id, event.user.id);
      if (storage.me?.id == event.user.id) return;

      if (event.type == "join") {
        joinRoom(event.room, event.user);
      } else {
        leaveRoom(event.room, event.user);
      }
    });
  }

  @observable
  Map<String, List<User>> rooms = {};

  @action
  void joinRoom(String room, User user) {
    prettyPrint(room, "join");
    List<User> newUsers = [user, ...(rooms[room] ?? [])];
    rooms = {...rooms, room: newUsers};
  }

  @action
  void leaveRoom(String room, User user) {
    List<User> newUsers =
        (rooms[room] ?? []).where((element) => element.id != user.id).toList();
    rooms = {...rooms, room: newUsers};
  }
}
