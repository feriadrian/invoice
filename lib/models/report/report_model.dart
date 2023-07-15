class ReportModel {
  int? transactionQuantity;
  int? transactionTotal;

  ReportModel({this.transactionQuantity, this.transactionTotal});

  ReportModel.fromJson(Map<String, dynamic> json) {
    transactionQuantity = json["transaction_quantity"];
    transactionTotal = json["transaction_total"];
  }
}
