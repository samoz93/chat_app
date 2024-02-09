import 'package:app/models/user_dto.dart';
import 'package:data_class_plugin/data_class_plugin.dart';

part 'room_events_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class RoomsEventsDto {
  RoomsEventsDto.ctor();

  /// Default constructor
  factory RoomsEventsDto({
    required String room,
    required List<User> users,
    required String type,
  }) = _$RoomsEventsDtoImpl;

  String get room;

  List<User> get users;

  String get type;

  /// Creates an instance of [RoomsEventsDto] from [json]
  factory RoomsEventsDto.fromJson(Map<dynamic, dynamic> json) =
      _$RoomsEventsDtoImpl.fromJson;

  /// Converts [RoomsEventsDto] to a [Map] json
  Map<String, dynamic> toJson();
}
