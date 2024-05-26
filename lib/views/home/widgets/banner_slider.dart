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
      alignment: Alignment.bottomCenter, // Updated alignment for better visual structure
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5), // Ensure consistent auto-play timing
              aspectRatio: 2.5, // Adjusted aspect ratio for a better fit
              enlargeCenterPage: true,
              enlargeFactor: 0.9, // Enhanced visibility of the center image
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          bottom: 10, // Adjusted for better visibility
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 20.0 : 8.0, // Adjusted for better UI indication
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_current == entry.key
                        ? AppColors.primaryColor
                        : AppColors.white.withOpacity(0.5)), // Modified for better contrast
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = [
  SliderImageStyle(
    img: 'assets/images/banner1.png',
  ),
  SliderImageStyle(
    img: 'assets/images/banner2.png',
  ),
  SliderImageStyle(
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
