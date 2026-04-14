import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardingProvider>(
        builder: (context, onBoardingProvider, child) {
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 1.5,
                child: PageView.builder(
                  controller: onBoardingProvider.pageController,
                  onPageChanged: (value) {
                    onBoardingProvider.changeCurrentIndex(value);
                  },
                  itemCount: onBoardingProvider.onBoardingList.length,
                  scrollDirection: .horizontal,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      onBoardingProvider.onBoardingList[index]['image'],
                      fit: .cover,
                    );
                  },
                ),
              ),
              Container(
                padding: .all(20.r),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Text(
                      onBoardingProvider.onBoardingList[onBoardingProvider
                          .currentIndex]['title'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.blackColor,
                        fontSize: 20.sp,
                        fontWeight: .w500,
                      ),
                      textAlign: .center,
                    ),
                    Gap(24.h),
                    Row(
                      mainAxisSize: .min,
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .center,
                      spacing: 10.w,
                      children: List.generate(
                        onBoardingProvider.onBoardingList.length,
                        (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: 8.h,
                            width: onBoardingProvider.currentIndex == index
                                ? 24.w
                                : 8.h,
                            decoration: BoxDecoration(
                              color: onBoardingProvider.currentIndex == index
                                  ? AppTheme.primaryColor
                                  : AppTheme.greyColor,
                              borderRadius: .circular(6),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: .only(
          top: 10.h,
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
        child: Row(
          spacing: 20.w,
          children: [
            Expanded(
              child: CommonButton(
                text: AppString.skip,
                onTap: () {
                  context.goNamed(Routes.welcomeScreen.name);
                },
                borderRadius: 16.r,
                backgroundColor: AppTheme.greyLightColor,
                textColor: AppTheme.blackColor,
              ),
            ),
            Expanded(
              child: CommonButton(
                text: AppString.next,
                onTap: () {
                  final provider = Provider.of<OnBoardingProvider>(
                    context,
                    listen: false,
                  );
                  provider.nextPage();
                },
                borderRadius: 16.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
