import 'dart:typed_data';
import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/dashboard/provider/new_product_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../market/services/market_services.dart';

final editProductProvider =
    StateNotifierProvider<EditProductProvider, ProductModel>((ref) {
  return EditProductProvider();
});

class EditProductProvider extends StateNotifier<ProductModel> {
  EditProductProvider()
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

  void setProduct(ProductModel product) {
    state = product;
  }

  void setProductName(String s) {
    state = state.copyWith(productName: s);
  }

  void setProductDescription(String s) {
    state = state.copyWith(productDescription: s);
  }

  void setProductCategory(value) {
    state = state.copyWith(productCategory: value);
  }

  void setProductPrice(String s) {
    state = state.copyWith(productPrice: s);
  }

  void setStock(String s) {
    state = state.copyWith(productStock: int.parse(s));
  }

  void setMeasurement(value) {
    state = state.copyWith(productMeasurement:  value.toString());
  }

  void removeImageUrl(image) {
    state = state.copyWith(productImages: state.productImages..remove(image));
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

  void updateProduct(
      {required BuildContext context,
      required WidgetRef ref,
      required GlobalKey<FormState> form}) async {
    CustomDialog.showLoading(message: 'Saving product...');
    List<String> images = state.productImages;
    if (ref.watch(productImagesProvider).isNotEmpty) {
      images =
          await MarketServices.uploadImages(ref.watch(productImagesProvider));
    }
    state = state.copyWith(
      productImages: images,
    );
    var res = await MarketServices.updateProduct(state);
    if (res) {
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
      ref.read(productImagesProvider.notifier).state = [];
      form.currentState!.reset();
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Product updated');
      MyRouter(context: context, ref: ref)
          .navigateToRoute(RouterInfo.productRoute);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Failed to update product');
    }
  }
}
