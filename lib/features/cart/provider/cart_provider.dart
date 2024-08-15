import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/assistant/services/gpt_services.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/cart/data/cart_model.dart';
import 'package:firmer_city/features/cart/provider/order_provider.dart';
import 'package:firmer_city/features/dashboard/data/oder_model.dart';
import 'package:firmer_city/features/dashboard/services/order_services.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

final cartProvider = StateNotifierProvider<CartProvider, CartModel>(
  (ref) {
    CartModel cart = CartModel(id: '', totalPrice: 0, items: [], createdAt: 0);
    var box = Hive.box('cart');
    if (!box.isOpen) {
      Hive.openBox('cart');
    }
    try {
      var json = box.get('cart');
      if (json != null && json['id'].toString().isNotEmpty) {
        Map<String, dynamic> map = {
          'id': json['id'],
          'totalPrice': json['totalPrice'],
          'items': json['items'],
          'createdAt': json['createdAt']
        };
        cart = CartModel.fromMap(map);
        //.//print('cart: $cart');
      }
      return CartProvider(cart);
    } catch (e) {
      return CartProvider(cart);
    }
  },
);

class CartProvider extends StateNotifier<CartModel> {
  CartProvider(this.cart) : super(cart) {
    getCart();
  }
  final CartModel cart;

  void getCart() async {
    var box = Hive.box('cart');
    if (!box.isOpen) {
      await Hive.openBox('cart');
    }

    var json = box.get('cart');
    if (json != null) {
      Map<String, dynamic> map = {
        'id': json['id'],
        'totalPrice': json['totalPrice'],
        'items': json['items'],
        'createdAt': 0
      };
      var cart = CartModel.fromMap(map);
      state = cart;
    }
  }

  void addToCart(ProductModel item) async {
    var items = state.items.toList().map((e) => CartItem.fromMap(e)).toList();
    //if product already in cart, increase quantity
    var totalPrice = state.totalPrice;
    var existenItems =
        items.where((element) => element.product['id'] == item.id).firstOrNull;
    if (existenItems != null) {
      existenItems.quantity = existenItems.quantity + 1;
      // add to items
      //replace the item in the list
      items =
          items.map((e) => e.id == existenItems.id ? existenItems : e).toList();
      totalPrice = totalPrice + double.parse(item.productPrice);
      state = state.copyWith(
          items: items.map((e) => e.toMap()).toList(), totalPrice: totalPrice);
    } else {
      items.add(CartItem(id: item.id, product: item.toMap(), quantity: 1));
      totalPrice = totalPrice + double.parse(item.productPrice);
      state = state.copyWith(
          items: items.map((e) => e.toMap()).toList(), totalPrice: totalPrice);
    }
    //save state to hive
    await Hive.box('cart').put('cart', state.toMap());
  }

  void removeFromCart(ProductModel item) async {
    var items = state.items.toList().map((e) => CartItem.fromMap(e)).toList();
    var totalPrice = state.totalPrice;
    //if product already in cart, increase quantity
    var existenItems =
        items.where((element) => element.product['id'] == item.id).firstOrNull;
    if (existenItems != null) {
      if (existenItems.quantity > 1) {
        existenItems.quantity = existenItems.quantity - 1;
        // add to items
        //replace the item in the list
        items = items
            .map((e) => e.id == existenItems.id ? existenItems : e)
            .toList();
        totalPrice = totalPrice - double.parse(item.productPrice);
        state = state.copyWith(
            items: items.map((e) => e.toMap()).toList(),
            totalPrice: totalPrice);
      } else {
        items.removeWhere((element) => element.product['id'] == item.id);
        totalPrice = totalPrice - double.parse(item.productPrice);
        state = state.copyWith(
            items: items.map((e) => e.toMap()).toList(),
            totalPrice: totalPrice);
      }
      await Hive.box('cart').put('cart', state.toJson());
    }
  }

  void clearCart() {
    state = state.copyWith(items: [], totalPrice: 0);
  }

  void placeOrder(
      {required WidgetRef ref, required BuildContext context}) async {
    CustomDialog.showLoading(
      message: 'Placing order...',
    );
    var paymentMethod = ref.read(selectedPaymentProvider);
    var user = ref.read(userProvider);
    Map<String, dynamic> paymentDetails = {};
    if (paymentMethod.contains('Momo')) {
      var momo = ref.read(momoProvider);
      paymentDetails = {
        'method': 'Momo',
        'phoneNumber': momo.phoneNumber,
        'network': momo.network
      };
    } else if (paymentMethod.contains('Card')) {
      var card = ref.read(cardDetailsProvider);
      paymentDetails = {
        'method': 'Card',
        'cardNumber': card.cardNumber,
        'expiryDate': card.expiryDate,
        'cardHolderName': card.cardHolderName,
        'cvvCode': card.cvvCode
      };
    } else {
      paymentDetails = {
        'method': 'Cash',
      };
    }
    var isPickup = ref.read(isPickUpProvider);
    var address = isPickup ? 'Customer Pick-up' : ref.read(addressProvider);
    var items =
        ref.read(cartProvider).items.map((e) => CartItem.fromMap(e)).toList();
    var products = items.map((e) => ProductModel.fromMap(e.product)).toList();
    //group items by farmer
    var groupedItems =
        groupBy(products, (ProductModel obj) => obj.productOwnerId);
    List<Map<String, dynamic>> productsAddress =
        products.map((product) => product.address).toList();
    List<AddressModel> add =
        productsAddress.map((map) => AddressModel.fromMap(map)).toList();
    var addGroup = groupBy(add, (AddressModel ad) => ad.phone);
    List<String> ids = [user.id!, ...groupedItems.keys].toList();
    var order = OrderModel(
        id: OrderServices.generateOrderId(),
        totalPrice: state.totalPrice,
        items: state.items,
        status: 'Pending',
        buyerId: user.id!,
        buyerName: user.name!,
        buyerPhone: user.phone!,
        buyerAddress: address,
        farmerId: ids,
        paymentDetails: paymentDetails,
        deliveryDetails: {
          'address': address,
        },
        createdAt: DateTime.now().millisecondsSinceEpoch);
    var res = await OrderServices.createOrder(order);
    if (res) {
      for (var phone in addGroup.keys) {
        if (phone.isNotEmpty) {
          await sendMessage(phone, 'You have a new oder, check it out');
        }
      }
      if (user.phone != null && user.phone!.isNotEmpty) {
        await sendMessage(
            user.phone!, 'Your Order has been successfully placed');
      }

      CustomDialog.dismiss();
      CustomDialog.showSuccess(
        message: 'Order placed successfully',
      );
      ref.read(cartProvider.notifier).clearCart();
      //clear payments
      ref.read(momoProvider.notifier).clear();
      ref.read(cardDetailsProvider.notifier).clear();
      MyRouter(context: context, ref: ref)
          .navigateToRoute(RouterInfo.homeRoute);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showError(
        message: 'Failed to place order',
      );
    }
  }
}

final addressProvider = StateProvider<String>((ref) => '');
