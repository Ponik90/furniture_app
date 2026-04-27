import 'package:flutter/material.dart';
import 'package:furniture_app/core/routes/route_name.dart';
import 'package:furniture_app/feature/auth/presentation/view/complete_profile_screen.dart';
import 'package:furniture_app/feature/auth/presentation/view/confirm_otp_screen.dart';
import 'package:furniture_app/feature/auth/presentation/view/forget_password_screen.dart';
import 'package:furniture_app/feature/auth/presentation/view/login_screen.dart';
import 'package:furniture_app/feature/auth/presentation/view/reset_password_screen.dart';
import 'package:furniture_app/feature/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'package:furniture_app/feature/cart/presentation/view/cart_screen.dart';
import 'package:furniture_app/feature/home/presentation/view/home_screen.dart';
import 'package:furniture_app/feature/home/presentation/view/product_detail_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/splash_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/welcome_screen.dart';
import 'package:furniture_app/feature/order/presentation/view/order_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/profile_screen.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/presentation/view/signup_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splashScreen.path,
    routes: [
      GoRoute(
        name: Routes.splashScreen.name,
        path: Routes.splashScreen.path,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.onBoardingScreen.name,
        path: Routes.onBoardingScreen.path,
        builder: (context, state) {
          return OnBoardingScreen();
        },
      ),
      GoRoute(
        name: Routes.welcomeScreen.name,
        path: Routes.welcomeScreen.path,
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        name: Routes.loginScreen.name,
        path: Routes.loginScreen.path,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: Routes.signupScreen.name,
        path: Routes.signupScreen.path,
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        name: Routes.completeProfileScreen.name,
        path: Routes.completeProfileScreen.path,
        builder: (context, state) => CompleteProfileScreen(),
      ),
      GoRoute(
        name: Routes.forgetPasswordScreen.name,
        path: Routes.forgetPasswordScreen.path,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        name: Routes.resetPasswordScreen.name,
        path: Routes.resetPasswordScreen.path,
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        name: Routes.confirmOtpScreen.name,
        path: Routes.confirmOtpScreen.path,
        builder: (context, state) => ConfirmOtpScreen(),
      ),

      GoRoute(
        name: Routes.productDetailScreen.name,
        path: Routes.productDetailScreen.path,
        builder: (context, state) => ProductDetailScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavigationBarView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.homeScreen.name,
                path: Routes.homeScreen.path,
                builder: (context, state) => HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.cartScreen.name,
                path: Routes.cartScreen.path,
                builder: (context, state) => CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.productScreen.name,
                path: Routes.productScreen.path,
                builder: (context, state) => OrderScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.profileScreen.name,
                path: Routes.profileScreen.path,
                builder: (context, state) => ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
