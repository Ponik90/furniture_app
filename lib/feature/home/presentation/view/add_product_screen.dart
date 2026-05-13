import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';
import '../provider/home_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  final _ratingController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Add New Product"),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Details",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gap(20.h),
                  CommonTextFormField(
                    controller: _nameController,
                    hintText: "Product Name",
                    validator: (v) => v?.isEmpty ?? true ? "Required" : null,
                  ),
                  Gap(16.h),
                  CommonTextFormField(
                    controller: _priceController,
                    hintText: "Price",
                    keyboardType: TextInputType.number,
                    validator: (v) => v?.isEmpty ?? true ? "Required" : null,
                  ),
                  Gap(16.h),
                  CommonTextFormField(
                    controller: _categoryController,
                    hintText: "Category (e.g. Sofa, Bed)",
                    validator: (v) => v?.isEmpty ?? true ? "Required" : null,
                  ),
                  Gap(16.h),
                  CommonTextFormField(
                    controller: _imageController,
                    hintText: "Image URL",
                    validator: (v) => v?.isEmpty ?? true ? "Required" : null,
                  ),
                  Gap(16.h),
                  CommonTextFormField(
                    controller: _ratingController,
                    hintText: "Rating (0-5)",
                    keyboardType: TextInputType.number,
                    validator: (v) => v?.isEmpty ?? true ? "Required" : null,
                  ),
                  Gap(32.h),
                  CommonButton(
                    text: "Add Product",
                    isLoading: homeProvider.isSaving,
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final product = ProductModel(
                          description: ' _descriptionController.text',
                          name: _nameController.text,
                          price: double.parse(_priceController.text),
                          category: _categoryController.text,
                          image: _imageController.text,
                          rating: double.parse(_ratingController.text),
                        );

                        try {
                          await homeProvider.addProduct(product);
                          if (context.mounted) {
                            CommonSnackbar.show(
                              context: context,
                              message: "Product added successfully!",
                            );
                            context.pop();
                          }
                        } catch (e) {
                          if (context.mounted) {
                            CommonSnackbar.show(
                              context: context,
                              message: "Error: $e",
                              isError: true,
                            );
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
