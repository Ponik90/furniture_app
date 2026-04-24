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
  static const completeProfileScreen = _RouteItem(
    name: _RouteName.completeProfileScreen,
    path: _RoutePath.completeProfileScreen,
  );
  static const forgetPasswordScreen = _RouteItem(
    name: _RouteName.forgetPasswordScreen,
    path: _RoutePath.forgetPasswordScreen,
  );
  static const resetPasswordScreen = _RouteItem(
    name: _RouteName.resetPasswordScreen,
    path: _RoutePath.resetPasswordScreen,
  );
  static const confirmOtpScreen = _RouteItem(
    name: _RouteName.confirmOtpScreen,
    path: _RoutePath.confirmOtpScreen,
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
  );static const profileScreen = _RouteItem(
    name: _RouteName.profileScreen,
    path: _RoutePath.profileScreen,
  );
}

class _RouteName {
  //! auth flow
  static const splashScreen = "splashScreen";
  static const welcomeScreen = "welcomeScreen";
  static const onBoardingScreen = "onBoardingScreen";
  static const loginScreen = "loginScreen";
  static const signupScreen = "signupScreen";
  static const completeProfileScreen = "completeProfileScreen";
  static const forgetPasswordScreen = "forgetPasswordScreen";
  static const resetPasswordScreen = "resetPasswordScreen";
  static const confirmOtpScreen = "confirmOtpScreen";

  static const homeScreen = "homeScreen";
  static const productScreen = "productScreen";
  static const cartScreen = "cartScreen";
  static const profileScreen = "profileScreen";
}

class _RoutePath {
  static const splashScreen = "/";
  static const welcomeScreen = "/welcome-screen";
  static const onBoardingScreen = "/on-boarding-screen";

  static const loginScreen = "/login-screen";
  static const signupScreen = "/signup-screen";

  static const forgetPasswordScreen = "/forget-password-screen";
  static const resetPasswordScreen = "/reset-password-screen";
  static const confirmOtpScreen = "/confirm-otp-screen";
  static const completeProfileScreen = "/complete-profile-screen";

  static const homeScreen = "/home-screen";
  static const productScreen = "/product-screen";
  static const cartScreen = "/cart-screen";
  static const profileScreen = "/profile-screen";
}

class _RouteItem {
  final String name;
  final String path;

  const _RouteItem({required this.name, required this.path});
}
