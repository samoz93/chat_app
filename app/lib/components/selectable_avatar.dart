import 'package:app/components/user_avatar.dart';
import 'package:app/models/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectableAvatar extends StatefulWidget {
  final User user;
  final Function(bool val)? onSelect;
  const SelectableAvatar({
    super.key,
    required this.user,
    this.onSelect,
  });

  @override
  State<SelectableAvatar> createState() => _SelectableAvatarState();
}

class _SelectableAvatarState extends State<SelectableAvatar> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: InkWell(
        onTap: () {
          if (widget.onSelect != null) widget.onSelect!(!_selected);
          setState(() {
            _selected = !_selected;
          });
        },
        child: Stack(
          children: [
            IgnorePointer(
              child: UsersAvatar(
                user: widget.user,
                disableClick: true,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: _selected ? icon : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget get icon {
    return SizedBox(
      height: 15.sp,
      width: 15.sp,
      child: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.primary,
          size: 12.sp,
          weight: 10.sp,
          fill: 2.sp,
          opticalSize: 10.sp,
        ),
      ),
    );
  }
}
