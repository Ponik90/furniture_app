import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';
import 'package:furniture_app/feature/home/presentation/provider/favorite_provider.dart';
import 'package:furniture_app/feature/cart/presentation/provider/cart_provider.dart';
import '../../../../core/constant/app_imports.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final product = widget.product;

    return Scaffold(
      appBar: CommonAppBar(title: product.name, backgroundColor: AppTheme.greyColor),
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 2.5,
            width: double.infinity,
            decoration: BoxDecoration(color: AppTheme.greyColor),
            child: Hero(
              tag: product.id ?? product.name,
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
          ),
          Gap(15.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(8.h),
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < product.rating.floor() ? Colors.amber : Colors.grey[300],
                                    size: 20.r,
                                  );
                                }),
                                Gap(10.w),
                                Text(product.rating.toString(), style: textTheme.bodyLarge),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Consumer<FavoriteProvider>(
                        builder: (context, favProvider, child) {
                          final isFavorite = favProvider.isFavorite(product);
                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black54,
                              size: 28.r,
                            ),
                            onPressed: () => favProvider.toggleFavorite(product),
                          );
                        },
                      ),
                    ],
                  ),
                  Gap(24.h),
                  Text("Category: ${product.category}", style: textTheme.titleMedium?.copyWith(color: Colors.grey)),
                  Gap(16.h),
                  Text("Price", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Gap(8.h),
                  Text("₹${product.price}", style: textTheme.headlineSmall?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                  Gap(24.h),
                  Text("Description", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Gap(8.h),
                  Text(
                    "High-quality ${product.name} designed for comfort and style. Perfect for any modern home. Made with premium materials to ensure durability.",
                    style: textTheme.bodyLarge?.copyWith(color: Colors.grey[700], height: 1.5),
                  ),
                  Gap(100.h), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 20.r,
          right: 20.r,
          top: 20.r,
          bottom: 20.r + MediaQuery.viewPaddingOf(context).bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CommonButton(
                text: "Add to Cart",
                onTap: () {
                  context.read<CartProvider>().addToCart(product);
                  CommonSnackbar.show(context: context, message: "Added to cart!");
                },
                borderRadius: 12.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
