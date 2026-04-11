import 'package:furniture_app/core/constant/app_assets.dart';
import 'package:furniture_app/core/constant/app_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      context.goNamed(Routes.onBoardingScreen.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.appLogo,
          height: 304,
          width: 316,
          fit: .cover,
        ),
      ),
    );
  }
}
