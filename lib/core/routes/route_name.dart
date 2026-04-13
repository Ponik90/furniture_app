class Routes {
  static const splashScreen = _RouteItem(
    name: _RouteName.splashScreen,
    path: _RoutePath.splashScreen,
  );

  static const onBoardingScreen = _RouteItem(
    name: _RouteName.onBoardingScreen,
    path: _RoutePath.onBoardingScreen,
  );
  static const welcomeScreen = _RouteItem(
    name: _RouteName.welcomeScreen,
    path: _RoutePath.welcomeScreen,
  );
  static const loginScreen = _RouteItem(
    name: _RouteName.loginScreen,
    path: _RoutePath.loginScreen,
  );

  static const signupScreen = _RouteItem(
    name: _RouteName.signupScreen,
    path: _RoutePath.signupScreen,
  );

  static const homeScreen = _RouteItem(
    name: _RouteName.homeScreen,
    path: _RoutePath.homeScreen,
  );

  static const productScreen = _RouteItem(
    name: _RouteName.productScreen,
    path: _RoutePath.productScreen,
  );

  static const cartScreen = _RouteItem(
    name: _RouteName.cartScreen,
    path: _RoutePath.cartScreen,
  );
}

class _RouteName {
  static const splashScreen = "splashScreen";
  static const welcomeScreen = "welcomeScreen";
  static const onBoardingScreen = "onBoardingScreen";
  static const loginScreen = "loginScreen";
  static const signupScreen = "signupScreen";
  static const homeScreen = "homeScreen";
  static const productScreen = "productScreen";
  static const cartScreen = "cartScreen";
}

class _RoutePath {
  static const splashScreen = "/";
  static const welcomeScreen = "/welcome-screen";
  static const onBoardingScreen = "/on-boarding-screen";

  static const loginScreen = "/login-screen";
  static const signupScreen = "/signup-screen";
  static const homeScreen = "/home-screen";
  static const productScreen = "/product-screen";
  static const cartScreen = "/cart-screen";
}

class _RouteItem {
  final String name;
  final String path;

  const _RouteItem({required this.name, required this.path});
}
