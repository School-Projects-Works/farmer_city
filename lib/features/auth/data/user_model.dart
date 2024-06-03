import 'dart:convert';

import 'package:flutter/foundation.dart';


class UserModel {
  String? id;
  String? ghId;
  String? userType;
  String? email;
  String? password;
  String? gender;
  String? name;
  String? phone;
  List<String> farmType;
  List<String> productType;
  String? profileImage;
  int? createdAt;
  UserModel({
    this.id,
    this.ghId,
    this.userType,
    this.email,
    this.password,
    this.gender,
    this.name,
    this.phone,
    this.farmType = const [],
    this.productType = const [],
    this.profileImage,
    this.createdAt,
  });

  UserModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? ghId,
    ValueGetter<String?>? userType,
    ValueGetter<String?>? email,
    ValueGetter<String?>? password,
    ValueGetter<String?>? gender,
    ValueGetter<String?>? name,
    ValueGetter<String?>? phone,
    List<String>? farmType,
    List<String>? productType,
    ValueGetter<String?>? profileImage,
    ValueGetter<int?>? createdAt,
  }) {
    return UserModel(
      id: id != null ? id() : this.id,
      ghId: ghId != null ? ghId() : this.ghId,
      userType: userType != null ? userType() : this.userType,
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
      gender: gender != null ? gender() : this.gender,
      name: name != null ? name() : this.name,
      phone: phone != null ? phone() : this.phone,
      farmType: farmType ?? this.farmType,
      productType: productType ?? this.productType,
      profileImage: profileImage != null ? profileImage() : this.profileImage,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ghId': ghId,
      'userType': userType,
      'email': email,
      'password': password,
      'gender': gender,
      'name': name,
      'phone': phone,
      'farmType': farmType,
      'productType': productType,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      ghId: map['ghId'],
      userType: map['userType'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
      name: map['name'],
      phone: map['phone'],
      farmType: List<String>.from(map['farmType']),
      productType: List<String>.from(map['productType']),
      profileImage: map['profileImage'],
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, ghId: $ghId, userType: $userType, email: $email, password: $password, gender: $gender, name: $name, phone: $phone, farmType: $farmType, productType: $productType, profileImage: $profileImage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.ghId == ghId &&
      other.userType == userType &&
      other.email == email &&
      other.password == password &&
      other.gender == gender &&
      other.name == name &&
      other.phone == phone &&
      listEquals(other.farmType, farmType) &&
      listEquals(other.productType, productType) &&
      other.profileImage == profileImage &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      ghId.hashCode ^
      userType.hashCode ^
      email.hashCode ^
      password.hashCode ^
      gender.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      farmType.hashCode ^
      productType.hashCode ^
      profileImage.hashCode ^
      createdAt.hashCode;
  }
}
