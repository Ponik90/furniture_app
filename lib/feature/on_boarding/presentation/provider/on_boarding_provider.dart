import 'package:furniture_app/core/constant/app_imports.dart';

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

  final pageController = PageController();

  void nextPage() {
    if (currentIndex < onBoardingList.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentIndex++;
      notifyListeners();
    } else {
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        context.goNamed(Routes.welcomeScreen.name);
      }
    }
  }
}
