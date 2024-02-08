import 'dart:async';

import 'package:app/constants/config.dart';
import 'package:app/models/message_dto.dart';
import 'package:app/models/room_events_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const List EVENTS = [];

class SocketService {
  final storage = it.get<LocalStorage>();

  final _message_controller = StreamController<MessageDto>.broadcast();
  final _room_controller = StreamController<RoomsEventsDto>.broadcast();

  get message_stream => _message_controller.stream;
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

  sendMessage(String event, dynamic data) {
    final msg = {
      "user": storage.me?.id,
      "event": event,
      "data": data,
    };

    socket?.emitWithAck("event", msg, ack: (data) {}, binary: false);
  }

  var _toggle = false;

  _setListener() {
    socket?.on("newMessage", (data) {
      prettyPrint('new message $data');
    });

    socket?.on("roomEvents", (data) {
      var event = RoomsEventsDto.fromJson(data);
      _room_controller.add(event);
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
    socket?.onConnectTimeout((data) {
      prettyPrint('connect timeout $data');
    });
    socket?.onError((data) {
      prettyPrint('error $data');
    });
    socket?.onReconnect((data) {
      prettyPrint('reconnect $data');
    });
    socket?.onReconnectAttempt((data) {
      prettyPrint('reconnect attempt $data');
    });
    socket?.onReconnecting((data) {
      prettyPrint('reconnecting $data');
    });
    socket?.onReconnectError((data) {
      prettyPrint('reconnect error $data');
    });
    socket?.onReconnectFailed((data) {
      prettyPrint('reconnect failed $data');
    });
  }

  joinRoom(String roomId) {
    if (_toggle) {
      return leaveRoom(roomId);
    }
    socket?.emit("join", roomId);
    _toggle = !_toggle;
  }

  leaveRoom(String roomId) {
    if (!_toggle) {
      return joinRoom(roomId);
    }
    socket?.emit("leave", roomId);
    _toggle = !_toggle;
  }

  destroy() {
    socket?.disconnect();
    socket?.dispose();
  }
}
