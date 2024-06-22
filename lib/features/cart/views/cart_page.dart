import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/functions/navigation.dart';
import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_drop_down.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/core/widget/footer_page.dart';
import 'package:firmer_city/features/cart/data/cart_model.dart';
import 'package:firmer_city/features/cart/provider/order_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: breakPoint.screenWidth > 700
                ? Row(
                    children: [
                      Expanded(
                        child: buildCartList(cart),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      builTotalSide(cart)
                    ],
                  )
                : buildMobile(cart),
          )),
          const FooterPage()
        ],
      ),
    );
  }

  Widget buildCartList(CartModel cart) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles( context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    text: 'Vist Market',
                    color: primaryColor,
                    radius: 10,
                    onPressed: () {
                      ref.read(routerProvider.notifier).state =
                          RouterInfo.marketRoute.name;
                    MyRouter(contex: context,ref: ref).navigateToRoute(
                          RouterInfo.marketRoute);
                    },
                  )),
            )
          else
            Expanded(
              child: ListView.separated(
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
                                    image:
                                        NetworkImage(product.productImages[0]),
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
                                  }),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cart.items.length),
            )
        ],
      ),
    );
  }

  Widget builTotalSide(CartModel cart) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles( context);
    return SizedBox(
      width: breakPoint.smallerThan(TABLET)
          ? breakPoint.screenWidth
          : breakPoint.screenWidth * .3,
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

            CustomButton(
              text: 'Checkout',
              onPressed: () {},
              radius: 10,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMobile(CartModel cart) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    return const Column(
      children: [],
    );
  }

  Widget buildMomoPayment() {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles( context);
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
        momoItem('MTN Mobile Money', 'MTN Mobile Money',
            ref.watch(momoProvider) == 'MTN Mobile Money'),

        const SizedBox(
          height: 10,
        ),
        momoItem('Telecel Cash', 'Telecel Cash',
            ref.watch(momoProvider) == 'Telecel Cash'),
        const SizedBox(
          height: 10,
        ),
        momoItem('AirtelTigo Cash', 'AirtelTigo Cash',
            ref.watch(momoProvider) == 'AirtelTigo Cash'),

        const SizedBox(
          height: 10,
        ),
        //phone number
        CustomTextFields(
          hintText: 'Enter Phone Number',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          isDigitOnly: true,
          onChanged: (value) {},
        )
      ],
    );
  }

  Widget momoItem(String title, String value, bool isSelected) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    return InkWell(
      onTap: () {
        ref.read(momoProvider.notifier).state = value;
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildCard() {
    var provider = ref.watch(cardDetailsProvider);
    var notifier = ref.read(cardDetailsProvider.notifier);
    return Column(
      children: [
        CreditCardWidget(
          enableFloatingCard: useFloatingAnimation,
          glassmorphismConfig: _getGlassmorphismConfig(),
          cardNumber: provider.cardNumber ?? '', // Required
          expiryDate: provider.expiryDate ?? '', // Required
          cardHolderName: provider.cardHolderName ?? '', // Required
          cvvCode: provider.cvvCode ?? '',
          bankName: 'Axis Bank',
          frontCardBorder:
              useGlassMorphism ? null : Border.all(color: Colors.grey),
          backCardBorder:
              useGlassMorphism ? null : Border.all(color: Colors.grey),
          showBackView: isCvvFocused,
          obscureCardNumber: true,
          obscureCardCvv: true,
          isHolderNameVisible: true,
          cardBgColor: secondaryColor,
          backgroundImage: useBackgroundImage ? 'assets/card_bg.png' : null,
          isSwipeGestureEnabled: true,
          onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          customCardTypeIcons: <CustomCardTypeIcon>[
            CustomCardTypeIcon(
              cardType: CardType.mastercard,
              cardImage: Image.asset(
                'assets/mastercard.png',
                height: 48,
                width: 48,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CreditCardForm(
          formKey: formKey, // Required
          cardNumber: provider.cardNumber ?? '', // Required
          expiryDate: provider.expiryDate ?? '', // Required
          cardHolderName: provider.cardHolderName ?? '', // Required
          cvvCode: provider.cvvCode ?? '', // Required
          onCreditCardModelChange: onCreditCardModelChange,

          /// Required
          obscureCvv: true,
          obscureNumber: true,
          isHolderNameVisible: true,
          isCardNumberVisible: true,
          isExpiryDateVisible: true,
          enableCvv: true,
          cvvValidationMessage: 'Please input a valid CVV',
          dateValidationMessage: 'Please input a valid date',
          numberValidationMessage: 'Please input a valid number',

          autovalidateMode: AutovalidateMode.always,
          disableCardNumberAutoFillHints: false,
          inputConfiguration: const InputConfiguration(
            cardNumberDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Number',
              hintText: 'XXXX XXXX XXXX XXXX',
            ),
            expiryDateDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expired Date',
              hintText: 'XX/XX',
            ),
            cvvCodeDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            cardHolderDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Card Holder',
            ),
            cardNumberTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            cardHolderTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            expiryDateTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            cvvCodeTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }

    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient);
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    ref.read(cardDetailsProvider.notifier).setCardDetails(creditCardModel);
  }
}
