class RouteName {
  static const splash = "splash";
  static const login = "login";
  static const signup = "signup";
  static const home = "home";
  static const product = "product";
  static const cart = "cart";
}

class RoutePath {
  static const splash = "/";
  static const login = "/login";
  static const signup = "/signup";
  static const home = "/home";
  static const product = "/product";
  static const cart = "/cart";
}

class RouteItem {
  final String name;
  final String path;

  const RouteItem({required this.name, required this.path});
}

class Routes {
  static const splash = RouteItem(
    name: RouteName.splash,
    path: RoutePath.splash,
  );

  static const login = RouteItem(name: RouteName.login, path: RoutePath.login);

  static const signup = RouteItem(
    name: RouteName.signup,
    path: RoutePath.signup,
  );

  static const home = RouteItem(name: RouteName.home, path: RoutePath.home);

  static const product = RouteItem(
    name: RouteName.product,
    path: RoutePath.product,
  );

  static const cart = RouteItem(name: RouteName.cart, path: RoutePath.cart);
}
