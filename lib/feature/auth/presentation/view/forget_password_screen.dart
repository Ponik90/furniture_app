import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import '../../../../core/constant/app_imports.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(title: AppString.forgetPassword),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            Text(
              "Forgot Your Password?",
              style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Gap(16.h),
            Text(
              "Enter your registered email address to receive a password reset link.",
              style: textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            Gap(32.h),
            CommonTextFormField(
              controller: _emailController,
              hintText: 'Enter Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 10.h,
              bottom: MediaQuery.paddingOf(context).bottom + 20.h,
            ),
            child: CommonButton(
              text: 'Send Reset Link',
              isLoading: authProvider.isResettingPassword,
              onTap: () {
                if (_emailController.text.isNotEmpty) {
                  authProvider.forgetPassword(email: _emailController.text);
                } else {
                  CommonSnackbar.show(
                    context: context,
                    message: "Please enter your email",
                    isError: true,
                  );
                }
              },
              borderRadius: 30.r,
            ),
          );
        },
      ),
    );
  }
}
