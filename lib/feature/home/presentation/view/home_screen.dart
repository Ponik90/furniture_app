import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/common/widget/common_product_card.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/home/presentation/provider/home_provider.dart';
import 'package:furniture_app/feature/home/presentation/provider/favorite_provider.dart';
import 'package:furniture_app/feature/cart/presentation/provider/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchCategories();
      context.read<HomeProvider>().fetchProducts();
      context.read<FavoriteProvider>().fetchFavorites();
      context.read<CartProvider>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(title: "Home", showLeading: false, showAction: true),

      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: MediaQuery.viewPaddingOf(context).bottom + 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(10.h),
                CommonTextFormField(
                  hintText: "Search",
                  readOnly: true,
                  prefixIcon: const Icon(Icons.search),
                  onTap: () {
                    context.pushNamed(Routes.searchScreen.name);
                  },
                ),
                Gap(24.h),
                //*Category
                commonTitleText(textTheme: textTheme, title: 'Category'),
                Gap(20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.categoryList.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 80.h,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10.h,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: AppTheme.greyColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            homeProvider.categoryList[index].icon,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ),
                        Text(
                          homeProvider.categoryList[index].name,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
                Gap(30.h),
                //*Popular Products
                commonTitleText(
                  textTheme: textTheme,
                  title: 'Popular Products',
                ),
                Gap(20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.productList.take(4).length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 250.h,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemBuilder: (context, index) {
                    final product = homeProvider.productList[index];
                    return CommonProductCard(
                      product: product,
                      onTap: () {
                        context.pushNamed(
                          Routes.productDetailScreen.name,
                          extra: product,
                        );
                      },
                      onFavTap: () {
                        context.read<FavoriteProvider>().toggleFavorite(
                          product,
                        );
                      },
                      onAddToCart: () {
                        context.read<CartProvider>().addToCart(product);
                        CommonSnackbar.show(
                          context: context,
                          message: "${product.name} added to cart!",
                        );
                      },
                    );
                  },
                ),
                Gap(30.h),
                //*Other Products
                commonTitleText(textTheme: textTheme, title: 'Other Products'),
                Gap(20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.productList.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 250.h,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemBuilder: (context, index) {
                    final product = homeProvider.productList[index];
                    return CommonProductCard(
                      product: product,
                      onTap: () {
                        context.pushNamed(
                          Routes.productDetailScreen.name,
                          extra: product,
                        );
                      },
                      onFavTap: () {
                        context.read<FavoriteProvider>().toggleFavorite(
                          product,
                        );
                      },
                      onAddToCart: () {
                        context.read<CartProvider>().addToCart(product);
                        CommonSnackbar.show(
                          context: context,
                          message: "${product.name} added to cart!",
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.addProductScreen.name);
        },

        child: Icon(Icons.add),
      ),
    );
  }

  Widget commonTitleText({
    required TextTheme textTheme,
    required String title,
  }) {
    return Text(
      title,
      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
