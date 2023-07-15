import 'package:flutter/material.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/rounded_button.dart';
import 'package:myinvoice/viewmodel/report_provider.dart';

Column filterRangeTimePage(ReportProvider reportProvider) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => reportProvider.changeState(ReportState.initial),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [Icon(Icons.arrow_back_ios), Text("Back")],
            ),
          ),
          Text(
            "Range Time",
            style: heading2,
          ),
          GestureDetector(
            onTap: () => reportProvider.resetRangeTime(),
            child: Text(
              "Reset",
              style: TextStyle(
                  color: netralDisableColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const Divider(
        thickness: 1.5,
      ),
      Column(
        children: reportProvider.listRangeTime
            .map((e) => RadioListTile(
                  title: Text(e),
                  value: e,
                  groupValue: reportProvider.rangeTime,
                  onChanged: reportProvider.changeRangeTime,
                ))
            .toList(),
      ),
      Padding(
        padding: const EdgeInsets.all(18),
        child: RoundedButton(title: "Show Result", press: () {}),
      )
    ],
  );
}
