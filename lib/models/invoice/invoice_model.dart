class Invoice {
  int? invoiceId;
  int? merchantId;
  String? merchantName;
  String? customerName;
  int? paymentStatusId;
  String? paymentStatusName;
  int? paymentTypeId;
  String? paymentTypeName;
  int? totalPrice;
  String? dueAt;
  String? createdAt;
  String? updatedAt;

  Invoice(
      {this.invoiceId,
      this.merchantId,
      this.merchantName,
      this.customerName,
      this.paymentStatusId,
      this.paymentStatusName,
      this.paymentTypeId,
      this.paymentTypeName,
      this.totalPrice,
      this.dueAt,
      this.createdAt,
      this.updatedAt});

  Invoice.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    merchantId = json['merchant_id'];
    merchantName = json['merchant_name'];
    customerName = json['customer_name'];

    paymentStatusId = json['payment_status_id'];
    paymentStatusName = json['payment_status_name'];
    paymentTypeId = json['payment_type_id'];
    paymentTypeName = json['payment_type_name'];
    totalPrice = json['total_price'];
    dueAt = json['due_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['merchant_id'] = this.merchantId;
    data['merchant_name'] = this.merchantName;
    data['customer_name'] = this.customerName;
    data['payment_status_id'] = this.paymentStatusId;
    data['payment_status_name'] = this.paymentStatusName;
    data['payment_type_id'] = this.paymentTypeId;
    data['payment_type_name'] = this.paymentTypeName;
    data['total_price'] = this.totalPrice;
    data['due_at'] = this.dueAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
