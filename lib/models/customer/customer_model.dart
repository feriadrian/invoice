class Customer {
  int? id;
  String? fullName;
  String? email;
  String? displayProfilePictureUrl;
  String? address;

  Customer(
      {this.id,
      this.fullName,
      this.email,
      this.displayProfilePictureUrl,
      this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    displayProfilePictureUrl = json['display_profile_picture_url'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['display_profile_picture_url'] = displayProfilePictureUrl;
    data['address'] = address;
    return data;
  }
}
