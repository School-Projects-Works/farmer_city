import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/features/market/services/market_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProductStreamProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) async* {
  var farmerId = ref.watch(userProvider).id;
  if (farmerId == null) return;
  var products = MarketServices.getProductsByFarmer(farmerId);
  await for (var product in products) {
    ref.read(dashboardProductProvider.notifier).setProducts(product);
    yield product;
  }
});

class FilteredProducts {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  FilteredProducts({
    required this.products,
    required this.filteredProducts,
  });

  FilteredProducts copyWith({
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
  }) {
    return FilteredProducts(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
    );
  }
}

final dashboardProductProvider =
    StateNotifierProvider<DashboardProductProvider, FilteredProducts>((ref) {
  return DashboardProductProvider();
});

class DashboardProductProvider extends StateNotifier<FilteredProducts> {
  DashboardProductProvider()
      : super(FilteredProducts(products: [], filteredProducts: []));
  void setProducts(List<ProductModel> products) {
    state = state.copyWith(products: products, filteredProducts: products);
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredProducts: state.products);
    } else {
      var filtered = state.products
          .where((element) =>
              element.productName.toLowerCase().contains(query.toLowerCase()) ||
              element.productCategory
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element.productDescription
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filteredProducts: filtered);
    }
  }

  void deleteProduct(String id) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting product...');
    var res = await MarketServices.deleteProduct(id);
    if (res) {
      var products = state.products;
      products.removeWhere((element) => element.id == id);
      state = state.copyWith(products: products, filteredProducts: products);
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Product deleted');
    } else {
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Failed to delete product');
    }
  }
}
