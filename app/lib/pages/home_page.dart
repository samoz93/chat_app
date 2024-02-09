import 'package:app/components/carousel.dart';
import 'package:app/components/custom_input.dart';
import 'package:app/helpers/carousel_item.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/stores/rooms_store.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final items = [
  CarouselItem(
      title: "SomeOther",
      id: "room1",
      image:
          "https://cdn.pixabay.com/photo/2016/12/27/06/38/albert-einstein-1933340_1280.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      id: "room2",
      image:
          "https://cdn.pixabay.com/photo/2016/12/27/06/38/albert-einstein-1933340_1280.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      id: "room1",
      image:
          "https://cdn.pixabay.com/photo/2016/12/27/06/38/albert-einstein-1933340_1280.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      id: "room1",
      image:
          "https://cdn.pixabay.com/photo/2016/12/27/06/38/albert-einstein-1933340_1280.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      id: "room1",
      image:
          "https://cdn.pixabay.com/photo/2016/12/27/06/38/albert-einstein-1933340_1280.jpg",
      isLiked: true),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const route = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = it.get<AuthStore>();
  final _io = it.get<SocketService>();
  final _rooms = it.get<RoomsStore>();

  Widget get _spacer => SizedBox(height: 15.sp);
  @override
  void initState() {
    // TODO: implement initState
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
              SizedBox(
                child: Carousel(
                  items: items,
                  title: "Favourite",
                ),
              ),
              Observer(
                builder: (context) {
                  return Column(
                    children: _rooms.rooms.entries
                        .map((e) => Column(
                              children: [
                                Text(e.key),
                                ...e.value.map((e) => Text(e.name))
                              ],
                            ))
                        .toList(),
                  );
                },
              )
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
            onChanged: (v) {},
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
              _store.signout();
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
