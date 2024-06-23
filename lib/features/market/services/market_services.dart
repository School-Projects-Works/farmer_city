import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firmer_city/features/market/data/product_model.dart';

class MarketServices {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // save product to firestore
  static Future<bool> saveProduct(ProductModel data) async {
    try {
      await firestore.collection('products').doc(data.id).set(data.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // get all products from firestore snapshot
  static Stream<List<ProductModel>> getProducts() {
    return firestore.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList());
  }

  // get product by id
  static Future<ProductModel?> getProductById(String id) async {
    try {
      var snapshot = await firestore.collection('products').doc(id).get();
      if (snapshot.exists) {
        return ProductModel.fromMap(snapshot.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // update product
  static Future<bool> updateProduct(ProductModel data) async {
    try {
      await firestore.collection('products').doc(data.id).update(data.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // delete product
  static Future<bool> deleteProduct(String id) async {
    try {
      await firestore.collection('products').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static String getId() {
    return firestore.collection('products').doc().id;
  }

  static Future<List<ProductModel>> getProductsData() async {
    try {
      var data = await firestore.collection('products').get();
      return data.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  static Stream<List<ProductModel>> getProductsByFarmer(String farmerId) {
    return firestore
        .collection('products')
        .where('productOwnerId', isEqualTo: farmerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList());
  }

  static Future<List<String>> uploadImages(List<Uint8List> watch) async {
    try {
      var storage = FirebaseStorage.instance;
      List<String> urls = [];
      for (var item in watch) {
        var ref = storage
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putData(item);
        var url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      return [];
    }
  }
}
