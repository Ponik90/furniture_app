import 'package:furniture_app/core/constant/app_imports.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  final bool showTitle;
  final bool showLeading;
  final bool showAction;

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
    this.showAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation,
      centerTitle: false,
      leadingWidth: 60.w,
      // 🔹 LEADING
      leading: showLeading
          ? Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: GestureDetector(
                onTap:
                    onLeadingTap ??
                    () {
                      context.pop();
                    },
                child:
                    leading ??
                    SvgPicture.asset(
                      AppAssets.backArrowIcon,
                      height: 24.h,
                      width: 24.h,
                    ),
              ),
            )
          : null,

      // 🔹 TITLE
      title: showTitle
          ? Text(
              title ?? "",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: .w500),
            )
          : null,

      // 🔥 ACTION (SMART LOGIC)
      actions: showAction
          ? [
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
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
