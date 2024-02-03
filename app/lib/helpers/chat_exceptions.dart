import 'package:graphql/client.dart';

class ChatException implements Exception {
  final OperationException exception;
  ChatException({
    required this.exception,
  });

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
