import 'package:furniture_app/feature/home/data/model/product_model.dart';

import '../../constant/app_imports.dart';

class CommonProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onFavTap;
  final VoidCallback? onAddToCart;

  const CommonProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: .all(16.r),
            decoration: BoxDecoration(
              color: AppTheme.greyColor,
              borderRadius: .circular(10.r),
            ),
            clipBehavior: .antiAlias,
            child: Stack(
              children: [
                Image.asset(product.image),

                Align(
                  alignment: .topRight,
                  child: GestureDetector(
                    onTap: onFavTap,
                    child: SvgPicture.asset(AppAssets.heartIcon),
                  ),
                ),
              ],
            ),
          ),

          Gap(10.h),

          Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              SvgPicture.asset(AppAssets.ratingIcon, height: 12.h, width: 12.h),
              Gap(5.w),
              Text(product.rating.toString(), style: textTheme.bodySmall),
            ],
          ),

          Gap(5.h),

          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Text(
                "₹${product.price}",
                style: textTheme.bodyMedium?.copyWith(fontWeight: .w500),
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
  }
}
