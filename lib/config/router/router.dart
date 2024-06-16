import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/features/assistant/view/assistant_page.dart';
import 'package:firmer_city/features/cart/views/cart_page.dart';
import 'package:firmer_city/features/community/views/edit_post.dart';
import 'package:firmer_city/features/community/views/new_post.dart';
import 'package:firmer_city/features/main/provider/nav_provider.dart';
import 'package:firmer_city/features/main/views/home_page.dart';
import 'package:firmer_city/features/main/views/main_page.dart';
import 'package:firmer_city/features/market/vews/market_page.dart';
import 'package:firmer_city/features/profile/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../features/auth/provider/login_provider.dart';
import '../../features/auth/services/auth_services.dart';
import '../../features/auth/views/pages/login_page.dart';
import '../../features/auth/views/pages/registration_page.dart';
import '../../features/community/views/community_page.dart';
import '../../features/community/views/post_details_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeShellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter routerConfig(WidgetRef ref) => GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: RouterInfo.homeRoute.path,
        redirect: (context, state) async {
          var box = Hive.box('route').get('currentRoute').toString();

          var route = state.matchedLocation;

          if ((route.contains('login'))) {
            var user = await AuthServices.checkIfLoggedIn();
            ref.read(userProvider.notifier).setUser(user);
            if (user.id != null && user.id != '') {
              ref.read(userProvider.notifier).setUser(user);
              Hive.box('route').put('currentRoute', RouterInfo.homeRoute.name);
              return RouterInfo.homeRoute.path;
            }
            return null;
          } else if (route.contains('register') &&
              box.contains(RouterInfo.registerRoute.name)) {
            return null;
          } else if (route.contains('home')) {
            ref.read(navProvider.notifier).state = RouterInfo.homeRoute.name;
            return null;
          } else if (route.contains('assistant') &&
              box.contains(RouterInfo.assistantRoute.name)) {
            return null;
          } else if (route.contains('market') &&
              box.contains(RouterInfo.marketRoute.name)) {
            return null;
          } else if (route.contains('profile') &&
              box.contains(RouterInfo.profileRoute.name)) {
            return null;
          } else if (route.contains('community') &&
              box.contains(RouterInfo.communityRoute.name)) {
            return null;
          } else if (route.contains('post-detail') &&
              box.contains(RouterInfo.postDetailRoute.name)) {
            return null;
          } else if (route.contains('create-post') &&
              box.contains(RouterInfo.createPostRoute.name)) {
            return null;
          } else if (route.contains('cart') &&
              box.contains(RouterInfo.cartRoute.name)) {
            return null;
          } else if (route.contains('edit-post') &&
              box.contains(RouterInfo.editPostRoute.name)) {
            return null;
          } else {
            ref.read(navProvider.notifier).state = RouterInfo.homeRoute.name;
            return RouterInfo.homeRoute.path;
          }
        },
        routes: [
          ShellRoute(
              navigatorKey: _homeShellNavigatorKey,
              builder: (context, state, child) {
                return MainHomePage(
                  shellContext: _homeShellNavigatorKey.currentContext,
                  child: child,
                );
              },
              routes: [
                GoRoute(
                    path: RouterInfo.loginRoute.path,
                    name: RouterInfo.loginRoute.name,
                    builder: (context, state) => const LoginPage()),
                GoRoute(
                    path: RouterInfo.registerRoute.path,
                    name: RouterInfo.registerRoute.name,
                    builder: (context, state) => const RegistrationPage()),
                GoRoute(
                    path: RouterInfo.homeRoute.path,
                    name: RouterInfo.homeRoute.name,
                    builder: (context, state) => const HomePage()),
                GoRoute(
                    path: RouterInfo.profileRoute.path,
                    name: RouterInfo.profileRoute.name,
                    builder: (context, state) => const ProfilePage()),
                GoRoute(
                    path: RouterInfo.communityRoute.path,
                    name: RouterInfo.communityRoute.name,
                    builder: (context, state) => const CommunityPage()),
                GoRoute(
                    path: RouterInfo.assistantRoute.path,
                    name: RouterInfo.assistantRoute.name,
                    builder: (context, state) {
                      return const AssitantPage();
                    }),
                GoRoute(
                    path: RouterInfo.postDetailRoute.path,
                    name: RouterInfo.postDetailRoute.name,
                    builder: (context, state) {
                      final postId = state.pathParameters['id'];
                      return PostDetailPage(
                        postId: postId ?? '',
                      );
                    }),
                GoRoute(
                  path: RouterInfo.createPostRoute.path,
                  name: RouterInfo.createPostRoute.name,
                  builder: (context, state) {
                    return const NewPost();
                  },
                ),
                GoRoute(
                  path: RouterInfo.editPostRoute.path,
                  name: RouterInfo.editPostRoute.name,
                  builder: (context, state) {
                    final postId = state.pathParameters['id'];
                    return EditPost(
                      postId: postId!,
                    );
                  },
                ),
                GoRoute(
                    path: RouterInfo.marketRoute.path,
                    name: RouterInfo.marketRoute.name,
                    builder: (context, state) => const MarketPage()),
                GoRoute(
                    path: RouterInfo.cartRoute.path,
                    name: RouterInfo.cartRoute.name,
                    builder: (context, state) {
                      return const CartPage();
                    }),
              ]),
        ]);
