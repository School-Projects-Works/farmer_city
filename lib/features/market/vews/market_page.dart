import 'package:carousel_slider/carousel_slider.dart';
import 'package:firmer_city/core/widget/footer_page.dart';
import 'package:firmer_city/features/market/vews/feature_products.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildCarousel(),
              const SizedBox(
                height: 20,
              ),
              const FeaturedProducts(quantity: 0,),
              const SizedBox(
                height: 20,
              ),
              const FooterPage()
            ],
          ),
        ));
  }

  Widget buildCarousel() {
    var breakPoint = ResponsiveBreakpoints.of(context);

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
      items: [
        Assets.slideSlideOne,
        Assets.slideSlideTwo,
        Assets.slideSlideThree
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: breakPoint.screenWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
                  color: Colors.amber),
            );
          },
        );
      }).toList(),
    );
  }
}
