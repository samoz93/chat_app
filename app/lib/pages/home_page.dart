import 'package:app/components/carousel.dart';
import 'package:app/components/custom_input.dart';
import 'package:app/components/user_list_tile.dart';
import 'package:app/helpers/carousel_item.dart';
import 'package:app/repos/auth_repo.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/stores/friends_manager.dart';
import 'package:app/stores/rooms_manager.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const route = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = it.get<AuthStore>();
  final _repo = it.get<AuthRepo>();
  final _io = it.get<SocketService>();
  final _roomManager = it.get<RoomsManager>();
  final _friendsManager = it.get<FriendsManager>();

  Widget get _spacer => SizedBox(height: 15.sp);
  @override
  void initState() {
    super.initState();
    _io.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(context),
              _spacer,
              getSearchBar(context),
              _spacer,
              Observer(builder: (context) {
                if (_roomManager.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (_roomManager.rooms.isEmpty) {
                  return const SizedBox();
                }
                final items = _roomManager.rooms
                    .map((e) => CarouselItem(
                          title: e.name,
                          subtitle: e.description,
                          id: e.id,
                          image: "https://picsum.photos/200/300?random=${e.id}",
                          isLiked: true,
                        ))
                    .toList();

                return SizedBox(
                  child: Carousel(
                    items: items,
                    title: "Rooms",
                  ),
                );
              }),
              _spacer,
              Flexible(
                flex: 1,
                child: Observer(
                  builder: (context) {
                    if (_friendsManager.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (_friendsManager.friends.isEmpty) {
                      return const Center(
                        child: Text("No friends found"),
                      );
                    }
                    return ListView.builder(
                      itemCount: _friendsManager.friends.length,
                      itemBuilder: (ctx, idx) {
                        final friend = _friendsManager.friends.elementAt(idx);
                        return UserListTile(
                          user: friend,
                          unreadCount: 1,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSearchBar(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: CustomInput(
            label: "Search",
            onChanged: (v) {
              _roomManager.setSearch(v);
              _friendsManager.setSearch(v);
            },
            suffixIcon: Icons.search,
          ),
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.tertiary,
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(0, 31.sp),
                  ),
                ),
            onPressed: () {
              _repo.refreshToken();
            },
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Wrap getHeader(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 15.sp,
      children: [
        const CircleAvatar(
          radius: 20,
          child: FlutterLogo(),
        ),
        Text(
          (_store.me?.name ?? "").capitalize(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
