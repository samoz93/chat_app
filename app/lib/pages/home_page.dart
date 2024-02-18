import 'package:app/components/carousel.dart';
import 'package:app/components/create_room.dart';
import 'package:app/components/custom_input.dart';
import 'package:app/components/user_list_tile.dart';
import 'package:app/helpers/carousel_item.dart';
import 'package:app/models/room_dto.dart';
import 'package:app/pages/auth_page.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/stores/friends_manager.dart';
import 'package:app/stores/rooms_manager.dart';
import 'package:app/utils/extensions.dart';
import 'package:app/utils/prettyprint.dart';
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
  final _io = it.get<SocketService>();
  final _roomManager = it.get<RoomsManager>();
  final _friendsManager = it.get<FriendsManager>();

  Widget get _spacer => SliverToBoxAdapter(child: _spacerWidget);

  @override
  void initState() {
    super.initState();
    _io.init();
  }

  Widget loading = const SliverToBoxAdapter(
      child: Center(
    child: CircularProgressIndicator(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                floating: false,
                pinned: true,
                delegate: HeaderPersistentDelegate(),
              ),
              _spacer,
              Observer(builder: (context) {
                if (_roomManager.loading) {
                  return loading;
                }
                if (_roomManager.rooms.isEmpty) {
                  return const SliverFillRemaining();
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

                return SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentRooms(items),
                );
              }),
              _spacer,
              Observer(builder: (ctx) {
                return SliverToBoxAdapter(
                    child: Text(
                  "Friends",
                  style: Theme.of(context).textTheme.headlineMedium,
                ));
              }),
              Observer(
                builder: (context) {
                  if (_friendsManager.loading) {
                    return loading;
                  }
                  if (_friendsManager.friends.isEmpty) {
                    return const SliverToBoxAdapter(
                        child: Center(
                      child: Text("No friends found"),
                    ));
                  }
                  final friends = _friendsManager.friends.toList();
                  return SliverList.builder(
                    itemBuilder: (ctx, idx) {
                      final friend = friends.elementAt(idx);
                      return UserListTile(
                        user: friend,
                        unreadCount: 1,
                      );
                    },
                    itemCount: friends.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final Widget _spacerWidget = SizedBox(height: 15.sp);

class HeaderPersistentDelegate extends SliverPersistentHeaderDelegate {
  final AuthStore _store = it.get<AuthStore>();
  final RoomsManager _roomManager = it.get<RoomsManager>();
  final FriendsManager _friendsManager = it.get<FriendsManager>();
  final max = 50.sp;

  Widget getSearchBar(BuildContext context, double perc) {
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
            onPressed: () async {
              final data = await showDialog<RoomDto>(
                context: context,
                builder: (ctx) => CreateRoomDialog(),
              );
              if (data == null) return;
              _roomManager.createRoom(data);
            },
            child: Icon(
              Icons.add,
              size: 20.sp * (1 - perc),
            ),
          ),
        ),
      ],
    );
  }

  Widget getHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            child: FlutterLogo(),
          ),
          SizedBox(width: 15.sp), // const Spacer(
          Text(
            (_store.me?.name ?? "").capitalize(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
          TextButton(
            onPressed: () {
              _store.signout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AuthPage.route,
                (route) => false,
              );
            },
            child: const Text(
              "Logout",
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final perc = shrinkOffset / maxExtent;
    final reverse = 1 - (perc * 2);
    prettyPrint("shrinkOffset", perc);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: getHeader(context)),
        reverse < 0
            ? const SizedBox()
            : Opacity(
                opacity: reverse,
                child: SizedBox(
                  height: 35.sp * reverse,
                  child: getSearchBar(context, perc),
                ),
              ),
      ],
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => 35.sp;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class PersistentRooms extends SliverPersistentHeaderDelegate {
  final List<CarouselItem> items;

  PersistentRooms(this.items);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Carousel(
        items: items,
        title: "Rooms",
      ),
    );
  }

  @override
  double get maxExtent => 65.sp;

  @override
  double get minExtent => 50.sp;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
