import 'package:furniture_app/core/constant/app_imports.dart';
import '../../../data/model/cart_model.dart';

class CartRemoveDialog extends StatelessWidget {
  final CartModel cartItem;
  final VoidCallback onRemove;

  const CartRemoveDialog({
    super.key,
    required this.cartItem,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Remove from Cart?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppTheme.greyLightColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      cartItem.product.image,
                      height: 60.h,
                      width: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\$${cartItem.product.price}",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: "Cancel",
                    onTap: () => context.pop(),
                    variant: ButtonVariant.ghost,
                    backgroundColor: AppTheme.greyLightColor,
                    textColor: AppTheme.blackColor,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: CommonButton(
                    text: "Yes, Remove",
                    onTap: () {
                      onRemove();
                      context.pop();
                    },
                    backgroundColor: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
