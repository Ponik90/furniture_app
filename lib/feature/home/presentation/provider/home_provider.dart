import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/home/data/model/category_model.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';

import '../../../../core/services/storage_service/storage_service.dart';

class HomeProvider extends ChangeNotifier {
  final StorageService storageService;

  HomeProvider({required this.storageService});

  List<CategoryModel> categoryList = [
    CategoryModel(icon: AppAssets.sofaIcon, name: 'Sofa'),
    CategoryModel(icon: AppAssets.chairIcon, name: 'Chair'),
    CategoryModel(icon: AppAssets.lampIcon, name: 'Lamp'),
    CategoryModel(icon: AppAssets.lampIcon, name: 'Bed'),
    CategoryModel(icon: AppAssets.tableIcon, name: 'Table'),
    CategoryModel(icon: AppAssets.vaseIcon, name: 'vase'),
  ];

  List<ProductModel> productList = [
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
    ProductModel(
      name: 'leather sofa',
      image: 'https://pngimg.com/uploads/sofa/sofa_PNG6955.png',
      price: 1500,
      rating: 4.5,
      category: 'sofa',
    ),
  ];
}
