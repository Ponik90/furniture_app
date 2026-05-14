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
import 'package:furniture_app/feature/home/presentation/view/add_product_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/splash_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/welcome_screen.dart';
import 'package:furniture_app/feature/order/presentation/view/order_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/add_location_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/edit_profile_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/privacy_policy_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/profile_screen.dart';
import 'package:furniture_app/feature/home/presentation/view/favorite_screen.dart';
import 'package:furniture_app/feature/home/presentation/view/search_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/address_list_screen.dart';
import 'package:furniture_app/feature/profile/presentation/view/wallet_screen.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';
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
        builder: (context, state) {
          final userId = state.uri.queryParameters['user_id'];
          final email = state.uri.queryParameters['email'];
          return CompleteProfileScreen(
            userId: userId ?? "",
            email: email ?? "",
          );
        },
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
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        name: Routes.editProfileScreen.name,
        path: Routes.editProfileScreen.path,
        builder: (context, state) => EditProfileScreen(),
      ),
      GoRoute(
        name: Routes.addLocationScreen.name,
        path: Routes.addLocationScreen.path,
        builder: (context, state) => AddLocationScreen(),
      ),
      GoRoute(
        name: Routes.privacyPolicyScreen.name,
        path: Routes.privacyPolicyScreen.path,
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(
        name: Routes.addProductScreen.name,
        path: Routes.addProductScreen.path,
        builder: (context, state) => const AddProductScreen(),
      ),
      GoRoute(
        name: Routes.favoriteScreen.name,
        path: Routes.favoriteScreen.path,
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        name: Routes.addressListScreen.name,
        path: Routes.addressListScreen.path,
        builder: (context, state) => const AddressListScreen(),
      ),
      GoRoute(
        name: Routes.walletScreen.name,
        path: Routes.walletScreen.path,
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        name: Routes.searchScreen.name,
        path: Routes.searchScreen.path,
        builder: (context, state) => const SearchScreen(),
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
                name: Routes.orderScreen.name,
                path: Routes.orderScreen.path,
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
