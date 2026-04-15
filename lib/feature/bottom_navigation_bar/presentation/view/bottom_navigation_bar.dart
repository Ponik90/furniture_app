import 'package:furniture_app/core/constant/app_imports.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.notificationIcon),
          ),
        ],
      ),
    );
  }
}
