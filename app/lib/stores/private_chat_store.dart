import 'package:app/models/private_messsage_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/base_chat.dart';
import 'package:mobx/mobx.dart';

part 'private_chat_store.g.dart';

class PrivateChatStore extends PrivateChatStoreBase with _$PrivateChatStore {
  PrivateChatStore({required super.peerId});
}

abstract class PrivateChatStoreBase extends BaseChat<PrivateMessageDto>
    with Store {
  final storage = it.get<LocalStorage>();
  final String peerId;

  @override
  bool filter(PrivateMessageDto event) {
    return true;
  }

  PrivateChatStoreBase({required this.peerId}) {
    joinChat();
    // Get other user information
    // Get old Messages
    final dis = io.privateChatStream.listen((event) {
      if (event.peer.id == peerId) {
        users = [me, event.peer];
        messages = event.oldMessages;
      }
    });

    disposers.add(dis);
  }

  @override
  @action
  void sendMessage(String message) {
    io.sendMessageToUser(message, peerId);
  }

  @action
  void joinChat() {
    io.joinChat(peerId);
  }
}
