import 'package:flutter/material.dart';
import 'package:furniture_app/core/constant/app_assets.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/constant/app_string.dart';

class OnBoardingProvider extends ChangeNotifier {
  List<Map<String, dynamic>> onBoardingList = [
    {"image": AppAssets.onBoardingImage1, "title": AppString.onboardingText1},
    {"image": AppAssets.onBoardingImage2, "title": AppString.onboardingText2},
    {"image": AppAssets.onBoardingImage3, "title": AppString.onboardingText3},
  ];

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < onBoardingList.length - 1) {
      currentIndex++;
    } else {
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        context.goNamed(Routes.welcomeScreen.name);
      }
    }
  }
}
