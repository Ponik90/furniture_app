import 'package:cached_network_image/cached_network_image.dart';
import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/constant/app_imports.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String userId, email;

  const CompleteProfileScreen({
    super.key,
    required this.userId,
    required this.email,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with ValidatorsMixin {
  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Fill Your Profile", showLeading: false),
      body: SingleChildScrollView(
        padding: .only(left: 20.w, right: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Center(
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
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
                            child: authProvider.isUploadingImage
                                ? CircularProgressIndicator()
                                : authProvider.imageUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    height: 120.h,
                                    width: 120.h,
                                    fit: .cover,
                                    imageUrl: authProvider.imageUrl,
                                  )
                                : Center(
                                    child: SvgPicture.asset(
                                      AppAssets.profileIcon,
                                      height: 60.h,
                                      width: 60.h,
                                    ),
                                  ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                context.read<AuthProvider>().getProfileImage();
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
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return CommonButton(
              isLoading: authProvider.isCompletingAccount,
              text: 'Submit',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  authProvider.completeProfile(
                    userId: widget.userId,
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
