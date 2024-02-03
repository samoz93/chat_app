import 'package:app/components/carousel.dart';
import 'package:app/components/custom_input.dart';
import 'package:app/helpers/carousel_item.dart';
import 'package:app/services/locator.dart';
import 'package:app/services/socket.io.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/utils/extensions.dart';
import 'package:app/utils/prettyprint.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final items = [
  CarouselItem(
      title: "Mia Khalifa",
      image:
          "https://phantom-marca.unidadeditorial.es/316416e2aacead1e406ca171a5ab142e/resize/1200/f/jpg/assets/multimedia/imagenes/2023/10/10/16969425644523.jpg",
      isLiked: true),
  CarouselItem(
      title: "Samoz Samoz",
      image:
          "https://www.pinkvilla.com/pics/480x480/871625916_mia-khalifa_202310.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      image:
          "https://phantom-marca.unidadeditorial.es/316416e2aacead1e406ca171a5ab142e/resize/1200/f/jpg/assets/multimedia/imagenes/2023/10/10/16969425644523.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      image:
          "https://phantom-marca.unidadeditorial.es/316416e2aacead1e406ca171a5ab142e/resize/1200/f/jpg/assets/multimedia/imagenes/2023/10/10/16969425644523.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      image:
          "https://phantom-marca.unidadeditorial.es/316416e2aacead1e406ca171a5ab142e/resize/1200/f/jpg/assets/multimedia/imagenes/2023/10/10/16969425644523.jpg",
      isLiked: true),
  CarouselItem(
      title: "Hi",
      image:
          "https://phantom-marca.unidadeditorial.es/316416e2aacead1e406ca171a5ab142e/resize/1200/f/jpg/assets/multimedia/imagenes/2023/10/10/16969425644523.jpg",
      isLiked: true),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = it.get<AuthStore>();
  final _io = it.get<SocketService>();

  Widget get _spacer => SizedBox(height: 15.sp);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _io.init();
    prettyPrint('init');
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
              _io.sendMessage("event", v);
            },
            onSuffixClicked: () {
              _io.destroy();
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
              _io.connect();
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
