import 'package:f_line_chart/line_chart_point.dart';
import 'package:flutter/material.dart';

enum ReportState { initial, typeBiils, rangeTime }

class ReportProvider extends ChangeNotifier {
  /// STATE PAGE
  ReportState reportState = ReportState.initial;

  /// TYPE BILLS
  final List<String> listTypeBills = ["All", "Paid", "Unpaid"];

  /// RANGE TIME
  String rangeTime = "1 Week";
  final List<String> listRangeTime = ["1 Week", "1 Month", "3 Month", "1 Year"];

  List<LineChartPoint> paidData = [
    LineChartPoint(xStr: "Mon", xValue: 1, yStr: "100", yValue: 200),
    LineChartPoint(xStr: "Tues", xValue: 2, yStr: "200", yValue: 120),
    LineChartPoint(xStr: "Wed", xValue: 3, yStr: "300", yValue: 150),
    LineChartPoint(xStr: "Thurs", xValue: 4, yStr: "400", yValue: 100),
    LineChartPoint(xStr: "Fri", xValue: 5, yStr: "400", yValue: 210),
    LineChartPoint(xStr: "Sat", xValue: 6, yStr: "400", yValue: 50),
    LineChartPoint(xStr: "Sun", xValue: 7, yStr: "300", yValue: 150),
  ];

  List<LineChartPoint> unpaidData = [
    LineChartPoint(xStr: "Mon", xValue: 1, yStr: "100", yValue: 100),
    LineChartPoint(xStr: "Tues", xValue: 2, yStr: "200", yValue: 420),
    LineChartPoint(xStr: "Wed", xValue: 3, yStr: "300", yValue: 50),
    LineChartPoint(xStr: "Thurs", xValue: 4, yStr: "400", yValue: 200),
    LineChartPoint(xStr: "Fri", xValue: 5, yStr: "400", yValue: 10),
    LineChartPoint(xStr: "Sat", xValue: 6, yStr: "400", yValue: 50),
    LineChartPoint(xStr: "Sun", xValue: 7, yStr: "300", yValue: 10),
  ];

  List<List<LineChartPoint>> initialData = [];
  
  String typeBiils = "All";

  List<Color>? chartColor() {
    if (typeBiils == "Paid") {
      return [
        Colors.green,
      ];
    } else if (typeBiils == "Unpaid") {
      return [
        Colors.red,
      ];
    } else {
      return [Colors.green, Colors.red];
    }
  }

  List<List<LineChartPoint>> data = [];

  void changeState(ReportState state) {
    switch (state) {
      case ReportState.typeBiils:
        {
          reportState = ReportState.typeBiils;
        }
        break;
      case ReportState.rangeTime:
        {
          reportState = ReportState.rangeTime;
        }

        break;
      default:
        {
          reportState = ReportState.initial;
        }
    }

    notifyListeners();
  }

  void initData() {
    data.add(paidData);
    data.add(unpaidData);
  }

  void onFilter() {
    data.clear();
    if (typeBiils == "Paid") {
      // data.clear();
      data.add(paidData);
    } else if (typeBiils == "Unpaid") {
      data.add(unpaidData);
    } else {
      data.add(paidData);
      data.add(unpaidData);
    }

    notifyListeners();
  }

  void changeTypeBiils(value) {
    typeBiils = value;
    notifyListeners();
  }

  void changeRangeTime(value) {
    rangeTime = value;
    notifyListeners();
  }

  void resetFilterAll() {
    typeBiils = "All";
    rangeTime = "1 Week";
    notifyListeners();
  }

  void resetTypeBiils() {
    typeBiils = "All";
    notifyListeners();
  }

  void resetRangeTime() {
    rangeTime = "1 Week";
    notifyListeners();
  }
}
