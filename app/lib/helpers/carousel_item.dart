class CarouselItem {
  final String title;
  final String? subtitle;
  final String image;
  final bool isLiked;
  final String id;

  CarouselItem({
    required this.title,
    this.subtitle,
    required this.image,
    required this.isLiked,
    required this.id,
  });
}
