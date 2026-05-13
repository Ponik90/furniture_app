import '../../../../core/common/widget/common_appbar.dart';
import '../../../../core/constant/app_imports.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Privacy Policy"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(16.h),
            Text(
              "Last updated: May 12, 2026",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            Gap(24.h),
            _buildSection(
              "1. Information Collection",
              "We collect information you provide directly to us when you create an account, make a purchase, or communicate with us. This may include your name, email address, phone number, and delivery address.",
            ),
            _buildSection(
              "2. How We Use Information",
              "We use the information we collect to provide, maintain, and improve our services, process your transactions, and send you technical notices and support messages.",
            ),
            _buildSection(
              "3. Data Security",
              "We take reasonable measures to help protect information about you from loss, theft, misuse, and unauthorized access, disclosure, alteration, and destruction.",
            ),
            _buildSection(
              "4. Contact Us",
              "If you have any questions about this Privacy Policy, please contact us at support@furnitureapp.com.",
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Gap(8.h),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        Gap(24.h),
      ],
    );
  }
}
