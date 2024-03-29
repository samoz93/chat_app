import 'package:app/models/user_dto.dart';
import 'package:app/pages/private_chat.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UsersAvatar extends StatelessWidget {
  final User user;
  final int? index;
  final bool disableClick;
  UsersAvatar(
      {super.key, required this.user, this.index, this.disableClick = false});

  final _storage = it.get<LocalStorage>();
  @override
  Widget build(BuildContext context) {
    final height = 30.sp;
    final margin = index == null ? 0.sp : height * .1;
    final marginTop = (index ?? 0) % 2 == 0 ? 0.sp : margin * 2;
    final marginBottom = (index ?? 0) % 2 == 0 ? margin * 2 : 0.sp;

    return GestureDetector(
      onTap: () {
        if (user.id == _storage.me!.id || disableClick) return;
        Navigator.of(context)
            .pushNamed(PrivateChatPage.route, arguments: user.id);
      },
      child: Container(
        width: height,
        height: height,
        margin: EdgeInsets.only(
          top: marginTop,
          bottom: marginBottom,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
          border: Border.fromBorderSide(
            BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            user.name[0].toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
