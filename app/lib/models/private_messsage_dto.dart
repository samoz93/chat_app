import 'package:app/models/sealed_classes.dart';
import 'package:app/models/user_dto.dart';
import 'package:data_class_plugin/data_class_plugin.dart';

part 'private_messsage_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class PrivateMessageDto extends Message {
  PrivateMessageDto.ctor();

  /// Default constructor
  factory PrivateMessageDto({
    required String message,
    required User sender,
    required String receiver,
    required int createdAt,
  }) = _$PrivateMessageDtoImpl;

  @override
  String get message;

  User get sender;

  @override
  String get receiver;

  @override
  int get createdAt;

  /// Creates an instance of [PrivateMessageDto] from [json]
  factory PrivateMessageDto.fromJson(Map<dynamic, dynamic> json) =
      _$PrivateMessageDtoImpl.fromJson;

  /// Converts [PrivateMessageDto] to a [Map] json
  Map<String, dynamic> toJson();
}
