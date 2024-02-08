import 'package:data_class_plugin/data_class_plugin.dart';

part 'message_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class MessageDto {
  MessageDto.ctor();

  /// Default constructor
  factory MessageDto({
    required String message,
    required String sender,
    required String receiver,
    String? room,
  }) = _$MessageDtoImpl;

  String get message;

  String get sender;

  String get receiver;

  String? get room;

  /// Creates an instance of [MessageDto] from [json]
  factory MessageDto.fromJson(Map<dynamic, dynamic> json) =
      _$MessageDtoImpl.fromJson;

  /// Converts [MessageDto] to a [Map] json
  Map<String, dynamic> toJson();
}
