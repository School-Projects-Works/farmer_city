import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/core/widget/custom_drop_down.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/core/widget/footer_page.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/cart/data/cart_model.dart';
import 'package:firmer_city/features/cart/provider/order_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../provider/cart_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    var cart = ref.watch(cartProvider);
    return Container(
      width: breakPoint.screenWidth,
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 15,
                      runSpacing: 50,
                      alignment: WrapAlignment.center,
                      children: [buildCartList(cart), buildTotalSide(cart)],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const FooterPage()
        ],
      ),
    );
  }

  Widget buildCartList(CartModel cart) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: breakPoint.largerThan(MOBILE)
          ? breakPoint.screenWidth * .55
          : breakPoint.screenWidth,
      child: Column(
        children: [
          Text(
            'Items in Cart'.toUpperCase(),
            style: styles.body(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                desktop: 30,
                tablet: 25,
                mobile: 18),
          ),
          const Divider(
            color: primaryColor,
            height: 25,
            thickness: 4,
          ),
          if (cart.items.isEmpty)
            Center(
              child: Text(
                'No Item available in Cart',
                style: styles.body(desktop: 22, mobile: 17, tablet: 18),
              ),
            ),
          if (cart.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                  width: 200,
                  child: CustomButton(
                    text: 'Visit Market',
                    color: primaryColor,
                    radius: 10,
                    onPressed: () {
                      ref.read(routerProvider.notifier).state =
                          RouterInfo.marketRoute.name;
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.marketRoute);
                    },
                  )),
            )
          else
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = cart.items[index];
                  var cartItem = CartItem.fromMap(item);
                  var product = ProductModel.fromMap(cartItem.product);
                  return InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        //diaplay product images
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(product.productImages[0]),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.productName,
                                  maxLines: 2,
                                  style: styles.body(
                                      fontWeight: FontWeight.bold,
                                      desktop: 20,
                                      tablet: 18,
                                      mobile: 15)),
                              const SizedBox(height: 10),
                              Text(
                                product.productDescription,
                                maxLines: 2,
                                style: styles.body(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                  'GH₵${double.parse(product.productPrice).toStringAsFixed(2)}',
                                  style: styles.body(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    desktop: 22,
                                    tablet: 18,
                                    mobile: 16,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        //price of products

                        Column(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .addToCart(product);
                                }),
                            Text(
                              '${cartItem.quantity}',
                              style: styles.body(),
                            ),
                            IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .removeFromCart(product);
                                  //check if the cart is empty and navigate to market
                                  if (ref.watch(cartProvider).items.isEmpty) {
                                    MyRouter(context: context, ref: ref)
                                        .navigateToRoute(
                                            RouterInfo.marketRoute);
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cart.items.length)
        ],
      ),
    );
  }

  Widget buildTotalSide(CartModel cart) {
    var user = ref.watch(userProvider);
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    return SizedBox(
      width: breakPoint.smallerThan(TABLET)
          ? breakPoint.screenWidth
          : breakPoint.screenWidth * .35,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SutTotal',
                style: styles.body(
                    fontWeight: FontWeight.bold,
                    desktop: 25,
                    tablet: 20,
                    mobile: 18)),
            const SizedBox(height: 10),
            Text('GH₵${cart.totalPrice.toStringAsFixed(2)}',
                style: styles.body(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    desktop: 25,
                    tablet: 20,
                    mobile: 18)),
            const SizedBox(height: 10),
            //payment
            const Divider(),
            Text('Select Payment Method',
                style: styles.body(
                    fontWeight: FontWeight.w500,
                    desktop: 18,
                    tablet: 17,
                    mobile: 15)),
            const SizedBox(height: 5),
            CustomDropDown(
              value: ref.watch(selectedPaymentProvider),
              items: [
                'Payment on Delivery',
                'Momo Payment',
                'Card Payment',
              ]
                  .map((item) => DropdownMenuItem(
                      value: item,
                      child: Row(
                        children: [
                          Icon(item.contains('Delivery')
                              ? MdiIcons.truckDelivery
                              : item.contains('Momo')
                                  ? MdiIcons.phone
                                  : MdiIcons.creditCard),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(item),
                        ],
                      )))
                  .toList(),
              onChanged: (value) {
                ref.read(selectedPaymentProvider.notifier).state =
                    value.toString();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            if (ref.watch(selectedPaymentProvider).contains('Momo'))
              buildMomoPayment(),
            if (ref.watch(selectedPaymentProvider).contains('Card'))
              buildCard(),
            const SizedBox(
              height: 15,
            ),
            if (!ref.watch(isPickUpProvider))
              Text('Delivery Address',
                  style: styles.body(
                      fontWeight: FontWeight.w500,
                      desktop: 18,
                      tablet: 17,
                      mobile: 15)),
            const SizedBox(height: 5),
            if (!ref.watch(isPickUpProvider)) buildAddressInput(),
            const SizedBox(
              height: 15,
            ),
            //check box for Pickup
            Row(
              children: [
                Checkbox(
                    value: ref.watch(isPickUpProvider),
                    onChanged: (value) {
                      ref.read(isPickUpProvider.notifier).state = value!;
                    }),
                Text('Pickup Order',
                    style: styles.body(
                        desktop: 18, tablet: 17, mobile: 15, fontWeight: null)),
              ],
            ),
            CustomButton(
              text: 'Checkout',
              onPressed: () {
                if (user.id == null) {
                  CustomDialog.showToast(message: 'Login to continue');
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterInfo.loginRoute);
                } else if (ref
                        .watch(selectedPaymentProvider)
                        .contains('Momo') &&
                    (ref.watch(momoProvider).network == null ||
                        ref.watch(momoProvider).phoneNumber == null)) {
                  CustomDialog.showToast(message: 'Select Momo Provider');
                } else if (ref
                        .watch(selectedPaymentProvider)
                        .contains('Card') &&
                    !cardFormKey.currentState!.validate()) {
                } else {
                  if (ref.watch(addressProvider).isEmpty &&
                      !ref.watch(isPickUpProvider)) {
                    CustomDialog.showToast(
                        message: 'Enter Delivery Address or Select Pickup');
                    return;
                  }
                  ref
                      .read(cartProvider.notifier)
                      .placeOrder(ref: ref, context: context);
                }
              },
              radius: 10,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMomoPayment() {
    var styles = Styles(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select  Provider',
          style: styles.body(desktop: 17, tablet: 16, mobile: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        //momo provider with radio group
        momoItem('MTN Mobile Money', 'MTN Mobile Money'),

        const SizedBox(
          height: 10,
        ),
        momoItem('Telecel Cash', 'Telecel Cash'),
        const SizedBox(
          height: 10,
        ),
        momoItem('AirtelTigo Cash', 'AirtelTigo Cash'),

        const SizedBox(
          height: 10,
        ),
        //phone number
        CustomTextFields(
          hintText: 'Enter Phone Number',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          isDigitOnly: true,
          onChanged: (value) {
            ref.read(momoProvider.notifier).setPhone(value);
          },
        )
      ],
    );
  }

  Widget momoItem(
    String title,
    String value,
  ) {
    var styles = Styles(context);
    var isSelected = ref.watch(momoProvider).network == value;
    return InkWell(
      onTap: () {
        ref.read(momoProvider.notifier).setProvider(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 10,
                offset: const Offset(0, 2),
              )
            ]),
        child: Row(
          children: [
            Image.asset(
                value.contains('MTN')
                    ? Assets.imagesMtn
                    : value.contains('Telecel')
                        ? Assets.imagesTelecel
                        : Assets.imagesAt,
                width: 50,
                height: 30),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: styles.body(desktop: 17, tablet: 16, mobile: 15),
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  Widget buildCard() {
    var notifier = ref.read(cardDetailsProvider.notifier);
    return Form(
      key: cardFormKey,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomTextFields(
            label: 'Card Number',
            validator: (card) {
              if (card == null || card.length < 12) {
                return 'Enter a valid Card number';
              }
              return null;
            },
            onSaved: (card) {
              notifier.setCardNumber(card);
            },
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFields(
                  label: 'Expired Dat',
                  hintText: 'DD/MM/YY',
                  max: 8,
                  validator: (date) {
                    if (date == null || date.isEmpty) {
                      return 'Expired date Require';
                    } else if (DateTime.tryParse(date) == null) {
                      return 'Enter a valid date';
                    }
                    return null;
                  },
                  onSaved: (date) {
                    notifier.setExpiryDate(date);
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: CustomTextFields(
                  label: 'CVV',
                  hintText: 'CVV',
                  max: 3,
                  isDigitOnly: true,
                  validator: (cvv) {
                    if (cvv == null || cvv.length < 3) {
                      return 'Enter a valid CVV';
                    }
                    return null;
                  },
                  onSaved: (cvv) {
                    notifier.setCvvCode(cvv);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          CustomTextFields(
            label: 'Card Holder Name',
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'Card Holder Name Require';
              }
              return null;
            },
            onSaved: (name) {
              notifier.setCardHolderName(name);
            },
          ),
        ],
      ),
    );
  }

  Widget buildAddressInput() {
    return CustomTextFields(
      hintText: 'Enter Delivery Address',
      maxLines: 3,
      keyboardType: TextInputType.streetAddress,
      onChanged: (value) {
        ref.read(addressProvider.notifier).state = value;
      },
    );
  }
}
