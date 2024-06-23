import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsMainPage extends ConsumerWidget {
  const ProductsMainPage(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }
}