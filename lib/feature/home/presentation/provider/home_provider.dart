import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/home/data/model/category_model.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';

import '../../../../core/services/storage_service/storage_service.dart';

class HomeProvider extends ChangeNotifier {
  final StorageService storageService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HomeProvider({required this.storageService});

  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      categoryList = snapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();
      
      // If categories are empty in Firestore, add default ones
      if (categoryList.isEmpty) {
        await _addDefaultCategories();
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  Future<void> _addDefaultCategories() async {
    final defaults = [
      CategoryModel(icon: AppAssets.sofaIcon, name: 'Sofa'),
      CategoryModel(icon: AppAssets.chairIcon, name: 'Chair'),
      CategoryModel(icon: AppAssets.lampIcon, name: 'Lamp'),
      CategoryModel(icon: AppAssets.bedIcon, name: 'Bed'),
      CategoryModel(icon: AppAssets.tableIcon, name: 'Table'),
      CategoryModel(icon: AppAssets.vaseIcon, name: 'vase'),
    ];
    for (var cat in defaults) {
      await _firestore.collection('categories').add(cat.toMap());
    }
    await fetchCategories();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('products').get();
      productList = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(ProductModel product) async {
    _isSaving = true;
    notifyListeners();

    try {
      await _firestore.collection('products').add(product.toMap());
      await fetchProducts();
    } catch (e) {
      debugPrint("Error adding product: $e");
      rethrow;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
