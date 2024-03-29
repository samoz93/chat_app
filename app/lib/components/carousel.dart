import 'package:app/helpers/carousel_item.dart';
import 'package:app/pages/room_chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Carousel extends StatefulWidget {
  final List<CarouselItem> items;
  final String title;
  const Carousel({
    super.key,
    required this.items,
    required this.title,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  var page = 0;
  final _ctrl =
      PageController(viewportFraction: 0.4, initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onPageChanged);
  }

  _onPageChanged() {
    setState(() {
      page = _ctrl.page!.ceil();
    });
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onPageChanged);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Expanded(
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _ctrl,
            padEnds: false,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return GestureDetector(
                onTap: () => {
                  Navigator.of(context)
                      .pushNamed(RoomChatPage.route, arguments: item.id)
                },
                child: CachedNetworkImage(
                    imageUrl: item.image,
                    imageBuilder: (context, imgProvider) {
                      return Container(
                        padding: EdgeInsets.all(15.sp),
                        margin: EdgeInsets.only(right: 15.sp),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(25, 0, 0, 0),
                              Color.fromARGB(255, 0, 0, 0),
                            ],
                            stops: [
                              0.5,
                              1.0,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            tileMode: TileMode.decal,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          image: DecorationImage(
                            image: imgProvider,
                            fit: BoxFit.cover,
                            opacity: .6,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(item.title),
                        ),
                      );
                    }),
              );
            },
            itemCount: widget.items.length,
          ),
        ),
        SizedBox(height: 20.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.map((e) {
            final isSelected = widget.items.indexOf(e) == page;
            return GestureDetector(
              onTap: () => _ctrl.animateToPage(
                widget.items.indexOf(e),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
              child: Container(
                width: 10.sp,
                height: 10.sp,
                margin: EdgeInsets.only(right: 15.sp),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(100.sp),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
