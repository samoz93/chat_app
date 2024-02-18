import 'package:app/models/room_dto.dart';
import 'package:app/repos/rooms_repo.dart';
import 'package:app/services/locator.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore = MainStoreBase with _$MainStore;

abstract class MainStoreBase with Store {
  final _roomRepo = it.get<ChatRepo>();

  init() async {
    loading = true;
    try {
      final rooms = await _roomRepo.getRooms();
      this.rooms = rooms;
    } finally {
      loading = false;
    }
  }

  @observable
  var loading = false;

  @observable
  List<RoomDto> rooms = [];
}
