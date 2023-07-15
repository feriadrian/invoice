import 'package:flutter/cupertino.dart';
import 'package:myinvoice/models/bank/bank_model.dart';
import 'package:myinvoice/models/invoice_detail/invoice_detail_model.dart';

class InvoiceProvider extends ChangeNotifier {
  // page controller untuk unpaid ama paid
  int currendIndex = 0;

  int bill = 0;

  bool isloading = false;

// function supaya muncul circular pada saat nekan rounded button di confirm payment
  onPress() {
    isloading = !isloading;
    notifyListeners();
  }

  // ...

  PageController pageController = PageController();

  resetIndex() {
    currendIndex = 0;
    notifyListeners();
  }

  void changePage(int currendIndex) {
    this.currendIndex = currendIndex;

    notifyListeners();
  }

  int currentIndexPembayaran = 0;

  PageController pageControllerPembayaran = PageController();

  void changePagePembayaran(int currentIndexPembayaran) {
    this.currentIndexPembayaran = currentIndexPembayaran;

    notifyListeners();
  }

  InvoiceDetail _invoiceDetail = InvoiceDetail();

  InvoiceDetail get invoiceDetail => _invoiceDetail;

  String nameImage = '';

  resetnameImage() {
    nameImage = '';
    notifyListeners();
  }

  setInvoiceData(InvoiceDetail invoiceDetail) {
    _invoiceDetail = invoiceDetail;
  }

  String payment = 'Choose';
  String icon = '';

  String accountNumber = '';

  choosePayment(String payment, String icon, String accountNumber) {
    this.payment = payment;
    this.accountNumber = accountNumber;
    this.icon = icon;
    notifyListeners();
  }

  resetPayment() {
    payment = 'Choose';
    notifyListeners();
  }

// function untuk mengecek apakah bank tersedia atau tidak
  bool checkBakMerch(String codeBank, List<BankModel> bankModel) {
    for (var item in bankModel) {
      if (item.bankCode == codeBank) {
        return false;
      }
    }
    return true;
  }

  Future getSubTotal(int data) async {
    bill = 0;
    Future.delayed(Duration(milliseconds: 300), () {
      bill = data;
      notifyListeners();
    });
  }
}
