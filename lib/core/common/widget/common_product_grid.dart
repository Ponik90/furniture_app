import 'package:furniture_app/core/common/widget/common_product_card.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';

import '../../constant/app_imports.dart';

class CommonProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final Function() onTap;

  const CommonProductGrid({super.key, required this.products, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 250.h,
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return CommonProductCard(
          product: product,
          onTap: onTap,
          onAddToCart: () {},
          onFavTap: () {},
        );
      },
    );
  }
}
