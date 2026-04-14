import '../../constant/app_imports.dart';

class CommonSocialLoginButtonWidget extends StatelessWidget {
  const CommonSocialLoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
