import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import '../provider/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "My Wallet"),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          return Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Balance",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      Gap(8.h),
                      Text(
                        "\$${walletProvider.balance.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(24.h),
                      Text(
                        "**** **** **** 1234",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(40.h),
                Text(
                  "Add Balance",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(20.h),
                CommonTextFormField(
                  controller: _amountController,
                  hintText: "Enter amount",
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                Gap(32.h),
                CommonButton(
                  text: "Top Up with Razorpay",
                  isLoading: walletProvider.isProcessing,
                  onTap: () async {
                    if (_amountController.text.isNotEmpty) {
                      final amount = double.parse(_amountController.text);
                      await walletProvider.processRazorpayPayment(amount);
                      if (context.mounted) {
                        _amountController.clear();
                        CommonSnackbar.show(
                          context: context,
                          message: "Balance added successfully!",
                        );
                      }
                    }
                  },
                  borderRadius: 30.r,
                  height: 55.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
