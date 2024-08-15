import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

import 'package:firmer_city/core/constant/constant_strings.dart';
import 'package:firmer_city/features/auth/data/user_model.dart';

class ProductModel {
  String id;
  String productName;
  String productDescription;
  String productType;
  String? productMeasurement;
  String productPrice;
  List<String> productImages;
  String productCategory;
  String productOwnerId;
  String productOwnerName;
  String productOwnerImage;
  String productLocation;
  bool canBeDelivered;
  int productStock;
  Map<String, dynamic> address;
  int createdAt;
  ProductModel({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.productType,
    this.productMeasurement,
    required this.productPrice,
    required this.productImages,
    required this.productCategory,
    required this.productOwnerId,
    required this.productOwnerName,
    required this.productOwnerImage,
     this.productLocation='',
     this.canBeDelivered=true,
    required this.productStock,
    this.address=const {},
    required this.createdAt,
  });
  

  ProductModel copyWith({
    String? id,
    String? productName,
    String? productDescription,
    String? productType,
    String? productMeasurement,
    String? productPrice,
    List<String>? productImages,
    String? productCategory,
    String? productOwnerId,
    String? productOwnerName,
    String? productOwnerImage,
    String? productLocation,
    bool? canBeDelivered,
    int? productStock,
    Map<String, dynamic>? address,
    int? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productType: productType ?? this.productType,
      productMeasurement: productMeasurement ?? this.productMeasurement,
      productPrice: productPrice ?? this.productPrice,
      productImages: productImages ?? this.productImages,
      productCategory: productCategory ?? this.productCategory,
      productOwnerId: productOwnerId ?? this.productOwnerId,
      productOwnerName: productOwnerName ?? this.productOwnerName,
      productOwnerImage: productOwnerImage ?? this.productOwnerImage,
      productLocation: productLocation ?? this.productLocation,
      canBeDelivered: canBeDelivered ?? this.canBeDelivered,
      productStock: productStock ?? this.productStock,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'productName': productName});
    result.addAll({'productDescription': productDescription});
    result.addAll({'productType': productType});
    if(productMeasurement != null){
      result.addAll({'productMeasurement': productMeasurement});
    }
    result.addAll({'productPrice': productPrice});
    result.addAll({'productImages': productImages});
    result.addAll({'productCategory': productCategory});
    result.addAll({'productOwnerId': productOwnerId});
    result.addAll({'productOwnerName': productOwnerName});
    result.addAll({'productOwnerImage': productOwnerImage});
    result.addAll({'productLocation': productLocation});
    result.addAll({'canBeDelivered': canBeDelivered});
    result.addAll({'productStock': productStock});
    if(address != null){
      result.addAll({'address': address});
    }
    result.addAll({'createdAt': createdAt});
  
    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      productName: map['productName'] ?? '',
      productDescription: map['productDescription'] ?? '',
      productType: map['productType'] ?? '',
      productMeasurement: map['productMeasurement'],
      productPrice: map['productPrice'] ?? '',
      productImages: List<String>.from(map['productImages']),
      productCategory: map['productCategory'] ?? '',
      productOwnerId: map['productOwnerId'] ?? '',
      productOwnerName: map['productOwnerName'] ?? '',
      productOwnerImage: map['productOwnerImage'] ?? '',
      productLocation: map['productLocation'] ?? '',
      canBeDelivered: map['canBeDelivered'] ?? false,
      productStock: map['productStock']?.toInt() ?? 0,
      address: Map<String, dynamic>.from(map['address']),
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, productName: $productName, productDescription: $productDescription, productType: $productType, productMeasurement: $productMeasurement, productPrice: $productPrice, productImages: $productImages, productCategory: $productCategory, productOwnerId: $productOwnerId, productOwnerName: $productOwnerName, productOwnerImage: $productOwnerImage, productLocation: $productLocation, canBeDelivered: $canBeDelivered, productStock: $productStock, address: $address, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.productName == productName &&
      other.productDescription == productDescription &&
      other.productType == productType &&
      other.productMeasurement == productMeasurement &&
      other.productPrice == productPrice &&
      listEquals(other.productImages, productImages) &&
      other.productCategory == productCategory &&
      other.productOwnerId == productOwnerId &&
      other.productOwnerName == productOwnerName &&
      other.productOwnerImage == productOwnerImage &&
      other.productLocation == productLocation &&
      other.canBeDelivered == canBeDelivered &&
      other.productStock == productStock &&
      mapEquals(other.address, address) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      productName.hashCode ^
      productDescription.hashCode ^
      productType.hashCode ^
      productMeasurement.hashCode ^
      productPrice.hashCode ^
      productImages.hashCode ^
      productCategory.hashCode ^
      productOwnerId.hashCode ^
      productOwnerName.hashCode ^
      productOwnerImage.hashCode ^
      productLocation.hashCode ^
      canBeDelivered.hashCode ^
      productStock.hashCode ^
      address.hashCode ^
      createdAt.hashCode;
  }
}

class AddressModel {
  String city;
  String region;
  String address;
  double lat;
  double long;
  String phone;
  AddressModel({
    required this.city,
    required this.region,
    required this.address,
    required this.lat,
    required this.long,
    required this.phone,
  });

  AddressModel copyWith({
    String? city,
    String? region,
    String? address,
    double? lat,
    double? long,
    String? phone,
  }) {
    return AddressModel(
      city: city ?? this.city,
      region: region ?? this.region,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'region': region,
      'address': address,
      'lat': lat,
      'long': long,
      'phone': phone,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      city: map['city'] ?? '',
      region: map['region'] ?? '',
      address: map['address'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(city: $city, region: $region, address: $address, lat: $lat, long: $long, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.city == city &&
        other.region == region &&
        other.address == address &&
        other.lat == lat &&
        other.long == long &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        region.hashCode ^
        address.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        phone.hashCode;
  }
    static List<ProductModel> dummyProduct(UserModel user) {
    try {
      final _faker = Faker();

      List<ProductModel> data = [];
      for (var i = 0; i < products.length; i++) {
        var item = products[i];
        var address = AddressModel(
          city: _faker.address.city(),
          region: _faker.address.state(),
          address: _faker.address.streetAddress(),
          lat: _faker.geo.latitude(),
          long: _faker.geo.longitude(),
          phone: user.phone!,
        );
        var product = ProductModel(
          id: _faker.guid.guid(),
          productName: item['productName'],
          productDescription: item['description'],
          productType: _faker.randomGenerator
              .element(['Animal Product', 'Plant Product']),
          productMeasurement: _faker.randomGenerator.element([
            'Kg',
            'Litre',
            'Unit',
            'Bag',
            'Create',
            'Box',
            'Bottle',
            'Bundle',
            'Bunch',
            'Can',
            'Carton',
            'Dozen',
            'Gallon',
            'Gram',
            'Meter',
            'Pack',
            'Pair',
            'Piece',
            'Roll',
            'Set',
            'Ton',
            'Yard'
          ]),
          productPrice: _faker.randomGenerator.decimal(min: 10).toString(),
          productImages: item['images'],
          productCategory: item['parentCategory'],
          productOwnerId: user.id!,
          productOwnerName: user.name!,
          productOwnerImage:
              user.profileImage ?? _faker.image.image(keywords: ['profile']),
          productStock: _faker.randomGenerator.integer(30),
          address: address.toMap(),
          canBeDelivered: _faker.randomGenerator.boolean(),
          productLocation:
              _faker.randomGenerator.boolean() ? 'On Farm' : 'Off Farm',
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        data.add(product);
      }
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }


}
