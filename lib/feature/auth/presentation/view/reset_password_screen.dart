import '../../../../core/common/widget/common_appbar.dart';
import '../../../../core/constant/app_imports.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(title: AppString.createNewPassword),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppAssets.resetPasswordImage),
              Gap(20.h),
              Text(
                AppString.createYourNewPassword,
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Gap(30.h),
              CommonTextFormField(
                suffixIcon: SvgPicture.asset(
                  AppAssets.eyeOffIcon,
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.scaleDown,
                ),
                hintText: AppString.password,
                prefixIcon: SvgPicture.asset(
                  AppAssets.lockIcon,
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.scaleDown,
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              Gap(20.h),
              CommonTextFormField(
                hintText: AppString.password,
                suffixIcon: SvgPicture.asset(
                  AppAssets.eyeOffIcon,
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.scaleDown,
                ),
                prefixIcon: SvgPicture.asset(
                  AppAssets.lockIcon,
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.scaleDown,
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 10.h,
          bottom: MediaQuery.paddingOf(context).bottom + 20.h,
        ),
        child: CommonButton(
          text: 'Confirmed',
          onTap: () {
            context.pushNamed(Routes.loginScreen.name);
          },
        ),
      ),
    );
  }
}
