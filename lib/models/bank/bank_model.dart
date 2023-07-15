class BankModel {
  int? id;
  String? bankName;
  String? bankCode;
  String? onBehalfOf;
  String? bankNumber;

  BankModel(
      {this.id,
      this.bankName,
      this.bankCode,
      this.onBehalfOf,
      this.bankNumber});

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    onBehalfOf = json['on_behalf_of'];
    bankNumber = json['bank_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['on_behalf_of'] = this.onBehalfOf;
    data['bank_number'] = this.bankNumber;
    return data;
  }
}