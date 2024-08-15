import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/dashboard/components/side_bar_item.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = Styles(context);
    return Container(
        width: 200,
        height: styles.height,
        color: primaryColor,
        child: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(
                    text: 'Hello, \n',
                    style: styles.body(
                        color: Colors.white38, fontFamily: 'Raleway'),
                    children: [
                  TextSpan(
                      text: ref.watch(userProvider).name ?? '',
                      style: styles.subtitle(
                          fontWeight: FontWeight.bold,
                          desktop: 16,
                          mobile: 13,
                          tablet: 14,
                          color: Colors.white,
                          fontFamily: 'Raleway'))
                ])),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Column(
              children: [
                SideBarItem(
                  title: 'Dashboard',
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  icon: Icons.dashboard,
                  isActive: ref.watch(routerProvider) ==
                      RouterInfo.dashboardRoute.name,
                  onTap: () {
                    MyRouter(context: context, ref: ref)
                        .navigateToRoute(RouterInfo.dashboardRoute);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SideBarItem(
                    title: 'Products',
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    icon: Icons.local_hospital,
                    isActive: ref.watch(routerProvider) ==
                        RouterInfo.productRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.productRoute);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SideBarItem(
                    title: 'Orders',
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    icon: Icons.person,
                    isActive: ref.watch(routerProvider) ==
                        RouterInfo.ordersRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.ordersRoute);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SideBarItem(
                    title: 'Profile',
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    icon: Icons.person,
                    isActive: ref.watch(routerProvider) ==
                        RouterInfo.profileRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.profileRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
          // footer
          Text('© 2024 All rights reserved',
              style: styles.body(
                  color: Colors.white38, desktop: 12, fontFamily: 'Raleway')),
        ]));
  }
}
