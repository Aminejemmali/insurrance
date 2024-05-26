import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class CustomVerticalSkeletonLoader extends StatelessWidget {
  final int totalCount, seconds;
  final double height, width;
  final Color highlightColor;
  const CustomVerticalSkeletonLoader({
    super.key,
    required this.totalCount,
    required this.height,
    required this.width,
    required this.seconds,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
          period: const Duration(seconds: 2),
          highlightColor: highlightColor,
          direction: SkeletonDirection.ltr,
          builder: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            // scrollDirection: Axis.vertical,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                child: Container(
                  width: 200.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey,
                  ),
                ),
              );
            }),
          )),
    );
  }
}

class CustomHorizontalSkeletonLoader extends StatelessWidget {
  final int totalCount, seconds;
  final double listHeight, containerHeight, containerWidth;
  final Color highlightColor;
  const CustomHorizontalSkeletonLoader({
    super.key,
    required this.totalCount,
    required this.listHeight,
    required this.seconds,
    required this.highlightColor,
    required this.containerHeight,
    required this.containerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
          period: const Duration(seconds: 2),
          highlightColor: highlightColor,
          direction: SkeletonDirection.ltr,
          builder: SizedBox(
            height: listHeight,
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                  child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          )),
    );
  }
}

class CustomGridViewSkeletonLoader extends StatelessWidget {
  final int totalCount, seconds;
  final double aspectRatio;
  final Color highlightColor;
  const CustomGridViewSkeletonLoader({
    super.key,
    required this.totalCount,
    required this.seconds,
    required this.highlightColor,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
          period: const Duration(seconds: 2),
          highlightColor: highlightColor,
          direction: SkeletonDirection.ltr,
          builder: SizedBox(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              crossAxisCount: 2,
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: aspectRatio,
              shrinkWrap: true,
              children: List.generate(totalCount, (index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          )),
    );
  }
}
