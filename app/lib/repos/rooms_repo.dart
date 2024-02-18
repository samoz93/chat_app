import 'dart:async';

import 'package:app/constants/graph_queries.dart';
import 'package:app/helpers/chat_exceptions.dart';
import 'package:app/models/room_dto.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/services/graph_client.dart';
import 'package:app/services/locator.dart';
import 'package:graphql/client.dart';

class ChatRepo {
  final _graphClient = it.get<GraphClient>();

  Future<List<RoomDto>> getRooms() async {
    final options = QueryOptions(document: gql(getRoomsQuery));
    final result = await _graphClient.client.query(options);
    if (result.hasException) {
      throw ChatException(exception: result.exception!);
    }

    final data = result.data?['getRooms'] as List ?? [];
    return data.map((e) => RoomDto.fromJson(e)).toList();
  }

  Future<List<User>> getFriends() async {
    final QueryOptions options = QueryOptions(document: gql(friendsQuery));

    final result = await _graphClient.client.query(options);

    if (result.hasException) {
      throw ChatException(exception: result.exception!);
    }

    final List<User> data = result.data!['getFriends'] != null
        ? (result.data!['getFriends'] as List)
            .map((e) => User.fromJson(e))
            .toList()
        : [];

    return data;
  }
}
