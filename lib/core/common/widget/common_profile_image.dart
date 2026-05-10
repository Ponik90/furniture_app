import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;

import '../../constant/app_imports.dart';

class CommonProfileImage extends StatelessWidget {
  final String imageUrl;

  const CommonProfileImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 120.h,
      width: 120.h,
      fit: .cover,
      imageUrl: imageUrl,

      placeholder: (context, url) {
        return Padding(
          padding: .all(30.r),
          child: Image.asset(AppAssets.appLogo, height: 120.h, width: 120.h),
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
    );
  }
}
