import 'package:furniture_app/core/common/widget/common_appbar.dart';

import '../../../../core/constant/app_imports.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(title: AppString.forgetPassword),
      body: Padding(
        padding: .only(left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Text(
              "Forget Your Password?",
              style: textTheme.displaySmall?.copyWith(fontWeight: .w500),
            ),
            Gap(20.h),
            Text(
              "Please Enter Your Register number to get otp",
              style: textTheme.titleMedium,
            ),
            Gap(10.h),
            CommonTextFormField(
              hintText: 'Enter Number',
              keyboardType: .number,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: .only(
          left: 20.w,
          right: 20.w,
          top: 10.h,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
        child: CommonButton(
          text: 'Get Otp',
          onTap: () {
            context.pushNamed(
              Routes.confirmOtpScreen.name,
              queryParameters: {'number': ""},
            );
          },
        ),
      ),
    );
  }
}
