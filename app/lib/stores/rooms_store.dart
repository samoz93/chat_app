import 'package:app/models/message_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/base_chat.dart';
import 'package:mobx/mobx.dart';

part 'rooms_store.g.dart';

class RoomsStore extends RoomsStoreBase with _$RoomsStore {
  RoomsStore({required super.roomId});
}

abstract class RoomsStoreBase extends BaseChat<RoomMessageDto> with Store {
  final storage = it.get<LocalStorage>();
  final String roomId;

  @override
  bool filter(event) {
    return event.room == roomId;
  }

  RoomsStoreBase({required this.roomId}) {
    final dis = io.roomUsersStream.where((event) {
      return event.room == roomId;
    }).listen((event) {
      super.updateUsers(event.users);
    });

    disposers.add(dis);

    final dis2 = io.oldRoomMessages
        .where((event) => event.room == roomId)
        .listen((event) {
      messages = event.messages.whereType<RoomMessageDto>().toList();
    });

    disposers.add(dis2);
  }

  @action
  void leaveRoom() {
    io.leaveRoom(roomId);
    super.dispose();
  }

  @action
  void joinRoom() {
    io.joinRoom(roomId);
  }

  @override
  @action
  void sendMessage(String message) {
    io.sendMessageToRoom(message, roomId);
  }
}
