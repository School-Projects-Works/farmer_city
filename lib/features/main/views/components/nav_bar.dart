import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NavBar extends ConsumerStatefulWidget {
  const NavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var user = ref.watch(userProvider);
    return Container(
      width: breakPoint.screenWidth,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterInfo.homeRoute);
            },
            child: Image.asset(
              Assets.imagesFarmerLogo,
              width: 200,
            ),
          ),
          const Spacer(),
          if (breakPoint.largerThan(MOBILE))
            Row(
              children: [
                NavItem(
                    title: 'Home',
                    isActive:
                        ref.watch(routerProvider) == RouterInfo.homeRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.homeRoute);
                    }),
                const SizedBox(width: 25),
                NavItem(
                    title: 'Community',
                    isActive: ref.watch(routerProvider) ==
                        RouterInfo.communityRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.communityRoute);
                    }),
                const SizedBox(width: 25),
                NavItem(
                    title: 'Market',
                    isActive: ref.watch(routerProvider) ==
                        RouterInfo.marketRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.marketRoute);
                    }),
                const SizedBox(width: 25),
                NavItem(
                    title: 'Assistant',
                    isActive: ref.watch(routerProvider) ==
                        RouterInfo.assistantRoute.name,
                    onTap: () {
                      MyRouter(context: context, ref: ref)
                          .navigateToRoute(RouterInfo.assistantRoute);
                    }),
                const SizedBox(width: 25),
                if (user.id == null)
                  NavItem(
                      title: 'Login',
                      isActive: ref.watch(routerProvider) ==
                          RouterInfo.loginRoute.name,
                      onTap: () {
                        ref.read(routerProvider.notifier).state =
                            RouterInfo.loginRoute.name;
                        MyRouter(context: context, ref: ref)
                            .navigateToRoute(RouterInfo.loginRoute);
                      })
                else
                  PopupMenuButton<String>(
                    color: Colors.white,
                    offset: const Offset(10, 70),
                    onSelected: (String value) {
                      if (value == 'logout') {
                        CustomDialog.showInfo(
                            message: 'Are you sure you want to logout?',
                            buttonText: 'Yes',
                            onPressed: () {
                              ref
                                  .read(loginProvider.notifier)
                                  .signOut(context: context, ref: ref);
                            });
                      } else if (value == 'dashboard') {
                        MyRouter(context: context, ref: ref)
                            .navigateToRoute(RouterInfo.dashboardRoute);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        padding: EdgeInsets.only(right: 130, left: 20),
                        value: 'dashboard',
                        child: Text('Dashboard'),
                      ),
                      const PopupMenuItem(
                        padding: EdgeInsets.only(right: 130, left: 20),
                        value: 'logout',
                        child: Text('Logout'),
                      ),
                    ],
                    child: CircleAvatar(
                      backgroundColor: secondaryColor,
                      backgroundImage: () {
                        var user = ref.watch(userProvider);
                        if (user.profileImage == null) {
                          return AssetImage(
                            user.gender == 'Male'
                                ? Assets.imagesMale
                                : Assets.imagesFemale,
                          );
                        } else {
                          NetworkImage(user.profileImage!);
                        }
                      }(),
                    ),
                  ),
              ],
            ),
          if (breakPoint.smallerOrEqualTo(MOBILE))
            PopupMenuButton<RouterInfo>(
              color: Colors.white,
              offset: const Offset(10, 70),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: RouterInfo.homeRoute,
                  padding: const EdgeInsets.only(right: 130, left: 20),
                  child: const Text('Home'),
                ),
                PopupMenuItem(
                  value: RouterInfo.communityRoute,
                  padding: const EdgeInsets.only(right: 130, left: 20),
                  child: const Text('Community'),
                ),
                PopupMenuItem(
                  value: RouterInfo.marketRoute,
                  padding: const EdgeInsets.only(right: 130, left: 20),
                  child: const Text('Market'),
                ),
                PopupMenuItem(
                  value: RouterInfo.assistantRoute,
                  padding: const EdgeInsets.only(right: 130, left: 20),
                  child: const Text('Assistant'),
                ),
                if (user.id == null)
                  PopupMenuItem(
                    value: RouterInfo.loginRoute,
                    padding: const EdgeInsets.only(right: 130, left: 20),
                    child: const Text('Login'),
                  )
                else
                  PopupMenuItem(
                    value: RouterInfo.dashboardRoute,
                    padding: const EdgeInsets.only(right: 130, left: 20),
                    child: const Text('Dashboard'),
                  ),
              ],
              icon: const Icon(Icons.menu),
              onSelected: (RouterInfo value) {
                MyRouter(context: context, ref: ref).navigateToRoute(value);
              },
            ),
        ],
      ),
    );
  }
}

class NavItem extends ConsumerStatefulWidget {
  const NavItem(
      {required this.title,
      required this.onTap,
      this.isActive = false,
      super.key});
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavItemState();
}

class _NavItemState extends ConsumerState<NavItem> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widget.isActive ? primaryColor : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Text(
          widget.title,
          style: styles.body(
              color: widget.isActive ? primaryColor : Colors.grey,
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w300),
        ),
      ),
    );
  }
}
