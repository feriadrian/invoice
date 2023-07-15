class HomeReport {
  Null error;
  Data? data;

  HomeReport({this.error, this.data});

  HomeReport.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalPaid;
  int? totalUnpaid;

  Data({this.totalPaid, this.totalUnpaid});

  Data.fromJson(Map<String, dynamic> json) {
    totalPaid = json['total_paid'];
    totalUnpaid = json['total_unpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_paid'] = this.totalPaid;
    data['total_unpaid'] = this.totalUnpaid;
    return data;
  }
}
