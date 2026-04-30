import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_app/core/constant/app_constant.dart';
import 'package:furniture_app/core/dependency_injection/dependency_injection.dart';
import 'package:furniture_app/core/routes/app_routes.dart';
import 'package:furniture_app/core/theme/app_theme.dart';
import 'package:furniture_app/core/utils/utils.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:furniture_app/feature/bottom_navigation_bar/presentation/provider/bottom_navigation_bar_provider.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(figmaWidth, figmaHeight),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => getIt<OnBoardingProvider>(),
            ),
            ChangeNotifierProvider(
              create: (context) => getIt<BottomNavigationBarProvider>(),
            ),
            ChangeNotifierProvider(create: (context) => getIt<AuthProvider>()),
          ],
          child: MaterialApp.router(
            title: AppConstant.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: .light,
            routerConfig: AppRoutes.router,
          ),
        );
      },
    );
  }
}
