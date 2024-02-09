import 'package:app/repos/auth_repo.dart';
import 'package:app/services/graph_client.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/auth_store.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final it = GetIt.instance;

Future<void> setup() async {
  it.allowReassignment = kDebugMode;
  await Hive.initFlutter();

  // Local storage
  it.registerSingletonAsync<LocalStorage>(() async {
    final storage = LocalStorage();
    await storage.init();
    return storage;
  });

  // Socket service, will depend on local storage
  it.registerSingletonWithDependencies<SocketService>(
    () {
      return SocketService();
    },
    dependsOn: [LocalStorage],
  );

  it.registerSingletonWithDependencies<GraphClient>(
    () => GraphClient(),
    dependsOn: [LocalStorage],
  );

  it.registerSingletonWithDependencies<AuthRepo>(
    () => AuthRepo(),
    dependsOn: [GraphClient],
  );

  it.registerSingletonWithDependencies<AuthStore>(
    () => AuthStore(),
    dependsOn: [AuthRepo],
  );

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
