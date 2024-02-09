import 'package:app/models/room_events_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:flutter/material.dart';

abstract class StreamBuilder<T> {
  final Stream<T> stream;
  StreamBuilder({required this.stream});

  @protected
  bool filter(T event);

  Stream<T> generate() {
    return this.stream.where(filter);
  }
}

class RoomStreamBuilder extends StreamBuilder<Message> {
  final String roomId;
  RoomStreamBuilder({required super.stream, required this.roomId});

  @override
  bool filter(Message event) {
    return event.room == roomId;
  }
}

class UserStreamBuilder extends StreamBuilder<RoomsEventsDto> {
  final String userId;
  UserStreamBuilder({required super.stream, required this.userId});

  @override
  bool filter(RoomsEventsDto event) {
    return event.users.any((user) => user.id == userId);
  }
}
