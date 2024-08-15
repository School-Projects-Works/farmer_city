import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/assistant/view/assistant_page.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/cart/views/cart_page.dart';
import 'package:firmer_city/features/community/views/edit_post.dart';
import 'package:firmer_city/features/community/views/new_post.dart';
import 'package:firmer_city/features/dashboard/views/dashboard.dart';
import 'package:firmer_city/features/dashboard/views/main_container.dart';
import 'package:firmer_city/features/dashboard/views/orders_page.dart';
import 'package:firmer_city/features/dashboard/views/products/edit_product.dart';
import 'package:firmer_city/features/dashboard/views/products/new_products.dart';
import 'package:firmer_city/features/dashboard/views/products/product_main.dart';
import 'package:firmer_city/features/dashboard/views/products/products_page.dart';
import 'package:firmer_city/features/dashboard/views/profile_page.dart';
import 'package:firmer_city/features/main/views/home_page.dart';
import 'package:firmer_city/features/main/views/main_page.dart';
import 'package:firmer_city/features/market/vews/market_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/views/pages/login_page.dart';
import '../../features/auth/views/pages/registration_page.dart';
import '../../features/community/views/community_page.dart';
import '../../features/community/views/post_details_page.dart';

class MyRouter {
  final WidgetRef ref;
  final BuildContext context;
  MyRouter({
    required this.ref,
    required this.context,
  });
  router() => GoRouter(
          initialLocation: RouterInfo.homeRoute.path,
          redirect: (context, state) async {
            var route = state.fullPath;
            //check if widget is done building
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (route != null && route.isNotEmpty) {
                var item = RouterInfo.getRouteByPath(route);
                ref.read(routerProvider.notifier).state = item.name;
              }
            });
            return null;
          },
          routes: [
            ShellRoute(
                builder: (context, state, child) {
                  return MainHomePage(
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
            ShellRoute(
                builder: (context, state, child) {
                  return MainContainer(
                    child: child,
                  );
                },
                redirect: (context, state) {
                  var userInfo = ref.watch(userProvider);
                  if (userInfo.id == null) {
                    CustomDialog.showToast(message: 'Please login to continue');
                    return RouterInfo.homeRoute.path;
                  }
                  return null;
                },
                routes: [
                  GoRoute(
                      path: RouterInfo.dashboardRoute.path,
                      name: RouterInfo.dashboardRoute.name,
                      builder: (context, state) {
                        return const DashBoard();
                      }),
                  GoRoute(
                      path: RouterInfo.ordersRoute.path,
                      name: RouterInfo.ordersRoute.name,
                      builder: (context, state) {
                        return const OrdersPage();
                      }),
                  GoRoute(
                      path: RouterInfo.profileRoute.path,
                      name: RouterInfo.profileRoute.name,
                      builder: (context, state) {
                        return const ProfilePage();
                      }),
                  ShellRoute(
                      builder: (context, state, child) {
                        return ProductsMainPage(
                          child,
                        );
                      },
                      routes: [
                        GoRoute(
                            path: RouterInfo.productRoute.path,
                            name: RouterInfo.productRoute.name,
                            builder: (context, state) {
                              return const ProductsPage();
                            }),
                        GoRoute(
                            path: RouterInfo.productDetailRoute.path,
                            name: RouterInfo.productDetailRoute.name,
                            builder: (context, state) {
                              final productId = state.pathParameters['id'];
                              return Container(
                                  // productId: productId!,
                                  );
                            }),
                        GoRoute(
                            path: RouterInfo.newProductRoute.path,
                            name: RouterInfo.newProductRoute.name,
                            builder: (context, state) {
                              return const NewProducts();
                            }),
                        //edit product
                        GoRoute(
                            path: RouterInfo.editProductRoute.path,
                            name: RouterInfo.editProductRoute.name,
                            builder: (context, state) {
                              final productId = state.pathParameters['id'];
                              return EditProduct(
                                id: productId!,
                              );
                            }),
                      ])
                ])
          ]);

  void navigateToRoute(RouterInfo item) {
    ref.read(routerProvider.notifier).state = item.name;
    context.go(item.path);
  }

  void navigateToNamed(
      {required Map<String, String> pathParms,
      required RouterInfo item,
      Map<String, dynamic>? extra}) {
    ref.read(routerProvider.notifier).state = item.name;
    context.goNamed(item.name, pathParameters: pathParms, extra: extra);
  }
}

final routerProvider = StateProvider<String>((ref) {
  return RouterInfo.homeRoute.name;
});
