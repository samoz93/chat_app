import 'dart:async';

import 'package:app/constants/graph_queries.dart';
import 'package:app/helpers/chat_exceptions.dart';
import 'package:app/models/room_dto.dart';
import 'package:app/services/graph_client.dart';
import 'package:app/services/locator.dart';
import 'package:graphql/client.dart';

class RoomsRepo {
  final _graphClient = it.get<GraphClient>();

  FutureOr<List<RoomDto>> getRooms() async {
    final options = QueryOptions(document: gql(getRoomsQuery));
    final result = await _graphClient.client.query(options);
    if (result.hasException) {
      throw ChatException(exception: result.exception!);
    }

    final data = result.data?['getRooms'] as List ?? [];
    return data.map((e) => RoomDto.fromJson(e)).toList();
  }
}
