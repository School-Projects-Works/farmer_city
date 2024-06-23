import 'dart:convert';
import 'package:flutter/foundation.dart';

class OrderModel {
  String id;
  double totalPrice;
  List<Map<String, dynamic>> items;
  String status;
  String buyerId;
  String buyerName;
  String buyerPhone;
  String buyerAddress;
  List<String> farmerId;
  Map<String, dynamic> paymentDetails;
  Map<String,dynamic> deliveryDetails;
  int createdAt;
  OrderModel({
    required this.id,
    required this.totalPrice,
    this.items = const [],
    required this.status,
    required this.buyerId,
    required this.buyerName,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.farmerId,
    required this.paymentDetails,
    required this.deliveryDetails,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? id,
    double? totalPrice,
    List<Map<String, dynamic>>? items,
    String? status,
    String? buyerId,
    String? buyerName,
    String? buyerPhone,
    String? buyerAddress,
    List<String>? farmerId,
    Map<String, dynamic>? paymentDetails,
    Map<String,dynamic>? deliveryDetails,
    int? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      totalPrice: totalPrice ?? this.totalPrice,
      items: items ?? this.items,
      status: status ?? this.status,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      buyerPhone: buyerPhone ?? this.buyerPhone,
      buyerAddress: buyerAddress ?? this.buyerAddress,
      farmerId: farmerId ?? this.farmerId,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      deliveryDetails: deliveryDetails ?? this.deliveryDetails,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalPrice': totalPrice,
      'items': items,
      'status': status,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'buyerAddress': buyerAddress,
      'farmerId': farmerId,
      'paymentDetails': paymentDetails,
      'deliveryDetails': deliveryDetails,
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      items: List<Map<String, dynamic>>.from(map['items']?.map((x) => Map<String, dynamic>.from(x))),
      status: map['status'] ?? '',
      buyerId: map['buyerId'] ?? '',
      buyerName: map['buyerName'] ?? '',
      buyerPhone: map['buyerPhone'] ?? '',
      buyerAddress: map['buyerAddress'] ?? '',
      farmerId: List<String>.from(map['farmerId']),
      paymentDetails: Map<String, dynamic>.from(map['paymentDetails']),
      deliveryDetails: Map<String,dynamic>.from(map['deliveryDetails']),
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, totalPrice: $totalPrice, items: $items, status: $status, buyerId: $buyerId, buyerName: $buyerName, buyerPhone: $buyerPhone, buyerAddress: $buyerAddress, farmerId: $farmerId, paymentDetails: $paymentDetails, deliveryDetails: $deliveryDetails, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderModel &&
      other.id == id &&
      other.totalPrice == totalPrice &&
      listEquals(other.items, items) &&
      other.status == status &&
      other.buyerId == buyerId &&
      other.buyerName == buyerName &&
      other.buyerPhone == buyerPhone &&
      other.buyerAddress == buyerAddress &&
      listEquals(other.farmerId, farmerId) &&
      mapEquals(other.paymentDetails, paymentDetails) &&
      mapEquals(other.deliveryDetails, deliveryDetails) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      totalPrice.hashCode ^
      items.hashCode ^
      status.hashCode ^
      buyerId.hashCode ^
      buyerName.hashCode ^
      buyerPhone.hashCode ^
      buyerAddress.hashCode ^
      farmerId.hashCode ^
      paymentDetails.hashCode ^
      deliveryDetails.hashCode ^
      createdAt.hashCode;
  }
}
