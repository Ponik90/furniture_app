import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/common/widget/common_profile_image.dart';
import 'package:furniture_app/feature/profile/presentation/provider/profile_provider.dart';
import 'package:intl/intl.dart';
import 'package:furniture_app/core/constant/app_imports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with ValidatorsMixin {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final nameFocus = FocusNode();
  final dobFocus = FocusNode();
  final emailFocus = FocusNode();
  final numberFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    numberController.dispose();

    nameFocus.dispose();
    dobFocus.dispose();
    emailFocus.dispose();
    numberFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      if (profileProvider.profileData.id == null) {
        await profileProvider.getProfileData();
      }
      nameController.text = profileProvider.profileData.name ?? "";
      dobController.text = profileProvider.profileData.dob ?? "";
      emailController.text = profileProvider.profileData.email ?? "";
      numberController.text = profileProvider.profileData.number ?? "";
      profileProvider.imageUrl = profileProvider.profileData.image ?? "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Edit Profile`"),
      body: SingleChildScrollView(
        padding: .only(left: 20.w, right: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Center(
                child: Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return SizedBox(
                      height: 120.h,
                      width: 120.h,
                      child: Stack(
                        clipBehavior: .none,
                        children: [
                          Container(
                            clipBehavior: .antiAlias,
                            height: 120.h,
                            width: 120.h,
                            decoration: BoxDecoration(
                              shape: .circle,
                              color: AppTheme.greyColor,
                            ),
                            child: CommonProfileImage(
                              imageUrl: profileProvider.imageUrl,
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<ProfileProvider>()
                                    .getProfileImage();
                              },
                              child: SvgPicture.asset(
                                AppAssets.cameraIcon,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Gap(24.h),
              CommonTextFormField(
                hintText: 'Full Name',
                keyboardType: .name,
                focusNode: nameFocus,
                controller: nameController,
                validator: (p0) =>
                    validateRequired(p0, fieldName: 'Name Is Required'),
              ),
              Gap(20.h),
              CommonTextFormField(
                controller: dobController,
                hintText: 'Date Of Birth',
                focusNode: dobFocus,
                readOnly: true,
                onTap: () {
                  final date = showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  date.then((value) {
                    if (value != null) {
                      dobController.text = DateFormat(
                        'dd-MM-yyyy',
                      ).format(value);
                    }
                  });
                },

                validator: (p0) =>
                    validateRequired(p0, fieldName: 'DOB Is Required'),
                keyboardType: .none,
              ),
              Gap(20.h),
              CommonTextFormField(
                readOnly: true,
                focusNode: emailFocus,
                hintText: 'Email',
                keyboardType: .emailAddress,
                controller: emailController,
                validator: validateEmail,
              ),
              Gap(20.h),
              CommonTextFormField(
                focusNode: numberFocus,
                controller: numberController,
                hintText: 'Enter Number',
                keyboardType: .number,
                validator: validatePhone,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: .only(
          left: 20.w,
          right: 20.w,
          top: 10.h,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return CommonButton(
              isLoading: profileProvider.isUpdateProfile,
              text: 'Edit Profile',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  final imageUrl =
                      profileProvider.imageUrl ==
                          profileProvider.profileData.image
                      ? profileProvider.profileData.image ?? ""
                      : profileProvider.imageUrl;
                  profileProvider.updateProfileData(
                    image: imageUrl,
                    number: numberController.text,
                    name: nameController.text,
                    dob: dobController.text,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
