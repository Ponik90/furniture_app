import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/common/widget/common_product_grid.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(title: "Home", showLeading: false, showAction: true),

      body: SingleChildScrollView(
        padding: .only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.viewPaddingOf(context).bottom + 20.h,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            //*Category
            commonTitleText(textTheme: textTheme, title: 'Category'),
            Gap(20.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              padding: .zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 80.h,
                crossAxisCount: 4,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
              ),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  spacing: 10.h,
                  children: [
                    Container(
                      padding: .all(12.r),
                      decoration: BoxDecoration(
                        color: AppTheme.greyColor,
                        shape: .circle,
                      ),
                      child: SvgPicture.asset(
                        AppAssets.homeIcon,
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                    Text("Category", style: textTheme.bodyMedium),
                  ],
                );
              },
            ),
            Gap(30.h),
            //*Popular Products
            commonTitleText(textTheme: textTheme, title: 'Popular Products'),
            Gap(20.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              padding: .zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 250.h,
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Container(
                        padding: .all(16.r),
                        decoration: BoxDecoration(
                          color: AppTheme.greyColor,
                          borderRadius: .circular(10.r),
                        ),
                        clipBehavior: .antiAlias,
                        child: Stack(
                          clipBehavior: .antiAlias,

                          children: [
                            Image.asset(AppAssets.appLogo),

                            Align(
                              alignment: .topRight,
                              child: SvgPicture.asset(AppAssets.heartIcon),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.h),
                      Row(
                        crossAxisAlignment: .center,
                        children: [
                          Expanded(
                            child: Text(
                              "Product Name",
                              style: textTheme.bodyMedium,
                            ),
                          ),
                          SvgPicture.asset(
                            AppAssets.ratingIcon,
                            height: 12.h,
                            width: 12.h,
                          ),
                          Gap(5.w),
                          Text('4.5', style: textTheme.bodySmall),
                        ],
                      ),
                      Gap(5.h),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .center,
                        children: [
                          Text(
                            "200.00",
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: .w500,
                            ),
                          ),
                          CommonButton(
                            text: 'Add to cart',
                            onTap: () {},
                            backgroundColor: AppTheme.greyColor,
                            width: MediaQuery.widthOf(context) / 5,
                            padding: .zero,
                            height: 25,
                            textSize: 10.sp,
                            textColor: AppTheme.blackColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            //*Popular Products
            commonTitleText(textTheme: textTheme, title: 'Other Products'),
            Gap(20.h),
            CommonProductGrid(
              products: [
                ProductModel(
                  name: 'Ddemo',
                  image: AppAssets.appLogo,
                  price: 200,
                  rating: 4.5,
                ),
                ProductModel(
                  name: 'Ddemo',
                  image: AppAssets.appLogo,
                  price: 200,
                  rating: 4.5,
                ),
                ProductModel(
                  name: 'Ddemo',
                  image: AppAssets.appLogo,
                  price: 200,
                  rating: 4.5,
                ),
                ProductModel(
                  name: 'Ddemo',
                  image: AppAssets.appLogo,
                  price: 200,
                  rating: 4.5,
                ),
                ProductModel(
                  name: 'Ddemo',
                  image: AppAssets.appLogo,
                  price: 200,
                  rating: 4.5,
                ),
              ],
              onTap: () {
                context.pushNamed(Routes.productDetailScreen.name);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTitleText({
    required TextTheme textTheme,
    required String title,
  }) {
    return Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: .w500));
  }
}
