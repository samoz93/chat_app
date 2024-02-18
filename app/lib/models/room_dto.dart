import 'package:data_class_plugin/data_class_plugin.dart';

part 'room_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class RoomDto {
  RoomDto.ctor();

  /// Default constructor
  factory RoomDto({
    required String id,
    required String name,
    required String description,
  }) = _$RoomDtoImpl;

  String get id;

  String get name;

  String get description;

  /// Creates an instance of [RoomDto] from [json]
  factory RoomDto.fromJson(Map<dynamic, dynamic> json) = _$RoomDtoImpl.fromJson;

  /// Converts [RoomDto] to a [Map] json
  Map<String, dynamic> toJson();
}
