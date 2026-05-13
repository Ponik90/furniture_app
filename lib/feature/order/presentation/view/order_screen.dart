import 'package:furniture_app/core/common/widget/common_appbar.dart';
import 'package:furniture_app/core/constant/app_imports.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "My Orders",
        showLeading: false,
        showAction: false,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppTheme.primaryColor,
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: "Ongoing"),
              Tab(text: "Completed"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(isOngoing: true),
                _buildOrderList(isOngoing: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList({required bool isOngoing}) {
    return ListView.separated(
      padding: EdgeInsets.all(20.r),
      itemCount: 3,
      separatorBuilder: (context, index) => Gap(20.h),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 80.h,
                    width: 80.h,
                    decoration: BoxDecoration(
                      color: AppTheme.greyLightColor,
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                        image: NetworkImage('https://pngimg.com/uploads/sofa/sofa_PNG6955.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Luxury Leather Sofa",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          "Qty: 1  |  Color: Black",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        Gap(8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$1500.00",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: isOngoing ? Colors.orange.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                isOngoing ? "In Delivery" : "Completed",
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: isOngoing ? Colors.orange : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              const Divider(),
              Gap(16.h),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: isOngoing ? "Track Order" : "Re-Order",
                      onTap: () {},
                      height: 40.h,
                      borderRadius: 20.r,
                      variant: isOngoing ? ButtonVariant.primary : ButtonVariant.outline,
                    ),
                  ),
                  if (!isOngoing) ...[
                    Gap(12.w),
                    Expanded(
                      child: CommonButton(
                        text: "Leave Review",
                        onTap: () {},
                        height: 40.h,
                        borderRadius: 20.r,
                        variant: ButtonVariant.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
