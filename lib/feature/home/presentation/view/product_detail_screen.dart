import 'package:furniture_app/core/common/widget/common_appbar.dart';

import '../../../../core/constant/app_imports.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(title: 'Sofa', backgroundColor: AppTheme.greyColor),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 2.5,
            decoration: BoxDecoration(color: AppTheme.greyColor),
          ),
          Gap(15.h),
          Expanded(
            child: SingleChildScrollView(
              padding: .symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Sofa darta",
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: .w500,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: .center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.ratingIcon,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SvgPicture.asset(
                                  AppAssets.ratingIcon,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SvgPicture.asset(
                                  AppAssets.ratingIcon,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SvgPicture.asset(
                                  AppAssets.ratingIcon,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SvgPicture.asset(
                                  AppAssets.ratingIcon,
                                  height: 20.h,
                                  width: 20.h,
                                  colorFilter: .mode(
                                    AppTheme.greyColor,
                                    .srcIn,
                                  ),
                                ),
                                Gap(20.h),
                                Text("4.5", style: textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(AppAssets.heartIcon),
                    ],
                  ),
                  Gap(20.h),
                  Text("Price", style: textTheme.bodyLarge),
                  Gap(5.h),
                  Text("2005", style: textTheme.bodySmall),
                  Gap(20.h),
                  Text("Description", style: textTheme.bodyLarge),
                  Gap(5.h),
                  Text("Description", style: textTheme.bodySmall),

                  Gap(20.h),
                  Row(
                    spacing: 20.w,
                    children: [
                      Text("Quantity", style: textTheme.bodyLarge),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
