import 'package:app/components/user_avatar.dart';
import 'package:app/models/user_dto.dart';
import 'package:app/pages/private_chat.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/friends_manager.dart';
import 'package:app/stores/private_chat_store.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final int unreadCount;
  const UserListTile({
    super.key,
    required this.user,
    required this.unreadCount,
  });

  PrivateChatStore get _store {
    return it.get<FriendsManager>().stores[user.id]!;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PrivateChatPage.route, arguments: user.id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                UsersAvatar(user: user),
                Observer(
                  builder: (context) {
                    return _store.unreadCount > 0
                        ? Positioned(
                            top: -10.sp,
                            left: -15.sp,
                            child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                child: Text(
                                  "+${_store.unreadCount}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Observer(builder: (context) {
                final lastMessage = _store.messages.lastOrNull?.message;
                final lastMessageTime = _store.messages.lastOrNull?.createdAt;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          lastMessageTime?.toFormattedString() ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lastMessage ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
