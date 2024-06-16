import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/features/market/services/market_services.dart';

final productStreamProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) async* {
  var products = MarketServices.getProducts();
  await for (var product in products) {
    ref.read(productProvider.notifier).setProducts(product);
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

final productProvider =
    StateNotifierProvider<ProductProvider, FilteredProducts>((ref) {
  return ProductProvider();
});

class ProductProvider extends StateNotifier<FilteredProducts> {
  ProductProvider()
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
                  .contains(query.toLowerCase())|| element.productDescription.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filteredProducts: filtered);
    }
  }

}
