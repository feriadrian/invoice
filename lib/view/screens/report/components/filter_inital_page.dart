import 'package:flutter/material.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/rounded_button.dart';
import 'package:myinvoice/viewmodel/report_provider.dart';

Column filterInitialPage(BuildContext context, ReportProvider reportProvider) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Filter",
              style: heading2,
            ),
            GestureDetector(
              onTap: () => reportProvider.resetFilterAll(),
              child: Text(
                "Reset",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: netralDisableColor),
              ),
            ),
          ],
        ),
      ),
      const Divider(
        thickness: 1.5,
      ),
      ListTile(
        title: const Text("Types Bills"),
        subtitle: Text(reportProvider.typeBiils),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => reportProvider.changeState(ReportState.typeBiils),
      ),
      const Divider(
        height: 0,
        thickness: 1.5,
      ),
      ListTile(
        title: const Text("Time Range"),
        subtitle: Text(reportProvider.rangeTime),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => reportProvider.changeState(ReportState.rangeTime),
      ),
      Padding(
        padding: const EdgeInsets.all(18),
        child: RoundedButton(
            title: "Show Result",
            press: () {
              Navigator.pop(context);
              reportProvider.onFilter();
            }),
      )
    ],
  );
}
