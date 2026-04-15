import 'package:furniture_app/core/common/widget/common_appbar.dart';

import '../../../../core/constant/app_imports.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                        height: 50.h,
                        width: 50.h,
                      ),
                    ),
                    Align(
                      alignment: .bottomRight,
                      child: SvgPicture.asset(
                        AppAssets.cameraIcon,
                        height: 20.h,
                        width: 20.h,
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
            DropdownButton(
              items: [
                DropdownMenuItem(child: Text("Male")),
                DropdownMenuItem(child: Text("Female")),
              ],
              onChanged: (value) {},
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
          text: 'Submit',
          onTap: () {
            context.goNamed(Routes.homeScreen.name);
          },
        ),
      ),
    );
  }
}
