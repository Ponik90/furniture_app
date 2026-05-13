import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/home/presentation/provider/home_provider.dart';
import '../provider/search_provider.dart';
import 'widget/filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Search",
        showAction: true,
        actionIcon: AppAssets.notificationIcon, // Placeholder for filter icon if needed, but we have search bar suffix
      ),
      body: Consumer2<SearchProvider, HomeProvider>(
        builder: (context, searchProvider, homeProvider, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonTextFormField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.grey),
                                onPressed: () {
                                  _searchController.clear();
                                  searchProvider.updateSearchQuery("", homeProvider.productList);
                                },
                              )
                            : null,
                        onChanged: (value) {
                          searchProvider.updateSearchQuery(value, homeProvider.productList);
                        },
                        onFieldSubmitted: (value) {
                          searchProvider.addRecentSearch(value);
                        },
                      ),
                    ),
                    Gap(12.w),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                          ),
                          builder: (context) => const FilterBottomSheet(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _searchController.text.isEmpty
                    ? _buildRecentSearches(searchProvider, homeProvider)
                    : _buildSearchResults(searchProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecentSearches(SearchProvider searchProvider, HomeProvider homeProvider) {
    if (searchProvider.recentSearches.isEmpty) {
      return Center(
        child: Text("Search for furniture", style: Theme.of(context).textTheme.bodyLarge),
      );
    }
    return ListView(
      padding: EdgeInsets.all(20.r),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () => searchProvider.clearAllRecent(),
              child: const Text("Clear All", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        Gap(10.h),
        ...searchProvider.recentSearches.map((query) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(query, style: TextStyle(color: Colors.grey[700])),
              trailing: IconButton(
                icon: const Icon(Icons.cancel_outlined, size: 20),
                onPressed: () => searchProvider.removeRecentSearch(query),
              ),
              onTap: () {
                _searchController.text = query;
                searchProvider.updateSearchQuery(query, homeProvider.productList);
              },
            )),
      ],
    );
  }

  Widget _buildSearchResults(SearchProvider searchProvider) {
    if (searchProvider.filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80.sp, color: Colors.grey),
            Gap(16.h),
            Text("No results found", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: EdgeInsets.all(20.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.7,
      ),
      itemCount: searchProvider.filteredProducts.length,
      itemBuilder: (context, index) {
        final product = searchProvider.filteredProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(dynamic product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(4.h),
                Row(
                  children: [
                    Text("\$${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(" ${product.rating}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
