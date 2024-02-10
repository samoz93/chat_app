import 'dart:async';

import 'package:app/constants/config.dart';
import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/models/message_dto.dart';
import 'package:app/models/old_messages_dto.dart';
import 'package:app/models/private_chat_dto.dart';
import 'package:app/models/private_messsage_dto.dart';
import 'package:app/models/room_events_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const List EVENTS = [];

class SocketService {
  final _storage = it.get<LocalStorage>();

  final _newMessageController = StreamController<Message>.broadcast();
  final _roomEventsController = StreamController<RoomsEventsDto>.broadcast();
  final _oldRoomMessagesControllers =
      StreamController<OldMessagesDto>.broadcast();
  final _privateChatController = StreamController<PrivateChatDto>.broadcast();

  Stream<Message> get newMessageStream => _newMessageController.stream;
  Stream<OldMessagesDto> get oldRoomMessages =>
      _oldRoomMessagesControllers.stream;
  Stream<RoomsEventsDto> get roomUsersStream => _roomEventsController.stream;
  Stream<PrivateChatDto> get privateChatStream => _privateChatController.stream;

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
    final data = RoomMessageDto(
      message: message,
      room: roomId,
      receiver: "",
      sender: _storage.me!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    socket?.emit("message", data.toJson());
  }

  sendMessageToUser(String message, String userId) {
    final data = RoomMessageDto(
      message: message,
      receiver: userId,
      sender: _storage.me!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    socket?.emit("message", data.toJson());
  }

  // sendMessageToUser(String message, String userId) {
  //   socket?.emitWithAck("event", data.toJson(), ack: (data) {}, binary: false);
  // }

  _setListener() {
    socket?.on("newMessage", (data) {
      Message message;
      if (data['sender'] is String) {
        message = AdminMessage.fromJson(data);
      } else if (data['room'] != null) {
        message = RoomMessageDto.fromJson(data);
      } else {
        message = PrivateMessageDto.fromJson(data);
      }
      _newMessageController.add(message);
    });

    socket?.on("roomEvents", (data) {
      final event = RoomsEventsDto.fromJson(data);
      _roomEventsController.add(event);
    });

    socket?.on("oldRoomMessages", (data) {
      final oldRoomMessages = OldMessagesDto.fromJson(data);
      _oldRoomMessagesControllers.add(oldRoomMessages);
    });

    // socket?.on("unreadPrivateMessages", (data) {
    //   final message = (data as List).map((e) => PrivateMessageDto.fromJson(e));
    //   _missingPrivateMessageStream.add(message.toList());
    // });

    socket?.on("onPrivateChat", (data) {
      final chat = PrivateChatDto.fromJson(data);
      _privateChatController.add(chat);
    });

    socket?.onConnect((data) {
      prettyPrint('+++++++connected $data');
    });
    socket?.onDisconnect((data) {
      prettyPrint('disconnected $data');
    });
    socket?.onConnectError((data) {
      prettyPrint('connect error $data');
    });
    socket?.onError((data) {
      prettyPrint('++++error $data');
    });
    socket?.onReconnect((data) {
      prettyPrint('reconnected $data');
    });
  }

  joinRoom(String roomId) {
    socket?.emit("join", roomId);
  }

  leaveRoom(String roomId) {
    socket?.emit("leave", roomId);
  }

  joinChat(String userId) {
    socket?.emit("joinPrivateChat", userId);
  }

  destroy() {
    socket?.disconnect();
    socket?.dispose();
  }
}
