import 'package:cached_network_image/cached_network_image.dart';
import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/profile/presentation/provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Profile", showLeading: false),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Column(
            crossAxisAlignment: .start,
            children: [
              Center(
                child: SizedBox(
                  height: 120.h,
                  width: 120.h,
                  child: Container(
                    clipBehavior: .antiAlias,
                    height: 120.h,
                    width: 120.h,
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: AppTheme.greyColor,
                    ),
                    child: CachedNetworkImage(
                      height: 120.h,
                      width: 120.h,
                      fit: .cover,
                      imageUrl: profileProvider.profileData.image ?? "",

                      placeholder: (context, url) {
                        return Image.asset(
                          AppAssets.appLogo,
                          height: 120.h,
                          width: 120.h,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Padding(
                          padding: .all(20.r),
                          child: SvgPicture.asset(
                            AppAssets.profileIcon,
                            height: 24.h,
                            width: 24.h,
                            fit: .cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Gap(10.h),

              Center(
                child: Text(
                  profileProvider.profileData.name ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  profileProvider.profileData.number ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Gap(20.h),
              commonTile(
                onTap: () {

                  // context.pushNamed(Routes.editProfileScreen.name);
                },
                icon: AppAssets.profileIcon,
                title: 'Edit Profile',
              ),
              commonTile(
                onTap: () {},
                icon: AppAssets.locationIcon,
                title: 'Add Location',
              ),
              commonTile(
                onTap: () {},
                icon: AppAssets.lockIcon2,
                title: 'Privacy Policy',
              ),

              commonTile(
                onTap: () {},
                icon: AppAssets.logoutIcon,
                title: 'Log out',
                isLogout: true,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget commonTile({
    required String title,
    required String icon,
    required Function() onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: .symmetric(horizontal: 20.w),
      minTileHeight: 60.h,
      selectedColor: Colors.transparent,
      splashColor: Colors.transparent,

      onTap: onTap,
      leading: SvgPicture.asset(icon, height: 24.h, width: 24.h),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isLogout ? AppTheme.error : null,
          fontWeight: .w500
        ),
      ),
      trailing: isLogout
          ? null
          : SvgPicture.asset(
              AppAssets.rightArrowIcon,
              height: 24.h,
              width: 24.h,
            ),
    );
  }
}
