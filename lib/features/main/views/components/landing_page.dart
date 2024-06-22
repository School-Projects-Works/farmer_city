// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LandingPage extends ConsumerWidget {
  LandingPage({super.key});

  List<Map<String, String>> data = [
    {
      'image': Assets.slideSlide2,
      'title': 'Welcome to Farmer City',
      'description':
          'This is a platform for farmers to connect and share ideas, knowledge and sell their products'
    },
    {
      'image': Assets.slideSlide3,
      'title': 'A. I Assistant for Farmers',
      'description':
          'Use our A. I assistant to help you with your farming activities and get the best results. From plant disease detection to weather forecast, we got you covered.'
    },
    {
      'image': Assets.slideSlidw1,
      'title': 'Get the best products from our store',
      'description':
          'We have the best fresh farm products for you to buy. Check them out now. Visit the farm by using our farm routing feature.'
    }
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles( context);
    return CarouselSlider(
      options: CarouselOptions(
          height: breakPoint.screenHeight * 0.6,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal),
      items: data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: breakPoint.screenWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(i['image']!), fit: BoxFit.cover),
                  color: Colors.amber),
              child: Container(
                  width: breakPoint.screenWidth,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: breakPoint.screenHeight * 0.85,
                  color: Colors.black.withOpacity(0.8),
                  child: SizedBox(
                    width: breakPoint.isMobile
                        ? breakPoint.screenWidth * 0.8
                        : breakPoint.screenWidth * 0.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          i['title']!,
                          style: styles.body(
                              color: Colors.white,
                              mobile: 45,
                              desktop: 60,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          i['description']!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
