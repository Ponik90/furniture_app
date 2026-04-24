import 'package:furniture_app/core/constant/app_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20,
          right: 20.w,
          left: 20.w,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Image.asset(AppAssets.loginVectorImage),
            Gap(20.h),
            Center(
              child: Text(
                AppString.loginToYourAccount,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 30.sp),
                textAlign: .center,
              ),
            ),
            Gap(30.h),
            CommonTextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              hintText: AppString.email,
              prefixIcon: SvgPicture.asset(
                AppAssets.emailIcon,
                height: 24.h,
                width: 24.h,
                fit: .scaleDown,
              ),
              keyboardType: .emailAddress,
            ),
            Gap(20.h),
            CommonTextFormField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              // obscureText: true,
              hintText: AppString.password,
              suffixIcon: SvgPicture.asset(
                AppAssets.eyeOffIcon,
                height: 24.h,
                width: 24.h,
                fit: .scaleDown,
              ),
              prefixIcon: SvgPicture.asset(
                AppAssets.lockIcon,
                height: 24.h,
                width: 24.h,
                fit: .scaleDown,
              ),
              keyboardType: .visiblePassword,
            ),
            Gap(10.h),
            GestureDetector(
              onTap: () {
                context.pushNamed(Routes.forgetPasswordScreen.name);
              },
              child: Align(
                alignment: .centerRight,
                child: Text(
                  "${AppString.forgetPassword}?",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),

            Gap(30.h),
            CommonButton(
              text: AppString.login,
              onTap: () {
                // if (_formKey.currentState!.validate()) {
                  context.goNamed(Routes.homeScreen.name);
                // }
              },
            ),
            Gap(20.h),
            ContinueWithDivider(),
            Gap(20.h),
            CommonSocialLoginButtonWidget(),

            Gap(40.h),
            GestureDetector(
              onTap: () {
                context.goNamed(Routes.signupScreen.name);
              },
              child: Center(
                child: Text(
                  AppString.dontHaveAccount,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
