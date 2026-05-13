import 'package:furniture_app/core/constant/app_imports.dart';
import '../../provider/search_provider.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
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
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Text("Filter", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              Gap(30.h),
              
              Text("Categories", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Gap(12.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["All", "Sofa", "Chair", "Table", "Kitchen", "Bed"].map((cat) {
                    final isSelected = provider.selectedCategory == cat;
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (selected) {
                          provider.setFilters(category: cat);
                        },
                        selectedColor: AppTheme.primaryColor,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Gap(24.h),
              
              Text("Sort by", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Gap(12.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["Popular", "Most Popular", "Price High", "Price Low"].map((sort) {
                    final isSelected = provider.selectedSort == sort;
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ChoiceChip(
                        label: Text(sort),
                        selected: isSelected,
                        onSelected: (selected) {
                          provider.setFilters(sort: sort);
                        },
                        selectedColor: AppTheme.primaryColor,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Gap(24.h),
              
              Text("Rating", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Gap(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [0.0, 1.0, 2.0, 3.0, 4.0].map((rating) {
                  final isSelected = provider.selectedRating == rating;
                  return GestureDetector(
                    onTap: () => provider.setFilters(rating: rating),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: isSelected ? Colors.white : Colors.amber, size: 16),
                          Gap(4.w),
                          Text(
                            rating == 0 ? "All" : rating.toInt().toString(),
                            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              Gap(40.h),
              
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: "Reset",
                      onTap: () => provider.resetFilters(),
                      backgroundColor: Colors.grey[200],
                      textColor: Colors.black,
                      borderRadius: 30.r,
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: CommonButton(
                      text: "Apply",
                      onTap: () => Navigator.pop(context),
                      borderRadius: 30.r,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
