import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FeaturedProducts extends ConsumerStatefulWidget {
  const FeaturedProducts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends ConsumerState<FeaturedProducts> {

  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    return Container(
      width:  breakPoint.screenWidth,
      child: Wrap(children: [],),
    );
  }
}