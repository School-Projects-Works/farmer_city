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
  List<String> categories ;
  FilteredProducts({
    required this.products,
    required this.filteredProducts,
    required this.categories
  });

  FilteredProducts copyWith({
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    List<String>? categories
  }) {
    return FilteredProducts(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      categories: categories ?? this.categories
    );
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, FilteredProducts>((ref) {
  return ProductProvider();
});

class ProductProvider extends StateNotifier<FilteredProducts> {
  ProductProvider()
      : super(FilteredProducts(products: [], filteredProducts: [], categories: []));
  void setProducts(List<ProductModel> products) {
    var categories = products.map((e) => e.productCategory).toSet().toList();
    //get unique categories
    
    state = state.copyWith(products: products, filteredProducts: products, categories: categories);
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

  void filterByCategory(value) {
    if (value == 'All') {
      state = state.copyWith(filteredProducts: state.products);
    } else {
      var filtered = state.products
          .where((element) => element.productCategory == value)
          .toList();
      state = state.copyWith(filteredProducts: filtered);
    }
  }
}

final isSearchingProvider = StateProvider<bool>((ref) => false);
