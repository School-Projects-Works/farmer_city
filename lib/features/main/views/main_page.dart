import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:firmer_city/features/main/views/components/nav_bar.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/features/market/services/market_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/login_provider.dart';
import '../../auth/services/auth_services.dart';

class MainHomePage extends ConsumerWidget {
  const MainHomePage({required this.child, this.shellContext, super.key});
  final Widget child;
  final BuildContext? shellContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: checkLogin(ref),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Positioned(
                      top: 0, left: 0, right: 0, bottom: 0, child: child),
                  const Positioned(top: 0, left: 0, right: 15, child: NavBar()),
                ],
              );
            }),
      ),
    );
  }

  Future<void> saveDunny(WidgetRef ref) async {
    await checkLogin(ref);
    var data = PostModel.dummy();
    for (var i = 0; i < 10; i++) {
      data[i].createdAt = DateTime.now().millisecondsSinceEpoch;
      data[i].id = CommunityServices.getId();
      if (i < 2 &&
          ref.watch(userProvider).id != null &&
          ref.watch(userProvider).id != '') {
        data[i].authorId = ref.watch(userProvider).id;
      }
      await CommunityServices.savePost(data[i]);
    }
  }

  Future<void> saveDummyProducts(WidgetRef ref) async {
    print('Called =====================');
    await checkLogin(ref);
    var user = ref.watch(userProvider);
    var data = ProductModel.dummyProducts(user);
    for (var i = 0; i < 10; i++) {
      data[i].createdAt = DateTime.now().millisecondsSinceEpoch;
      data[i].id = MarketServices.getId();
      await MarketServices.saveProduct(data[i]);
    }
  }

  Future<void> checkLogin(WidgetRef ref) async {
    var user = await AuthServices.checkIfLoggedIn();
    if (user.id != null && user.id != '') {
      ref.read(userProvider.notifier).setUser(user);
    }
  }
}
