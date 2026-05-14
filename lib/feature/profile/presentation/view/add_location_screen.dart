import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng _selectedLocation = const LatLng(21.1702, 72.8311); // Default: Surat, India
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Add New Address",
        showAction: false,
      ),
      body: Column(
        children: [
          // Google Map
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 15,
                  ),
                  onMapCreated: (controller) => _mapController = controller,
                  onCameraMove: (position) {
                    _selectedLocation = position.target;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: Icon(Icons.location_on, color: AppTheme.primaryColor, size: 40.sp),
                  ),
                ),
              ],
            ),
          ),
          
          // Address Details
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
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
                      "Address Nickname",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(12.h),
                    CommonTextFormField(
                      controller: _nameController,
                      hintText: "e.g. Home, Office, Apartment",
                      isFilled: true,
                      fillColor: AppTheme.greyLightColor.withValues(alpha: 0.5),
                    ),
                    Gap(24.h),
                    Text(
                      "Full Address",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(12.h),
                    CommonTextFormField(
                      controller: _detailsController,
                      hintText: "Enter full address details",
                      isFilled: true,
                      fillColor: AppTheme.greyLightColor.withValues(alpha: 0.5),
                      suffixIcon: const Icon(Icons.location_on, color: Colors.black),
                    ),
                    Gap(40.h),
                    CommonButton(
                      text: "Save Address",
                      onTap: () async {
                        if (_nameController.text.isNotEmpty && _detailsController.text.isNotEmpty) {
                          final address = AddressModel(
                            name: _nameController.text,
                            addressDetails: _detailsController.text,
                            latitude: _selectedLocation.latitude,
                            longitude: _selectedLocation.longitude,
                          );
                          
                          try {
                            await context.read<AddressProvider>().addAddress(address);
                            if (mounted) {
                              context.pop();
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all fields")),
                          );
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
