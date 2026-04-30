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
                      AppString.welcomeTo,
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
                      AppString.theBestFurnitureApp,
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
              text: AppString.login,
              onTap: () {
                context.goNamed(Routes.loginScreen.name);
              },
            ),
            Gap(20.h),
            CommonButton(
              text: AppString.createAccount,
              onTap: () {
                context.goNamed(Routes.signupScreen.name);
              },
            ),
            Gap(10.h),
            ContinueWithDivider(),
            Gap(20.h),
            CommonSocialLoginButtonWidget(),
          ],
        ),
      ),
    );
  }
}
