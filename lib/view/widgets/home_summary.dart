// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/styles/styles.dart';


class HomeSummary extends StatelessWidget {
  final int? bill;
  final String? status;
  const HomeSummary({super.key, this.bill, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 97,
      decoration: BoxDecoration(
          color: netralCardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff0E1F35).withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: const Color(0xff0E1F35).withOpacity(0.12),
              offset: const Offset(0, 1),
              blurRadius: 4,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(.5),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                bill != null
                    ? '${idrFormat.format(bill)}'
                    : '${idrFormat.format(0)}',
                style: heading4.copyWith(color: blackTextColor),
                textAlign: TextAlign.left),
            Text(
              status ?? "Status",
              style: subhead2.copyWith(
                color: status!.contains("Paid")
                    ? greenColor
                    : status!.contains("Unpaid")
                        ? redColor
                        : Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
