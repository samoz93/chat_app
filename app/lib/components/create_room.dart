import 'package:app/components/custom_input.dart';
import 'package:app/components/selectable_avatar.dart';
import 'package:app/models/room_dto.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/friends_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateRoomDialog extends StatelessWidget {
  CreateRoomDialog({super.key});

  final _formKey = GlobalKey<FormState>();
  final _friendsService = it.get<FriendsManager>();

  final Map _formData = {"id": ""};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                onChanged: (v) {
                  _formData['name'] = v;
                },
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                label: "Name",
              ),
              SizedBox(height: 15.sp),
              CustomInput(
                onChanged: (v) {
                  _formData['description'] = v;
                },
                label: "Description",
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
                isExpanded: true,
              ),
              SizedBox(height: 20.sp),
              Observer(builder: (context) {
                final friends = _friendsService.friends;
                if (friends.isEmpty) {
                  return const SizedBox();
                }
                return Container(
                  height: 30.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        blurRadius: 1.sp,
                        blurStyle: BlurStyle.inner,
                        offset: Offset(0.sp, 4.sp),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: SizedBox(
                    width: 65.sp,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 65.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: friends
                              .map(
                                (e) => SelectableAvatar(
                                  user: e,
                                  onSelect: (v) {
                                    if (v) {
                                      _formData['users'] =
                                          _formData['users'] ?? [];
                                      _formData['users'].add(e.id);
                                    } else {
                                      _formData['users'].remove(e.id);
                                    }
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 15.sp),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    Navigator.of(context).pop(RoomDto.fromJson(_formData));
                  }
                },
                child: const Text("Create Room"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
