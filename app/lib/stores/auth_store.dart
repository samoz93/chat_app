import 'package:app/models/auth_payload.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/repos/auth_repo.dart';
import 'package:app/services/locator.dart';
import 'package:app/utils/await_to_dart.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final _repo = it.get<AuthRepo>();

  _AuthStore() {
    token = _repo.token;
    me = _repo.me;
  }

  @observable
  User? me;

  @observable
  dynamic error;

  @observable
  bool loading = false;

  @observable
  String? token;

  @computed
  bool get isLoggedIn => token != null && token!.isNotEmpty;

  @action
  Future<(dynamic, AuthPayload?)> login(String email, String password) async {
    final (err, result) = await to(_repo.login(email, password));
    if (err != null) {
      error = err;
    } else {
      me = result!.user;
    }

    return (err, result);
  }

  @action
  signup({
    required String email,
    required String password,
    required String name,
  }) async {
    final (err, result) = await to(_repo.signup(email, password, name));
    if (err != null) {
      error = err;
    } else {
      me = result!.user;
    }

    return (err, result);
  }

  @action
  signout() async {
    await _repo.logout();
    me = null;
    token = null;
  }
}
