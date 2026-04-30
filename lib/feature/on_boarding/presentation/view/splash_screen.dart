import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).navigateAccordingState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.appLogo,
          height: 304.h,
          width: 316.w,
          fit: .cover,
        ),
      ),
    );
  }
}
