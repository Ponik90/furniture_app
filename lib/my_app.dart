import 'package:flutter/material.dart';
import 'package:furniture_app/core/constant/app_constant.dart';
import 'package:furniture_app/core/dependency_injection/dependency_injection.dart';
import 'package:furniture_app/core/routes/app_routes.dart';
import 'package:furniture_app/core/theme/app_theme.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<OnBoardingProvider>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: .light,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
