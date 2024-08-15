import 'package:cached_network_image/cached_network_image.dart';
import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/cart/data/cart_model.dart';
import 'package:firmer_city/features/cart/provider/cart_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/features/market/provider/market_provider.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FeaturedProducts extends ConsumerStatefulWidget {
  const FeaturedProducts({super.key, this.quantity = 8});
  final int quantity;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeaturedProductsState();
}

class _FeaturedProductsState extends ConsumerState<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    var productsStream = ref.watch(productStreamProvider);
    var _cartProvider = ref.watch(cartProvider);
    var itmes =
        _cartProvider.items.toList().map((e) => CartItem.fromMap(e)).toList();
    var cartNotifier = ref.read(cartProvider.notifier);
    var user = ref.watch(userProvider);
    return Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(horizontal: breakPoint.isMobile ? 10 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!ref.watch(isSearchingProvider) ||
                breakPoint.largerOrEqualTo(DESKTOP))
              Row(
                children: [
                  Text(
                    'Featured Products',
                    style: styles.body(
                        color: primaryColor,
                        mobile: 20,
                        desktop: 28,
                        tablet: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (breakPoint.smallerThan(DESKTOP))
                    IconButton(
                      onPressed: () {
                        ref.read(isSearchingProvider.notifier).state = true;
                      },
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
                          ref
                              .read(productProvider.notifier)
                              .filterProducts(value);
                        },
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            if (ref.watch(isSearchingProvider) &&
                breakPoint.smallerThan(DESKTOP))
              Row(
                children: [
                  Expanded(
                    child: CustomTextFields(
                      hintText: 'Search',
                      suffixIcon: const Icon(Icons.search),
                      onChanged: (value) {
                        ref
                            .read(productProvider.notifier)
                            .filterProducts(value);
                      },
                    ),
                  ),
                  //close search
                  IconButton(
                    onPressed: () {
                      ref.read(isSearchingProvider.notifier).state = false;
                    },
                    icon: const Icon(Icons.close),
                    iconSize: 30,
                    color: primaryColor,
                  ),
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
                  crossAxisCount: breakPoint.screenWidth < 600
                      ? 1
                      : breakPoint.screenWidth >= 600 && breakPoint.isMobile
                          ? 2
                          : breakPoint.isTablet
                              ? 3
                              : 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length > 8
                    ? widget.quantity != 0
                        ? products.sublist(0, widget.quantity).length
                        : products.length
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
                                  style: styles.body(
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
                                  style: styles.body(
                                      color: Colors.black54,
                                      mobile: 12,
                                      desktop: 12,
                                      tablet: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text: 'by ',
                                          style: styles.body(
                                              color: Colors.black54,
                                              mobile: 12,
                                              desktop: 12,
                                              tablet: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: product.productOwnerName,
                                          style: styles.body(
                                              color: Colors.black54,
                                              mobile: 12,
                                              desktop: 12,
                                              tablet: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ])),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          var address = AddressModel.fromMap(product.address);
                                          if(address.lat!=0&&address.long!=0){
                                            MapsLauncher.launchCoordinates(
                                                address.lat, address.long);
                                          }
                                        },
                                        child: const Text('View on Map'))
                                  ],
                                ),
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
                                          style: styles.body(
                                              color: primaryColor,
                                              mobile: 19,
                                              desktop: 22,
                                              tablet: 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: '/${product.productMeasurement}',
                                        style: styles.body(
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
                                          style: styles.body(
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
                                          style: styles.body(
                                              color: Colors.white,
                                              mobile: 12,
                                              desktop: 14,
                                              tablet: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                  ],
                                ),
                                //add to cart
                                const SizedBox(
                                  height: 10,
                                ),
                                if (itmes.any((element) =>
                                        element.product['id'] == product.id) ==
                                    false)
                                  CustomButton(
                                      text: 'Add to cart',
                                      color: primaryColor,
                                      onPressed: () {
                                        if (user.id != null &&
                                            user.id == product.productOwnerId) {
                                          CustomDialog.showToast(
                                              message:
                                                  'You can not add your own product to cart');
                                          return;
                                        }

                                        cartNotifier.addToCart(product);
                                      })
                                else
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                          text: '',
                                          icon: Icons.remove,
                                          color: Colors.red,
                                          radius: 5,
                                          onPressed: () {
                                            cartNotifier
                                                .removeFromCart(product);
                                          },
                                        ),
                                        Text(
                                          '${itmes.where((element) => element.product['id'] == product.id).firstOrNull?.quantity ?? 0}',
                                          style: styles.body(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CustomButton(
                                          text: '',
                                          icon: Icons.add,
                                          radius: 5,
                                          onPressed: () {
                                            cartNotifier.addToCart(product);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
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
