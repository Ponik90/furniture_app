import 'package:furniture_app/core/constant/app_assets.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/theme/app_theme.dart';
import 'package:gap/gap.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 1.5,
            child: PageView.builder(
              itemCount: 3,
              scrollDirection: .horizontal,
              itemBuilder: (context, index) {
                return Image.asset(AppAssets.onBoardingImage1, fit: .cover);
              },
            ),
          ),
          Container(
            padding: .all(20),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: .min,
              children: [
                Text(
                  "We Provide High Quality Products Just for You",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontSize: 20,
                    fontWeight: .w500,
                  ),
                  textAlign: .center,
                ),
                Gap(24),
                Container(

                  decoration: BoxDecoration(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
