import 'dart:ui';
import 'package:furniture_app/core/constant/app_imports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20,
          right: 20.w,
          left: 20.w,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: .all(20.r),
                decoration: BoxDecoration(
                  color: AppTheme.greyColor.withValues(alpha: 0.3),
                  borderRadius: .circular(18.r),
                ),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  spacing: 0,
                  children: [
                    Text(
                      "Welcome to",
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: .w400,
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: .center,
                    ),
                    Text(
                      "FURNITURE",
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 48.sp,
                        fontWeight: .w500,
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: .center,
                    ),
                    Text(
                      "FURNITUPHY",
                      style: textTheme.displayLarge?.copyWith(
                        fontWeight: .w500,
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: .center,
                    ),
                    Gap(10.h),
                    Text(
                      "The best furniture e-commerce app of the country for your daily needs",
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: .center,
                    ),
                  ],
                ),
              ),
            ),
            Gap(30.h),
            CommonButton(
              text: "Login",
              onTap: () {
                context.goNamed(Routes.loginScreen.name);
              },
            ),
            Gap(20.h),
            CommonButton(
              text: "Create Account",
              onTap: () {
                context.goNamed(Routes.signupScreen.name);
              },
            ),
            Gap(10.h),
            Row(
              spacing: 10.w,
              children: [
                Expanded(child: Divider(height: 1)),
                Text("Or Continue With"),

                Expanded(child: Divider(height: 1)),
              ],
            ),
            Gap(20.h),
            Center(
              child: Row(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                spacing: 20.w,

                children: [
                  Container(
                    padding: .all(10.r),
                    decoration: BoxDecoration(
                      color: AppTheme.greyColor,
                      shape: .circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.googleIcon,
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  Container(
                    padding: .all(10.r),
                    decoration: BoxDecoration(
                      color: AppTheme.greyColor,
                      shape: .circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.appleIcon,
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
