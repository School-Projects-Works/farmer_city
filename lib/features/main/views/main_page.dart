import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:firmer_city/features/main/views/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainHomePage extends ConsumerWidget {
  const MainHomePage({required this.child, this.shellContext, super.key});
  final Widget child;
  final BuildContext? shellContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: saveDunny(),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Positioned(
                      top: 40, left: 0, right: 0, bottom: 0, child: child),
                  const Positioned(top: 0, left: 0, right: 15, child: NavBar()),
                ],
              );
            }),
      ),
    );
  }

  Future<void> saveDunny() async {
    var data = PostModel.dummy();
    // for (var i = 0; i < 10; i++) {
    //   await CommunityServices.savePost(data[i], []);
    // }
  }
}
