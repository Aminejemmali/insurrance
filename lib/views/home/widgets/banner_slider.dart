import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';

class HomeBannerSliderWidget extends StatefulWidget {
  HomeBannerSliderWidget({Key? key}) : super(key: key);

  @override
  State<HomeBannerSliderWidget> createState() => _HomeBannerSliderWidgetState();
}

class _HomeBannerSliderWidgetState extends State<HomeBannerSliderWidget> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2 / 0.718,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          bottom: 5,
          right: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                    width: _current == entry.key ? 30.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: _current == entry.key
                          ? BorderRadius.circular(4)
                          : null,
                      shape: _current == entry.key
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                      color: _current == entry.key
                          ? AppColors.primaryColor
                          : AppColors.white,
                    )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = [
  const SliderImageStyle(
    img: 'assets/images/banner1.png',
  ),
  const SliderImageStyle(
    img: 'assets/images/banner2.png',
  ),
  const SliderImageStyle(
    img: 'assets/images/banner3.png',
  ),
];

class SliderImageStyle extends StatelessWidget {
  final String img;

  const SliderImageStyle({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Image.asset(img, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
