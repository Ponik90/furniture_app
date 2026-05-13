import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import '../provider/address_provider.dart';
import '../../data/model/address_model.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Add New Address",
        showAction: true,
        actionIcon: AppAssets.heartIcon,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: NetworkImage('https://miro.medium.com/v2/resize:fit:1400/1*q69_8p276u3HqX-T2yWInw.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.location_on, color: AppTheme.primaryColor, size: 40.sp),
                ],
              ),
            ),
          ),
          
          // Address Details Bottom Sheet Style Container
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Gap(20.h),
                    Center(
                      child: Text(
                        "Address Details",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Gap(30.h),
                    Text(
                      "Name Address",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(12.h),
                    CommonTextFormField(
                      controller: _nameController,
                      hintText: "e.g. Home, Apartment",
                      isFilled: true,
                      fillColor: AppTheme.greyLightColor.withValues(alpha: 0.5),
                    ),
                    Gap(24.h),
                    Text(
                      "Address Details",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(12.h),
                    CommonTextFormField(
                      controller: _detailsController,
                      hintText: "Enter full address",
                      isFilled: true,
                      fillColor: AppTheme.greyLightColor.withValues(alpha: 0.5),
                      suffixIcon: const Icon(Icons.location_on, color: Colors.black),
                    ),
                    Gap(40.h),
                    CommonButton(
                      text: "Add",
                      onTap: () async {
                        if (_nameController.text.isNotEmpty && _detailsController.text.isNotEmpty) {
                          final address = AddressModel(
                            name: _nameController.text,
                            addressDetails: _detailsController.text,
                            latitude: 0.0, // Mocked
                            longitude: 0.0, // Mocked
                          );
                          
                          try {
                            await context.read<AddressProvider>().addAddress(address);
                            if (context.mounted) {
                              context.pop();
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }
                          }
                        }
                      },
                      borderRadius: 30.r,
                      height: 55.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
