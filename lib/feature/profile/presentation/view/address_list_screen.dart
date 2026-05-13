import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import '../provider/address_provider.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().fetchAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Address",
        showAction: true,
        actionIcon: AppAssets.heartIcon, // Heart icon as seen in the image (maybe for wishlist?)
      ),
      body: Consumer<AddressProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, size: 80.sp, color: AppTheme.greyColor),
                  Gap(16.h),
                  Text("No addresses found", style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(20.r),
            itemCount: provider.addresses.length,
            separatorBuilder: (context, index) => Gap(16.h),
            itemBuilder: (context, index) {
              final address = provider.addresses[index];
              return Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppTheme.greyLightColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.location_on, color: Colors.white),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            address.addressDetails,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () {
                        // Navigate to edit address
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: CommonButton(
          text: "Add New Address",
          onTap: () {
             context.pushNamed(Routes.addLocationScreen.name);
          },
          borderRadius: 30.r,
          height: 55.h,
        ),
      ),
    );
  }
}
