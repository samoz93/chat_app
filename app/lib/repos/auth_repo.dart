import 'package:app/constants/graph_queries.dart';
import 'package:app/helpers/chat_exceptions.dart';
import 'package:app/models/auth_payload.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/services/graph_client.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:graphql/client.dart';

class AuthRepo {
  final GraphClient _graphClient = it.get<GraphClient>();
  final _localStorage = it.get<LocalStorage>();

  String get token => _localStorage.token;
  User? get me => _localStorage.me;

  AuthRepo() {
    // Refresh token if we had a successful login before
    if (_localStorage.refreshToken.isNotEmpty) {
      refreshToken();
    }
  }

  Future<AuthPayload?> login(String email, String password) async {
    final MutationOptions options = MutationOptions<AuthPayload>(
        document: gql(loginMutation),
        variables: {'email': email, "password": password});

    final QueryResult result = await _graphClient.client.mutate(options);
    if (result.hasException) {
      throw ChatException(exception: result.exception!);
    }

    final data = result.data?['login'] != null
        ? AuthPayload.fromJson(result.data?['login'])
        : null;

    if (data?.token != null) {
      await _localStorage.setAuthState(data!);
    }

    return data;
  }

  Future<AuthPayload?> signup(
    String email,
    String password,
    String name,
  ) async {
    final MutationOptions options = MutationOptions<AuthPayload>(
        document: gql(signupMutation),
        variables: {'email': email, "password": password, "name": name});

    final result = await _graphClient.client.mutate(options);

    if (result.hasException) {
      throw ChatException(exception: result.exception!);
    }

    final data = result.data?['signUp'] != null
        ? AuthPayload.fromJson(result.data?['signUp'])
        : null;

    if (data?.token != null) {
      await _localStorage.setAuthState(data!);
    }

    return data;
  }

  Future<void> logout() async {
    await _localStorage.clearAuthData();
  }

  Future refreshToken() async {
    if (_localStorage.me == null) return;
    final QueryOptions options = QueryOptions<AuthPayload>(
        document: gql(refreshTokenQuery),
        variables: {"refreshToken": _localStorage.refreshToken});

    final result = await _graphClient.client.query(options);

    if (result.hasException) {
      // TODO: handle refresh token error
      // throw ChatException(exception: result.exception!);
      return;
    }

    final data = result.data!['Refresh'] != null
        ? AuthPayload.fromJson(result.data!['Refresh'])
        : null;

    if (data != null) {
      await _localStorage.setAuthState(data);
    }
  }
}
