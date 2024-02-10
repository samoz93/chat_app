import 'package:app/components/user_avatar.dart';
import 'package:app/models/message_dto.dart';
import 'package:app/models/private_messsage_dto.dart';
import 'package:app/models/sealed_classes.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final me = it.get<LocalStorage>().me;
    bool isMe = false;
    User? sender;
    bool isAdmin = false;
    if (message is RoomMessageDto) {
      sender = (message as RoomMessageDto).sender;
      isMe = me?.id == sender.id;
    } else if (message is PrivateMessageDto) {
      sender = (message as PrivateMessageDto).sender;
      isMe = me?.id == sender.id;
    } else {
      isAdmin = true;
    }
    final theme = Theme.of(context);
    var marginLeft = 5.w;
    var marginRight = 5.w;
    if (isMe) {
      marginLeft = 20.w;
    } else {
      marginLeft = 8.w;
      marginRight = 10.w;
    }
    final marginBottom = 15.sp;
    if (isAdmin) {
      return Container(
        margin: EdgeInsets.only(
          bottom: marginBottom,
          left: marginLeft,
          right: marginRight,
        ),
        alignment: Alignment.center,
        child: Text(
          message.message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      );
    }
    return Stack(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 35.sp,
          ),
          child: Container(
            margin: EdgeInsets.only(
              bottom: marginBottom,
              left: marginLeft,
              right: marginRight,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              horizontal: isMe ? 15.sp : 26.sp,
              vertical: 5.sp,
            ),
            decoration: BoxDecoration(
              color: isMe ? theme.primaryColor : theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message.message,
              textAlign: isMe ? TextAlign.end : TextAlign.start,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        !isMe && sender != null
            ? Positioned(
                right: marginRight * .5,
                top: 0,
                child: UsersAvatar(user: sender),
              )
            : const SizedBox(),
      ],
    );
  }
}
