import 'package:app/models/admin_mesage_dto.dart';
import 'package:app/models/message_dto.dart';
import 'package:app/models/sealed_classes.dart';

class OldMessagesDto {
  final List<Message> messages;
  final String room;

  OldMessagesDto({
    required this.messages,
    required this.room,
  });

  factory OldMessagesDto.fromJson(Map<String, dynamic> json) {
    return OldMessagesDto(
      messages: (json['messages'] as List).map((e) {
        if (e['sender'] is String) {
          return AdminMessage.fromJson(e);
        } else {
          return MessageDto.fromJson(e);
        }
      }).toList(),
      room: json['room'],
    );
  }
}
