import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with ValidatorsMixin {
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Image.asset(AppAssets.loginVectorImage),
              Gap(20.h),
              Center(
                child: Text(
                  AppString.createYourAccount,
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
                validator: validateEmail,
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
                validator: validatePassword,
              ),
              Gap(30.h),
              CommonButton(
                text: AppString.signup,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthProvider>().createAccount(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                },
              ),
              Gap(20.h),
              ContinueWithDivider(),
              Gap(20.h),
              CommonSocialLoginButtonWidget(),

              Gap(40.h),
              GestureDetector(
                onTap: () {
                  context.goNamed(Routes.loginScreen.name);
                },
                child: Center(
                  child: Text(
                    AppString.alreadyHaveAccount,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
