import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard(this.product, {super.key});
  final ProductModel product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}