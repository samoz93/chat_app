import 'package:app/models/private_messsage_dto.dart';
import 'package:app/models/user_dto.dart';
import 'package:data_class_plugin/data_class_plugin.dart';

part 'private_chat_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class PrivateChatDto {
  PrivateChatDto.ctor();

  /// Default constructor
  factory PrivateChatDto({
    required User peer,
    required List<PrivateMessageDto> oldMessages,
  }) = _$PrivateChatDtoImpl;

  User get peer;

  List<PrivateMessageDto> get oldMessages;

  /// Creates an instance of [PrivateChatDto] from [json]
  factory PrivateChatDto.fromJson(Map<dynamic, dynamic> json) =
      _$PrivateChatDtoImpl.fromJson;

  /// Converts [PrivateChatDto] to a [Map] json
  Map<String, dynamic> toJson();
}
