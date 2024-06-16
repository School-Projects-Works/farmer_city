import 'package:firmer_city/features/cart/data/cart_model.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final cartProvider = StateNotifierProvider<CartProvider, CartModel>(
  (ref) {
    CartModel cart = CartModel(id: '', totalPrice: 0, items: [], createdAt: 0);
    var box = Hive.box('cart');
    if (!box.isOpen) {
      Hive.openBox('cart');
    }

    var json = box.get('cart');
    if (json != null) {
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
    state = state.copyWith(items: []);
  }
}
