import 'dart:convert';
import 'package:flutter/foundation.dart';

class CartModel {
  String id;
  double totalPrice;
  List<Map<String, dynamic>> items;
  int createdAt;
  CartModel({
    required this.id,
    this.totalPrice = 0,
    this.items = const [],
    required this.createdAt,
  });

  CartModel copyWith({
    String? id,
    double? totalPrice,
    List<Map<String, dynamic>>? items,
    int? createdAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      totalPrice: totalPrice ?? this.totalPrice,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalPrice': totalPrice,
      'items': items,
      'createdAt': createdAt,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    var id = map['id'] ?? '';
    var items = map['items'] as List<dynamic>;
    var totalPrice = map['totalPrice'];
    var createdAt = map['createdAt'];
    List<CartItem> cartItems = [];
    for (var item in items) {
      var cart = CartItem(
          id: item['id'],
          product: Map<String,dynamic>.from(item['product']),
          quantity: item['quantity']);
      cartItems.add(cart);
    }

    return CartModel(
      id: id,
      totalPrice: totalPrice,
      items: cartItems.map((e) => e.toMap()).toList(),
      createdAt: createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartModel(id: $id, totalPrice: $totalPrice, items: $items, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.id == id &&
        other.totalPrice == totalPrice &&
        listEquals(other.items, items) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        totalPrice.hashCode ^
        items.hashCode ^
        createdAt.hashCode;
  }
}

class CartItem {
  String id;
  Map<String, dynamic> product;
  int quantity;
  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  //copywith
  CartItem copyWith({
    String? id,
    Map<String, dynamic>? product,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      product: Map<String, dynamic>.from(map['product']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'CartItem(id: $id, product: $product, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CartItem &&
      other.id == id &&
      mapEquals(other.product, product) &&
      other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode ^ quantity.hashCode;
}
