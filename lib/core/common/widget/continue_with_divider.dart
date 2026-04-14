import '../../constant/app_imports.dart';

class ContinueWithDivider extends StatelessWidget {
  const ContinueWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(child: Divider(height: 1)),
        Text(AppString.orContinueWith,style: Theme.of(context).textTheme.titleMedium,),

        Expanded(child: Divider(height: 1)),
      ],
    );
  }
}
