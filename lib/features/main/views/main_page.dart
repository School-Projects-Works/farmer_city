import 'package:firmer_city/features/main/views/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainHomePage extends ConsumerWidget {
  const MainHomePage({required this.child, this.shellContext, super.key});
  final Widget child;
  final BuildContext? shellContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(top: 0, left: 0, right: 0, bottom: 0, child: child),
            const Positioned(top: 0, left: 0, right: 15, child: NavBar()),
          ],
        ),
      ),
    );
  }
}
