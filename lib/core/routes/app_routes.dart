import 'package:flutter/material.dart';
import 'package:furniture_app/core/routes/route_name.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/on_boarding_screen.dart';
import 'package:furniture_app/feature/on_boarding/presentation/view/splash_screen.dart';
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
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.onBoardingScreen.name,
        path: Routes.onBoardingScreen.path,
        builder: (context, state) => OnBoardingScreen(),
      ),
      // GoRoute(
      //   name: Routes.home.name,
      //   path: Routes.home.path,
      //   builder: (context, state) => HomeScreen(),
      // ),
    ],
  );
}
