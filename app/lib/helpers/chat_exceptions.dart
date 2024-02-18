import 'package:app/repos/auth_repo.dart';
import 'package:app/services/locator.dart';
import 'package:graphql/client.dart';

class ChatException implements Exception {
  final OperationException exception;
  ChatException({
    required this.exception,
  }) {
    if (exception.graphqlErrors.first.message == "Invalid token") {
      it.get<AuthRepo>().logout();
    }
  }

  @override
  String toString() {
    if (exception.graphqlErrors.isNotEmpty) {
      return exception.graphqlErrors.first.message;
    }
    if (exception.linkException != null) {
      return exception.linkException.toString();
    }

    return exception.toString();
  }
}
