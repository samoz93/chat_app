import 'package:app/models/auth_payload.dart';
import 'package:app/models/user_dto.dart';
import 'package:hive/hive.dart';

enum StorageKeys { token, me }

class LocalStorage {
  late Box<dynamic> _usersBox;
  late Box<String> _auth;
  LocalStorage();

  init() async {
    _usersBox = await Hive.openBox("users");
    _auth = await Hive.openBox("auth");
  }

  String get token {
    return _auth.get(StorageKeys.token.toString()) ?? "";
  }

  setAuthState(AuthPayload authState) async {
    await _auth.put(StorageKeys.token.toString(), authState.token);
    await _usersBox.put(StorageKeys.me.toString(), authState.user.toJson());
  }

  User? get me {
    final json = _usersBox.get(StorageKeys.me.toString());
    if (json != null) return User.fromJson(json);
    return null;
  }

  clearAuthData() async {
    await _auth.delete(StorageKeys.token.toString());
    await _usersBox.delete(StorageKeys.me.toString());
  }

  getUserById(String id) {
    return _usersBox.get(id);
  }

  setUserById(String id, User user) async {
    await _usersBox.put(id, user);
  }
}
