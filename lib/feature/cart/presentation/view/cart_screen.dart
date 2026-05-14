import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import '../../../home/data/model/product_model.dart';
import '../../data/model/cart_model.dart';
import '../provider/cart_provider.dart';
import 'widget/cart_remove_dialog.dart';
import 'package:furniture_app/core/services/payment_service/razorpay_service.dart';
import 'package:furniture_app/feature/order/presentation/provider/order_provider.dart';
import 'package:furniture_app/feature/order/data/model/order_model.dart';
import 'package:furniture_app/feature/profile/presentation/provider/profile_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/address_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService(
      onSuccess: _handlePaymentSuccess,
      onFailure: _handlePaymentError,
      onExternalWallet: _handleExternalWallet,
    );
  }

  @override
  void dispose() {
    _razorpayService.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final cartProvider = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();
    
    final newOrder = OrderModel(
      items: List.from(cartProvider.items),
      totalAmount: cartProvider.total,
      orderDate: DateTime.now(),
      paymentId: response.paymentId ?? "",
    );

    final success = await orderProvider.placeOrder(newOrder);
    if (success) {
      cartProvider.clearCart();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Order placed successfully!")),
        );
        context.goNamed(Routes.orderScreen.name);
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External wallet selected: ${response.walletName}")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "My Cart", showLeading: false),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final items = cartProvider.items.isNotEmpty 
            ? cartProvider.items 
            : [
                CartModel(
                  id: "1",
                  product: ProductModel(
                    id: "p1",
                    name: "Minimalist Chair",
                    category: "Chair",
                    image: "https://images.unsplash.com/photo-1592078615290-033ee584e267?q=80&w=1000&auto=format&fit=crop",
                    price: 250.0,
                    description: "A beautiful minimalist chair.",
                    rating: 4.5,
                  ),
                  quantity: 1,
                ),
                CartModel(
                  id: "2",
                  product: ProductModel(
                    id: "p2",
                    name: "Wooden Table",
                    category: "Table",
                    image: "https://images.unsplash.com/photo-1533090161767-e6ffed986c88?q=80&w=1000&auto=format&fit=crop",
                    price: 500.0,
                    description: "A sturdy wooden table.",
                    rating: 4.8,
                  ),
                  quantity: 2,
                ),
              ];

          if (items.isEmpty) { // This will now only be empty if I explicitly set it so, but for now I have defaults
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80.sp, color: AppTheme.greyColor),
                  Gap(16.h),
                  Text("Your cart is empty", style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(20.r),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.productDetailScreen.name, extra: item.product);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              item.product.image,
                              height: 80.h,
                              width: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Gap(12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.product.name,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => CartRemoveDialog(
                                            cartItem: item,
                                            onRemove: () => cartProvider.removeFromCart(item),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.delete_outline, color: Colors.red),
                                    ),
                                  ],
                                ),
                                Text(
                                  item.product.category,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Gap(8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${item.product.price}",
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.greyLightColor,
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Row(
                                        children: [
                                          _buildQuantityAction(
                                            icon: Icons.remove,
                                            onTap: () => cartProvider.decrementQuantity(item),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                                            child: Text(
                                              "${item.quantity}",
                                              style: Theme.of(context).textTheme.titleSmall,
                                            ),
                                          ),
                                          _buildQuantityAction(
                                            icon: Icons.add,
                                            onTap: () => cartProvider.incrementQuantity(item),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                ),
              ),
              _buildCheckoutSection(cartProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuantityAction({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        child: Icon(icon, size: 18.sp),
      ),
    );
  }

  Widget _buildCheckoutSection(CartProvider cartProvider) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.r,
        right: 24.r,
        top: 24.r,
        bottom: 24.r + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceRow("Subtotal", "\$${cartProvider.subTotal.toStringAsFixed(2)}"),
          Gap(8.h),
          _buildPriceRow("Shipping Fee", "\$${cartProvider.shippingFee.toStringAsFixed(2)}"),
          Gap(12.h),
          const Divider(),
          Gap(12.h),
          _buildPriceRow(
            "Total",
            "\$${cartProvider.total.toStringAsFixed(2)}",
            isTotal: true,
          ),
          Gap(24.h),
          CommonButton(
            text: "Checkout",
            onTap: () {
              final addressProvider = context.read<AddressProvider>();
              if (addressProvider.selectedAddress == null) {
                CommonSnackbar.show(
                  context: context, 
                  message: "Please select a shipping address first",
                  isError: true,
                );
                context.pushNamed(Routes.addressListScreen.name);
                return;
              }

              final profile = context.read<ProfileProvider>().profileData;
              _razorpayService.openCheckout(
                amount: cartProvider.total,
                contact: profile.number ?? "",
                email: profile.email ?? "",
                description: "Purchase from Furniture App",
              );
            },
            borderRadius: 30.r,
            height: 55.h,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    final style = isTotal
        ? Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: isTotal ? style?.copyWith(color: AppTheme.primaryColor) : style),
      ],
    );
  }
}
