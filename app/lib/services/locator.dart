import 'package:app/repos/auth_repo.dart';
import 'package:app/repos/rooms_repo.dart';
import 'package:app/services/dio_service.dart';
import 'package:app/services/graph_client.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/stores/friends_manager.dart';
import 'package:app/stores/main_store.dart';
import 'package:app/stores/rooms_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final it = GetIt.instance;

Future<void> setup() async {
  it.allowReassignment = kDebugMode;
  await Hive.initFlutter();

  final storage = LocalStorage();
  await storage.init();

  // Local storage
  it.registerSingleton<LocalStorage>(storage);
  it.registerSingleton<Dio>(getDioClient());
  // Socket service, will depend on local storage
  it.registerSingleton(SocketService());
  it.registerSingleton(GraphClient());
  it.registerSingleton(AuthRepo());
  it.registerSingleton(ChatRepo());
  it.registerSingleton<FriendsManager>(FriendsManager());
  it.registerSingleton<RoomsManager>(RoomsManager());
  it.registerSingleton(AuthStore());
  it.registerSingleton(MainStore());

  await it.allReady();
}

reRegisterSocket() {
  it.get<SocketService>().destroy();
  it.unregister<SocketService>();
  it.registerSingletonWithDependencies(
    () {
      return SocketService();
    },
    dependsOn: [LocalStorage],
  );
}
