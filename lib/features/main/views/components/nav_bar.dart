import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/functions/navigation.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/main/provider/nav_provider.dart';
import 'package:firmer_city/generated/assets.dart';
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
              navigateToRoute(context: context, route: RouterInfo.homeRoute);
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
                        ref.watch(navProvider) == RouterInfo.homeRoute.name,
                    onTap: () {
                      ref.read(navProvider.notifier).state =
                          RouterInfo.homeRoute.name;
                      navigateToRoute(
                          context: context, route: RouterInfo.homeRoute);
                    }),
                const SizedBox(width: 25),
                NavItem(
                    title: 'Community',
                    isActive: ref.watch(navProvider) ==
                        RouterInfo.communityRoute.name,
                    onTap: () {
                      ref.read(navProvider.notifier).state =
                          RouterInfo.communityRoute.name;
                      navigateToRoute(
                          context: context, route: RouterInfo.communityRoute);
                    }),
                const SizedBox(width: 25),
                NavItem(
                    title: 'Market',
                    isActive:
                        ref.watch(navProvider) == RouterInfo.marketRoute.name,
                    onTap: () {
                      ref.read(navProvider.notifier).state =
                          RouterInfo.marketRoute.name;
                      navigateToRoute(
                          context: context, route: RouterInfo.marketRoute);
                    }),
                const SizedBox(width: 25),
                NavItem(
                    title: 'Assistant',
                    isActive: ref.watch(navProvider) ==
                        RouterInfo.assistantRoute.name,
                    onTap: () {
                      ref.read(navProvider.notifier).state =
                          RouterInfo.assistantRoute.name;
                      navigateToRoute(
                          context: context, route: RouterInfo.assistantRoute);
                    }),
                const SizedBox(width: 25),
                if (user.id == null)
                  NavItem(
                      title: 'Login',
                      isActive:
                          ref.watch(navProvider) == RouterInfo.loginRoute.name,
                      onTap: () {
                        ref.read(navProvider.notifier).state =
                            RouterInfo.loginRoute.name;
                        navigateToRoute(
                            context: context, route: RouterInfo.loginRoute);
                      })
                else
                  PopupMenuButton(
                    color: Colors.white,
                    offset: const Offset(10, 70),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        padding: EdgeInsets.only(right: 130, left: 20),
                        child: Text('Profile'),
                      ),
                      const PopupMenuItem(
                        padding: EdgeInsets.only(right: 130, left: 20),
                        child: Text('Logout'),
                      ),
                    ],
                    child: CircleAvatar(
                        radius: 20,
                        backgroundImage: user.profileImage != null
                            ? NetworkImage(user.profileImage!)
                            : null,
                        child: user.profileImage == null
                            ? const Icon(Icons.person)
                            : null),
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
                    value:  RouterInfo.profileRoute,
                    padding: const EdgeInsets.only(right: 130, left: 20),
                    child: const Text('Profile'),
                  ),
              ],
              icon: const Icon(Icons.menu),
              onSelected: (RouterInfo value) {
                ref.read(navProvider.notifier).state = value.name;
                navigateToRoute(context: context, route: value);
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
    var styles = CustomStyles(context: context);
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
          style: styles.textStyle(
              color: widget.isActive ? primaryColor : Colors.grey,
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w300),
        ),
      ),
    );
  }
}
