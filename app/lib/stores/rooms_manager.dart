import 'package:app/models/room_dto.dart';
import 'package:app/repos/rooms_repo.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/base_loadable_store.dart';
import 'package:app/utils/await_to_dart.dart';
import 'package:mobx/mobx.dart';

part "rooms_manager.g.dart";

class RoomsManager = RoomsManagerBase with _$RoomsManager;

abstract class RoomsManagerBase extends BaseLoadableStore with Store {
  final _roomRepo = it.get<ChatRepo>();

  @action
  initState() async {
    _rooms = await super.getData(_roomRepo.getRooms()) ?? [];
  }

  @observable
  List<RoomDto> _rooms = [];

  @computed
  List<RoomDto> get rooms {
    if (search.isEmpty) {
      return _rooms;
    }

    return _rooms.where((element) => element.name.contains(search)).toList();
  }

  @action
  Future<void> createRoom(RoomDto room) async {
    final (err, data) = await to(_roomRepo.createRoom(room));
    if (err != null) {
      setError(err);
      return;
    }
    if (data != null) {
      _rooms.insert(0, data);
      _rooms = [..._rooms];
    }
  }
}
