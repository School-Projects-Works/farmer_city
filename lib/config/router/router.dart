import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/features/main/views/home_page.dart';
import 'package:firmer_city/features/main/views/main_page.dart';
import 'package:firmer_city/features/profile/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../features/auth/provider/login_provider.dart';
import '../../features/auth/services/auth_services.dart';
import '../../features/auth/views/pages/login_page.dart';
import '../../features/auth/views/pages/registration_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _authShellNavigatorKey = GlobalKey<NavigatorState>();
final _homeShellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router(WidgetRef ref) => GoRouter(
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
            Hive.box('route').put('currentRoute', RouterInfo.homeRoute.name);
            return null;
          } else if (route.contains('profile') &&
              box.contains(RouterInfo.profileRoute.name)) {
            return null;
          } else {
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
              ]),
        ]);
