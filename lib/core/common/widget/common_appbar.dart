import 'package:furniture_app/core/constant/app_imports.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  final bool showTitle;
  final bool showLeading;

  final Widget? leading;
  final VoidCallback? onLeadingTap;

  // 🔥 NEW (Single Action Control)
  final String? actionIcon; // svg path
  final VoidCallback? onActionTap;

  final Color? backgroundColor;
  final double elevation;

  const CommonAppBar({
    super.key,
    this.title,
    this.showTitle = true,
    this.showLeading = true,
    this.leading,
    this.onLeadingTap,
    this.actionIcon,
    this.onActionTap,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation,
      centerTitle: true,

      // 🔹 LEADING
      leading: showLeading
          ? GestureDetector(
              onTap:
                  onLeadingTap ??
                  () {
                    Navigator.pop(context);
                  },
              child:
                  leading ??
                  const Icon(Icons.arrow_back_ios, color: Colors.black),
            )
          : null,

      // 🔹 TITLE
      title: showTitle
          ? Text(title ?? "", style: Theme.of(context).textTheme.titleLarge)
          : null,

      // 🔥 ACTION (SMART LOGIC)
      actions: [
        GestureDetector(
          onTap:
              onActionTap ??
              () {
                context.pushNamed(Routes.homeScreen.name);
              },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              actionIcon ?? AppAssets.notificationIcon,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
