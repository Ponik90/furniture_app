import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';

import '../../../../core/constant/app_imports.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Fill Your Profile", showLeading: false),
      body: SingleChildScrollView(
        padding: .only(left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Center(
              child: Container(
                height: 120.h,
                width: 120.h,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppTheme.greyColor,
                ),
                child: Stack(
                  clipBehavior: .none,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        AppAssets.profileIcon,
                        height: 60.h,
                        width: 60.h,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 0,
                      child: SvgPicture.asset(
                        AppAssets.cameraIcon,
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(24.h),
            CommonTextFormField(hintText: 'Full Name', keyboardType: .name),
            Gap(20.h),
            CommonTextFormField(
              hintText: 'Date Of Birth',
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );
              },
              keyboardType: .none,
            ),
            Gap(20.h),
            CommonTextFormField(hintText: 'Email', keyboardType: .emailAddress),
            Gap(20.h),
            CommonTextFormField(
              hintText: 'Enter Number',
              keyboardType: .number,
            ),
            Gap(20.h),
            // DropdownButton(
            //   items: [
            //     DropdownMenuItem(child: Text("Male")),
            //     DropdownMenuItem(child: Text("Female")),
            //   ],
            //   onChanged: (value) {},
            // ),
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
          text: 'Submit',
          onTap: () {
              context.read<AuthProvider>().completeProfile(email: 'email', password: 'password');
          },
        ),
      ),
    );
  }
}
