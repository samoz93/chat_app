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
abstract class MessageDto extends Message {
  MessageDto.ctor();

  /// Default constructor
  factory MessageDto({
    required int createdAt,
    required String message,
    String? room,
    required User sender,
    required String receiver,
  }) = _$MessageDtoImpl;

  @override
  String get message;

  @override
  String? get room;

  User get sender;

  @override
  String get receiver;

  @override
  int get createdAt;

  /// Creates an instance of [MessageDto] from [json]
  factory MessageDto.fromJson(Map<dynamic, dynamic> json) =
      _$MessageDtoImpl.fromJson;

  /// Converts [MessageDto] to a [Map] json
  Map<String, dynamic> toJson();
}
