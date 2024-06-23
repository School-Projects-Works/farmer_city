

class RouterInfo {
  String name;
  String path;

  RouterInfo({required this.name, required this.path});

  static RouterInfo loginRoute = RouterInfo(name: 'login', path: '/login');
  static RouterInfo registerRoute =
      RouterInfo(name: 'register', path: '/register');
  static RouterInfo forgetPasswordRoute =
      RouterInfo(name: 'forget-password', path: '/forget-password');
  static RouterInfo homeRoute = RouterInfo(name: 'home', path: '/home');
  static RouterInfo profileRoute =
      RouterInfo(name: 'profile', path: '/profile');

  static RouterInfo communityRoute =
      RouterInfo(name: 'community', path: '/community');
  static RouterInfo marketRoute = RouterInfo(name: 'market', path: '/market');
  static RouterInfo assistantRoute =
      RouterInfo(name: 'assistant', path: '/assistant');

  static RouterInfo postDetailRoute =
      RouterInfo(name: 'post-detail', path: '/post-detail/:id');

  static RouterInfo createPostRoute =
      RouterInfo(name: 'create-post', path: '/create-post');
  static RouterInfo editPostRoute =
      RouterInfo(name: 'edit-post', path: '/edit-post/:id');

  static RouterInfo cartRoute = RouterInfo(name: 'cart', path: '/cart');

  static RouterInfo productDetailRoute =
      RouterInfo(name: 'product-detail', path: '/product-detail/:id');
  // dashboard
  static RouterInfo dashboardRoute =
      RouterInfo(name: 'dashboard', path: '/dashboard');
  //product
  static RouterInfo productRoute =
      RouterInfo(name: 'product', path: '/product');
  //orders
  static RouterInfo ordersRoute = RouterInfo(name: 'orders', path: '/orders');

  static RouterInfo newProductRoute = RouterInfo(name: 'new-product', path: '/new-product');
  static RouterInfo editProductRoute = RouterInfo(name: 'edit-product', path: '/edit-product/:id');





      static List<RouterInfo> get allRoutes => [
        homeRoute,
        loginRoute,
        registerRoute,
        profileRoute,
       
        dashboardRoute,
        productRoute,
        ordersRoute,
        communityRoute,
        marketRoute,
        assistantRoute,
        postDetailRoute,
        createPostRoute,
        editPostRoute,
        cartRoute,
        productDetailRoute,

      ];

  static RouterInfo getRouteByPath(String fullPath) {
    return allRoutes.firstWhere((element) => element.path == fullPath);
  }
}
