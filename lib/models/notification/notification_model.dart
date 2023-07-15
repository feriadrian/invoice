class NotificationData {
  Null? error;
  List<Data>? data;

  NotificationData({this.error, this.data});

  NotificationData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? invoiceId;
  String? notificationType;
  String? title;
  String? content;
  bool? isRead;
  String? createdAt;

  Data(
      {this.id,
      this.invoiceId,
      this.notificationType,
      this.title,
      this.content,
      this.isRead,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    notificationType = json['notification_type'];
    title = json['title'];
    content = json['content'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['notification_type'] = this.notificationType;
    data['title'] = this.title;
    data['content'] = this.content;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    return data;
  }
}

