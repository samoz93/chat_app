import 'package:app/constants/config.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const List EVENTS = [];

class SocketService {
  final storage = it.get<LocalStorage>();

  SocketService();

  IO.Socket? socket;
  final token = it.get<LocalStorage>().token;

  void init() async {
    prettyPrint('token: $token');
    socket = IO.io(
      Config.BASE_URL,
      IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        "authorization": "Bearer $token",
      }).build(),
    );
    _setListener();
  }

  void connect() {
    socket?.connect();
    // _setListener(socket.connect());
  }

  sendMessage(String event, dynamic data) {
    final msg = {
      "user": storage.me?.id,
      "event": event,
      "data": data,
    };

    socket?.emitWithAck("event", msg, ack: (data) {
      prettyPrint('ack data: $data');
    }, binary: false);
  }

  _setListener() {
    socket?.on("newMessage", (data) {
      prettyPrint('new message $data');
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

  destroy() {
    socket?.disconnect();
    socket?.dispose();
  }
}
