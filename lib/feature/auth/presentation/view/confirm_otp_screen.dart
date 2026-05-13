import 'package:furniture_app/core/common/widget/common_appbar.dart';
import '../../../../core/constant/app_imports.dart';

class ConfirmOtpScreen extends StatefulWidget {
  const ConfirmOtpScreen({super.key});

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CommonAppBar(title: AppString.forgetPassword),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Code has been send to +91-99...96",
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(40.h),
            const CommonTextFormField(
              hintText: 'Enter Number',
              keyboardType: TextInputType.number,
            ),
            Gap(30.h),
            Center(
              child: Text(
                "Resend code in 55s",
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
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
          text: 'Verify',
          onTap: () {
            context.pushNamed(Routes.resetPasswordScreen.name);
          },
        ),
      ),
    );
  }
}
