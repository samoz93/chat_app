import 'package:app/models/user_dto.dart';
import 'package:app/repos/rooms_repo.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/base_loadable_store.dart';
import 'package:app/stores/private_chat_store.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:mobx/mobx.dart';

part 'friends_manager.g.dart';

class FriendsManager = FriendsManagerBase with _$FriendsManager;

abstract class FriendsManagerBase extends BaseLoadableStore with Store {
  @observable
  Set<User> _friends = {};

  @computed
  Set<User> get friends {
    prettyPrint(search);
    if (search.isEmpty) {
      return _friends;
    }
    return _friends.where((element) => element.name.contains(search)).toSet();
  }

  final _chatRepo = it.get<ChatRepo>();
  final _client = it.get<SocketService>();

  FriendsManagerBase() {
    _client.friendsStream.listen((event) {
      friends.add(event);
      // Trigger update
      _friends = {...friends};
    });
  }

  @action
  initState() async {
    final data = await super.getData(_chatRepo.getFriends());
    if (data != null) {
      _friends = {...data};
    }
  }

  final Map<String, PrivateChatStore> _chatMap = {};

  @computed
  Map<String, PrivateChatStore> get stores {
    for (var element in friends) {
      if (!_chatMap.containsKey(element.id)) {
        _chatMap[element.id] = PrivateChatStore(peerId: element.id);
      }
    }
    return _chatMap;
  }
}
