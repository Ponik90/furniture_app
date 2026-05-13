import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/profile_provider.dart';
import 'package:furniture_app/core/common/widget/common_profile_image.dart';

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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthProvider>().logOut();
            },
            child: const Text("Logout", style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Profile", showLeading: false),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
              Center(
                child: SizedBox(
                  height: 120.h,
                  width: 120.h,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.greyColor,
                    ),
                    child: CommonProfileImage(
                      imageUrl: profileProvider.profileData.image ?? "",
                    ),
                  ),
                ),
              ),
              Gap(10.h),

              Center(
                child: Text(
                  profileProvider.profileData.name ?? "User Name",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  profileProvider.profileData.number ?? "Phone Number",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
              ),
              Gap(30.h),
              commonTile(
                onTap: () {
                  context.pushNamed(Routes.editProfileScreen.name);
                },
                icon: AppAssets.profileIcon,
                title: 'Edit Profile',
              ),
              commonTile(
                onTap: () {
                  context.pushNamed(Routes.favoriteScreen.name);
                },
                icon: AppAssets.heartIcon,
                title: 'My Favorites',
              ),
              commonTile(
                onTap: () {
                  context.pushNamed(Routes.addressListScreen.name);
                },
                icon: AppAssets.locationIcon,
                title: 'My Address',
              ),
              commonTile(
                onTap: () {
                  context.pushNamed(Routes.walletScreen.name);
                },
                icon: AppAssets.walletIcon,
                title: 'My Wallet',
              ),
              commonTile(
                onTap: () {
                  context.pushNamed(Routes.privacyPolicyScreen.name);
                },
                icon: AppAssets.lockIcon2,
                title: 'Privacy Policy',
              ),

              commonTile(
                onTap: _showLogoutDialog,
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      onTap: onTap,
      leading: SvgPicture.asset(
        icon, 
        height: 24.h, 
        width: 24.h,
        colorFilter: isLogout ? const ColorFilter.mode(AppTheme.error, BlendMode.srcIn) : null,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isLogout ? AppTheme.error : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isLogout
          ? null
          : SvgPicture.asset(
              AppAssets.rightArrowIcon,
              height: 20.h,
              width: 20.h,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
    );
  }
}
