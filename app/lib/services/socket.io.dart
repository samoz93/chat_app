import 'dart:async';

import 'package:app/constants/config.dart';
import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/models/message_dto.dart';
import 'package:app/models/old_messages_dto.dart';
import 'package:app/models/room_events_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const List EVENTS = [];

class SocketService {
  final storage = it.get<LocalStorage>();

  final _message_controller = StreamController<Message>.broadcast();
  final _room_controller = StreamController<RoomsEventsDto>.broadcast();
  final _old_messages = StreamController<OldMessagesDto>.broadcast();

  Stream<Message> get message_stream => _message_controller.stream;
  Stream<OldMessagesDto> get old_messages_stream => _old_messages.stream;
  Stream<RoomsEventsDto> get room_stream => _room_controller.stream;

  SocketService();

  IO.Socket? socket;
  final token = it.get<LocalStorage>().token;

  void init() async {
    socket = IO.io(
      Config.BASE_URL,
      IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        "authorization": "Bearer $token",
      }).build(),
    );
    _setListener();
  }

  sendMessageToRoom(String message, String roomId) {
    final data = MessageDto(
      message: message,
      room: roomId,
      receiver: "",
      sender: storage.me!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    socket?.emit("message", data.toJson());
  }

  // sendMessageToUser(String message, String userId) {
  //   socket?.emitWithAck("event", data.toJson(), ack: (data) {}, binary: false);
  // }

  final _toggle = false;

  _setListener() {
    socket?.on("newMessage", (data) {
      Message message;
      if (data['sender'] is String) {
        message = AdminMessage.fromJson(data);
      } else {
        message = MessageDto.fromJson(data);
      }
      _message_controller.add(message);
    });

    socket?.on("roomEvents", (data) {
      var event = RoomsEventsDto.fromJson(data);
      _room_controller.add(event);
    });

    socket?.on("oldMessages", (data) {
      var oldMessages = OldMessagesDto.fromJson(data);
      _old_messages.add(oldMessages);
    });

    socket?.onConnect((data) {
      prettyPrint('connected $data');
    });
    socket?.onDisconnect((data) {
      prettyPrint('disconnected $data');
    });
    socket?.onConnectError((data) {
      prettyPrint('connect error $data');
    });
    socket?.onError((data) {
      prettyPrint('error $data');
    });
  }

  joinRoom(String roomId) {
    socket?.emit("join", roomId);
  }

  leaveRoom(String roomId) {
    socket?.emit("leave", roomId);
  }

  destroy() {
    socket?.disconnect();
    socket?.dispose();
  }
}
