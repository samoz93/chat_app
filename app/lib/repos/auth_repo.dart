import 'package:app/constants/graph_queries.dart';
import 'package:app/helpers/chat_exceptions.dart';
import 'package:app/models/auth_payload.dart';
import 'package:app/services/graph_client.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:graphql/client.dart';

class AuthRepo {
  final GraphClient _graphClient = it.get<GraphClient>();
  final _localStorage = it.get<LocalStorage>();

  get token => _localStorage.token;
  get me => _localStorage.me;

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
}
