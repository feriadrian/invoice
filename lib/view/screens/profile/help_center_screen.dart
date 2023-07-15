import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/method_helper.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MethodHelper.buildAppBar(context, 'Help Center'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need Help?',
              style: heading1.copyWith(color: blackTextColor),
            ),
            Text(
              'Talk to us!',
              style: heading1.copyWith(color: blackTextColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(child: SvgPicture.asset(contackUs)),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Alternatively, call us on (021) 888888888 or email us Myinvoice.support@gmail.com on for futher assistance',
              style: paragraph4.copyWith(color: netralDisableColor),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffEAF0FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 43),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Call Now',
                      style: body4.copyWith(color: primaryMain),
                    )),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffEAF0FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 38),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Email Now',
                      style: body4.copyWith(color: primaryMain),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
