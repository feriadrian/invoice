import 'package:flutter/widgets.dart';
import 'package:myinvoice/models/home/report.dart';
import 'package:myinvoice/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  HomeReport? _homeReport;

  HomeReport? get homeReport => _homeReport;

  getHomeReport() async {
    final response = await HomeService().getReport();
    _homeReport = response;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void ontap(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  resetIndex() {
    _currentIndex = 0;
    notifyListeners();
  }
}
