import 'package:furniture_app/core/routes/route_name.dart';
import 'package:furniture_app/feature/on_boarding/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: Routes.splash.path,
    routes: [
      GoRoute(
        name: Routes.splash.name,
        path: Routes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      // GoRoute(
      //   name: Routes.login.name,
      //   path: Routes.login.path,
      //   builder: (context, state) => LoginScreen(),
      // ),
      // GoRoute(
      //   name: Routes.home.name,
      //   path: Routes.home.path,
      //   builder: (context, state) => HomeScreen(),
      // ),
    ],
  );
}