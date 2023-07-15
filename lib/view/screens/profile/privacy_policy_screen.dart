import 'package:flutter/material.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/method_helper.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MethodHelper.buildAppBar(context, ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Privacy Policy',
              style: heading1.copyWith(color: blackTextColor),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'POLICY & PRIVACY (LANGUAGE)',
              style: heading5.copyWith(color: blackTextColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Collection and Use of Personal Data',
              style: heading7.copyWith(color: blackTextColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Personal data is information that relates directly or indirectly to you, which is identified or can be identified from that information or from other information and information. Transactions and dealings with BSC, you may be asked to provide your personal data from time to time. BSC and third party service providers may share Personal data with each other and use personal data consistent with this Privacy Policy. They may also combine it with other information to provide and improve BSC products and services',
              style: paragraph4.copyWith(color: blackTextColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Retention of Personal Information  ',
              style: heading7.copyWith(color: blackTextColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ' Your Personal Information will only be retained for as long as necessary to fulfill the purposes for which it was collected, or as long as such retention is required or permitted by Applicable Laws. We will stop saving',
              style: paragraph4.copyWith(color: blackTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
