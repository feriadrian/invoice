class InvoiceDetail {
  int? invoiceId;
  int? merchantId;
  String? merchantName;
  int? customerId;
  String? customerName;
  String? customerAddress;
  String? approvalDocumentUrl;
  int? paymentStatusId;
  String? paymentStatusName;
  int? paymentTypeId;
  String? paymentTypeName;
  int? merchantBankId;
  int? totalPrice;
  int? productQuantity;
  String? note;
  String? message;
  String? dueAt;
  String? createdAt;
  String? updatedAt;
  List<ItemDescription>? invoiceDetail;

  InvoiceDetail(
      {this.invoiceId,
      this.merchantId,
      this.merchantName,
      this.customerId,
      this.customerName,
      this.customerAddress,
      this.approvalDocumentUrl,
      this.paymentStatusId,
      this.paymentStatusName,
      this.paymentTypeId,
      this.paymentTypeName,
      this.merchantBankId,
      this.totalPrice,
      this.productQuantity,
      this.note,
      this.message,
      this.dueAt,
      this.createdAt,
      this.updatedAt,
      this.invoiceDetail});

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    merchantId = json['merchant_id'];
    merchantName = json['merchant_name'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    if (json['approval_document_url'] != null) {
      approvalDocumentUrl = json['approval_document_url'];
    } else {
      approvalDocumentUrl = null;
    }
    paymentStatusId = json['payment_status_id'];
    paymentStatusName = json['payment_status_name'];
    if (json['payment_type_id'] != null) {
      paymentStatusId = json['payment_type_id'];
    } else {
      paymentStatusId = null;
    }
    if (json['payment_type_name'] != null) {
      paymentTypeName = json['payment_type_name'];
    } else {
      paymentTypeName = null;
    }
    if (json['merchant_bank_id'] != null) {
      merchantBankId = json['merchant_bank_id'];
    } else {
      merchantBankId = null;
    }

    totalPrice = json['total_price'];
    productQuantity = json['product_quantity'];
    note = json['note'];
    message = json['message'];
    dueAt = json['due_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['invoice_detail'] != null) {
      invoiceDetail = <ItemDescription>[];
      json['invoice_detail'].forEach((v) {
        invoiceDetail!.add(new ItemDescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['merchant_id'] = this.merchantId;
    data['merchant_name'] = this.merchantName;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['approval_document_url'] = this.approvalDocumentUrl;
    data['payment_status_id'] = this.paymentStatusId;
    data['payment_status_name'] = this.paymentStatusName;
    data['payment_type_id'] = this.paymentTypeId;
    data['payment_type_name'] = this.paymentTypeName;
    data['merchant_bank_id'] = this.merchantBankId;
    data['total_price'] = this.totalPrice;
    data['product_quantity'] = this.productQuantity;
    data['note'] = this.note;
    data['message'] = this.message;
    data['due_at'] = this.dueAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.invoiceDetail != null) {
      data['invoice_detail'] =
          this.invoiceDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDescription {
  int? invoiceDetailId;
  String? product;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;

  ItemDescription(
      {this.invoiceDetailId,
      this.product,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt});

  ItemDescription.fromJson(Map<String, dynamic> json) {
    invoiceDetailId = json['invoice_detail_id'];
    product = json['product'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_detail_id'] = this.invoiceDetailId;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
