import 'package:furniture_app/core/constant/app_imports.dart';

class BottomNavigationBarView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationBarView({super.key, required this.navigationShell});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 24.h,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        onTap: _onTap,
        currentIndex: widget.navigationShell.currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            label: 'Home',
            icon: SvgPicture.asset(
              AppAssets.homeIcon,
              width: 24.h,
              height: 24.h,
            ),
          ),
          BottomNavigationBarItem(
            label: 'cart',
            icon: SvgPicture.asset(
              AppAssets.cartIcon,
              width: 24.h,
              height: 24.h,
            ),
          ),
          BottomNavigationBarItem(
            label: 'order',
            icon: SvgPicture.asset(
              AppAssets.orderIcon,
              width: 24.h,
              height: 24.h,
            ),
          ),
          BottomNavigationBarItem(
            label: 'profile',
            icon: SvgPicture.asset(
              AppAssets.profileIcon,
              width: 24.h,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}
