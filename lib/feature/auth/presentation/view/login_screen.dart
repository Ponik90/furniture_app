import 'package:furniture_app/core/common/widget/common_text_form_field.dart';

import '../../../../core/constant/app_imports.dart';

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
      body: Padding(
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
                'Login to your account',
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
              hintText: 'Email',
              prefixIcon: SvgPicture.asset(
                AppAssets.emailIcon,
                height: 24.h,
                width: 24.h,
                fit: .scaleDown,
              ),
            ),
            Gap(20.h),
            CommonTextFormField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              // obscureText: true,
              hintText: 'Password',
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
        child: CommonButton(
          text: 'Login',
          onTap: () {
            if (_formKey.currentState!.validate()) {
              context.goNamed(Routes.homeScreen.name);
            }
          },
        ),
      ),
    );
  }
}
