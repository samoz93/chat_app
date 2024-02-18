import 'package:app/constants/config.dart';
import 'package:app/services/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

class GraphClient {
  final localStorage = GetIt.I.get<LocalStorage>();

  late GraphQLClient client;
  GraphClient() {
    final httpLink = HttpLink(Config.GRAPH_BASE_URL);
    final authLink = AuthLink(
      getToken: () {
        return 'Bearer ${localStorage.token}';
      },
    );

    client = GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(httpLink),
    );
  }
}
