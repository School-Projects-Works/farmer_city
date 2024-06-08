import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/core/widget/footer_page.dart';
import 'package:firmer_city/features/market/provider/market_provider.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/styles.dart';
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {},
          //cart
          child: const Icon(Icons.shopping_cart),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildCarousel(),
              const SizedBox(
                height: 20,
              ),
              buildFeaturedProducts(),
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

  Widget buildFeaturedProducts() {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = CustomStyles(context: context);
    var productsStream = ref.watch(productStreamProvider);

    return Container(
        width: breakPoint.screenWidth,
        padding:
            EdgeInsets.symmetric(horizontal: breakPoint.isMobile ? 10 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Featured Products',
                  style: styles.textStyle(
                      color: primaryColor,
                      mobile: 30,
                      desktop: 36,
                      tablet: 34,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (breakPoint.smallerThan(DESKTOP))
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    iconSize: 30,
                    color: primaryColor,
                  )
                else
                  SizedBox(
                    width: breakPoint.screenWidth * 0.4,
                    child: CustomTextFields(
                      hintText: 'Search',
                      suffixIcon: const Icon(Icons.search),
                      onChanged: (value) {
                        //TODO: Implement search
                      },
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            productsStream.when(data: (data) {
              var products = ref.watch(productProvider).filteredProducts;
              if (products.isEmpty) {
                return SizedBox(
                  height: 400,
                  width: breakPoint.screenWidth,
                  child: const Center(
                    child: Text('No products found'),
                  ),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: breakPoint.isMobile
                      ? 2
                      : breakPoint.isTablet
                          ? 3
                          : 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length > 8
                    ? products.sublist(0, 8).length
                    : products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: product.productImages[0],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  padding: const EdgeInsets.all(5),
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                              ),
                              errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.all(100),
                                  child: Image.asset(Assets.imagesFarmerIcon)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: styles.textStyle(
                                      color: Colors.black,
                                      mobile: 16,
                                      desktop: 20,
                                      tablet: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  product.productDescription,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: styles.textStyle(
                                      color: Colors.black54,
                                      mobile: 12,
                                      desktop: 12,
                                      tablet: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'by ',
                                    style: styles.textStyle(
                                        color: Colors.black54,
                                        mobile: 12,
                                        desktop: 12,
                                        tablet: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: product.productOwnerName,
                                    style: styles.textStyle(
                                        color: Colors.black54,
                                        mobile: 12,
                                        desktop: 12,
                                        tablet: 12,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              '₵${double.parse(product.productPrice).toStringAsFixed(2)}',
                                          style: styles.textStyle(
                                              color: primaryColor,
                                              mobile: 19,
                                              desktop: 22,
                                              tablet: 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: '/${product.productMeasurement}',
                                        style: styles.textStyle(
                                            color: primaryColor,
                                            mobile: 12,
                                            desktop: 12,
                                            tablet: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ])),
                                    const Spacer(),
                                    //in stock
                                    if (product.productStock > 0)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          'In stock',
                                          style: styles.textStyle(
                                              color: Colors.white,
                                              mobile: 12,
                                              desktop: 14,
                                              tablet: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    else
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          'Out of stock',
                                          style: styles.textStyle(
                                              color: Colors.white,
                                              mobile: 12,
                                              desktop: 14,
                                              tablet: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }, error: (error, stack) {
              return SizedBox(
                height: 400,
                width: breakPoint.screenWidth,
                child: const Center(
                  child: Text('An error occurred'),
                ),
              );
            }, loading: () {
              return SizedBox(
                height: 400,
                width: breakPoint.screenWidth,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
          ],
        ));
  }
}
