import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/home/home_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/method_helper.dart';
import 'package:myinvoice/view/widgets/rounded_button.dart';
import 'package:myinvoice/viewmodel/home_provider.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:provider/provider.dart';

class StatusPembayaranScreen extends StatelessWidget {
  const StatusPembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    return Scaffold(
      appBar: MethodHelper.buildAppBar(context, ''),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SvgPicture.asset(waitingConfirm),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Waiting for Confirmation',
                style: heading3.copyWith(color: blackTextColor),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Have a problem",
                style: subhead1.copyWith(color: blackTextColor),
              ),
              Text(
                "Call center My Invoice",
                style: subhead1.copyWith(color: blackTextColor),
              ),
              const SizedBox(
                height: 60,
              ),
              RoundedButton(
                  title: 'Back to Home',
                  press: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ), (route) => false);
                    homeProvider.resetIndex();
                    invoiceProvider.resetIndex();
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
