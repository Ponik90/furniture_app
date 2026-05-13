import 'package:cached_network_image/cached_network_image.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';
import 'package:furniture_app/feature/home/presentation/provider/favorite_provider.dart';
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
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppTheme.greyColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    height: 120.h,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Image.asset(AppAssets.appLogo, height: 100.h),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Consumer<FavoriteProvider>(
                    builder: (context, favoriteProvider, child) {
                      final isFavorite = favoriteProvider.isFavorite(product);
                      return GestureDetector(
                        onTap: onFavTap,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black54,
                          size: 24.r,
                        ),
                      );
                    },
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
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SvgPicture.asset(AppAssets.ratingIcon, height: 12.h, width: 12.h),
              Gap(5.w),
              Text(product.rating.toString(), style: textTheme.bodySmall),
            ],
          ),
          Gap(5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "₹${product.price}",
                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              CommonButton(
                text: 'Add to cart',
                onTap: onAddToCart,
                backgroundColor: AppTheme.primaryColor,
                width: 80.w,
                padding: EdgeInsets.zero,
                height: 28.h,
                textSize: 10.sp,
                textColor: Colors.white,
                borderRadius: 8.r,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
