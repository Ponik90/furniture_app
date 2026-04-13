import 'package:flutter/material.dart';
import 'package:furniture_app/core/routes/route_name.dart';
import 'package:furniture_app/feature/auth/presentation/view/login_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/splash_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/welcome_screen.dart';
import 'package:go_router/go_router.dart';

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
    ],
  );
}
