import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';

class ChooseBankCard extends StatelessWidget {
  const ChooseBankCard({
    Key? key,
    required this.namaBank,
    required this.icon,
    this.isNA = true,
    this.isClicked = true,
    required this.accountNumber,
  }) : super(key: key);

  final String namaBank, accountNumber;
  final String icon;
  final bool isNA, isClicked;
  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    return InkWell(
      onTap: () {
        if (!isNA || !isClicked) {
          invoiceProvider.choosePayment(
            namaBank,
            icon,
            accountNumber,
          );

          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                color: isNA ? Colors.black.withOpacity(0.20) : null,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                namaBank,
                style: paragraph4.copyWith(
                  color: isNA ? Colors.black.withOpacity(0.20) : Colors.black,
                ),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
