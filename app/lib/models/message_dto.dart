import 'package:app/models/sealed_classes.dart';
import 'package:app/models/user_dto.dart';
import 'package:data_class_plugin/data_class_plugin.dart';

part 'message_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class RoomMessageDto extends Message {
  RoomMessageDto.ctor();

  /// Default constructor
  factory RoomMessageDto({
    required String message,
    String? room,
    required User sender,
    required String receiver,
    required int createdAt,
  }) = _$RoomMessageDtoImpl;

  @override
  String get message;

  @override
  String? get room;

  User get sender;

  @override
  String get receiver;

  @override
  int get createdAt;

  /// Creates an instance of [RoomMessageDto] from [json]
  factory RoomMessageDto.fromJson(Map<dynamic, dynamic> json) =
      _$RoomMessageDtoImpl.fromJson;

  /// Converts [RoomMessageDto] to a [Map] json
  Map<String, dynamic> toJson();
}
