import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_app/core/constant/app_constant.dart';
import 'package:furniture_app/core/dependency_injection/dependency_injection.dart';
import 'package:furniture_app/core/routes/app_routes.dart';
import 'package:furniture_app/core/theme/app_theme.dart';
import 'package:furniture_app/core/utils/utils.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:furniture_app/feature/bottom_navigation_bar/presentation/provider/bottom_navigation_bar_provider.dart';
import 'package:furniture_app/feature/home/presentation/provider/home_provider.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/profile_provider.dart';
import 'package:furniture_app/feature/cart/presentation/provider/cart_provider.dart';
import 'package:furniture_app/feature/home/presentation/provider/favorite_provider.dart';
import 'package:furniture_app/feature/home/presentation/provider/search_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/address_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/wallet_provider.dart';
import 'package:furniture_app/feature/order/presentation/provider/order_provider.dart';
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
            ChangeNotifierProvider(create: (context) => getIt<HomeProvider>()),
            ChangeNotifierProvider(
              create: (context) => getIt<FavoriteProvider>(),
            ),
            ChangeNotifierProvider(create: (context) => getIt<CartProvider>()),
            ChangeNotifierProvider(
              create: (context) => getIt<AddressProvider>(),
            ),
            ChangeNotifierProvider(create: (context) => getIt<WalletProvider>()),
            ChangeNotifierProvider(create: (context) => getIt<SearchProvider>()),
            ChangeNotifierProvider(
              create: (context) => getIt<ProfileProvider>(),
            ),
            ChangeNotifierProvider(create: (context) => getIt<OrderProvider>()),
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
