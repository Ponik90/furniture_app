import 'package:flutter/material.dart';
import 'package:furniture_app/feature/home/data/model/product_model.dart';

class SearchProvider extends ChangeNotifier {
  List<String> recentSearches = [
    'Chair',
    'Marble flower vase',
    'Bedroom Lamp',
    'Wooden chair',
    'Kitchen tool',
    'Sofa'
  ];

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  List<ProductModel> allProducts = []; // This should be populated from HomeProvider or Firestore
  List<ProductModel> filteredProducts = [];

  String selectedCategory = "All";
  String selectedSort = "Popular";
  double selectedRating = 0;

  void updateSearchQuery(String query, List<ProductModel> products) {
    _searchQuery = query;
    allProducts = products;
    if (query.isEmpty) {
      filteredProducts = [];
    } else {
      _applyFilters();
    }
    notifyListeners();
  }

  void setFilters({String? category, String? sort, double? rating}) {
    if (category != null) selectedCategory = category;
    if (sort != null) selectedSort = sort;
    if (rating != null) selectedRating = rating;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    filteredProducts = allProducts.where((product) {
      final matchesQuery = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || product.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesRating = selectedRating == 0 || product.rating >= selectedRating;
      return matchesQuery && matchesCategory && matchesRating;
    }).toList();

    if (selectedSort == "Price High") {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedSort == "Price Low") {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    }
  }

  void addRecentSearch(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 10) recentSearches.removeLast();
      notifyListeners();
    }
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
    notifyListeners();
  }

  void clearAllRecent() {
    recentSearches.clear();
    notifyListeners();
  }

  void resetFilters() {
    selectedCategory = "All";
    selectedSort = "Popular";
    selectedRating = 0;
    _applyFilters();
    notifyListeners();
  }
}
