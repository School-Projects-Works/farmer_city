import 'dart:typed_data';

import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/features/market/provider/market_provider.dart';
import 'package:firmer_city/features/market/services/market_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final newProductProvider =
    StateNotifierProvider<NewProductProvider, ProductModel>(
  (ref) {
    return NewProductProvider();
  },
);

class NewProductProvider extends StateNotifier<ProductModel> {
  NewProductProvider()
      : super(ProductModel(
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: '',
            productName: '',
            productDescription: '',
            productType: '',
            productPrice: '',
            productImages: [],
            productCategory: '',
            productOwnerId: '',
            productOwnerName: '',
            productOwnerImage: '',
            productStock: 0));

  void setProductName(String s) {
    state = state.copyWith(productName: s);
  }

  void setProductDescription(String s) {
    state = state.copyWith(productDescription: s);
  }

  void setProductCategory(value) {
    state = state.copyWith(productCategory: value.toString());
  }

  void setProductPrice(String s) {
    state = state.copyWith(productPrice: s);
  }

  void setStock(String s) {
    state = state.copyWith(productStock: int.parse(s));
  }

  void setMeasurement(value) {
    state = state.copyWith(productMeasurement: () => value.toString());
  }

  void pickImage({required WidgetRef ref}) async {
    var imagePicker = ImagePicker();
      var picks = await imagePicker.pickMultiImage(
          imageQuality: 80, maxWidth: 800, limit: 5);
      for (var i = 0; i < picks.length; i++) {
        var image = await picks[i].readAsBytes();
        if (ref.watch(productImagesProvider).length < 5) {
          ref.read(productImagesProvider.notifier).addImage(image);
        }
      }
    
  }

  void removeImage(Uint8List image, {required WidgetRef ref}) {
    ref.read(productImagesProvider.notifier).removeImage(image);
  }

  void saveProduct(
      {required BuildContext context,
      required WidgetRef ref,
      required GlobalKey<FormState> form}) async {
    CustomDialog.showLoading(message: 'Saving product...');
    var user = ref.watch(userProvider);
    AddressModel address = AddressModel(
        city: '',
        region: 'region',
        address: 'address',
        lat: 0,
        long: 0,
        phone: user.phone!);
    List<String> images = [];
    if (ref.watch(productImagesProvider).isNotEmpty) {
      images =
          await MarketServices.uploadImages(ref.watch(productImagesProvider));
    }
    state = state.copyWith(
        productOwnerId: user.id,
        productOwnerName: user.name,
        id: MarketServices.getId(),
        canBeDelivered: true,
        productType: state.productCategory,
        address: () => address.toMap(),
        productLocation: 'On Farm',
        productImages: images,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        productOwnerImage: user.profileImage);
    var res = await MarketServices.saveProduct(state);
    if (res) {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Product saved');
      state = ProductModel(
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: '',
          productName: '',
          productDescription: '',
          productType: '',
          productPrice: '',
          productImages: [],
          productCategory: '',
          productOwnerId: '',
          productOwnerName: '',
          productOwnerImage: '',
          productStock: 0);
      ref.read(productImagesProvider.notifier).clearImages();
      form.currentState!.reset();
      MyRouter(contex: context, ref: ref)
          .navigateToRoute(RouterInfo.productRoute);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Failed to save product');
    }
  }
}

final productImagesProvider =
    StateNotifierProvider<ProductImages, List<Uint8List>>(
        (ref) => ProductImages());

class ProductImages extends StateNotifier<List<Uint8List>> {
  ProductImages() : super([]);

  void addImage(Uint8List image) {
    state = [...state, image];
  }

  void removeImage(Uint8List image) {
    var images = state.where((element) => element != image).toList();

    state = images;
  }
  
  void clearImages() {
    state = [];
  }
}
