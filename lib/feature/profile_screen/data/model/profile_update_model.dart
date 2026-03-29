class ProfileUpdateModel {
  bool? status;
  Message? message;
  Data? data;

  ProfileUpdateModel({this.status, this.message, this.data});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Message {
  String? ar;
  String? en;

  Message({this.ar, this.en});

  Message.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? avatar;
  String? email;
  String? pointsBalance;
  String? phone;
  String? address;
  String? latitude;
  String? longitude;
  String? pushNotificationsToken;
  String? accountType;

  Data(
      {this.id,
        this.name,
        this.avatar,
        this.email,
        this.pointsBalance,
        this.phone,
        this.address,
        this.latitude,
        this.longitude,
        this.pushNotificationsToken,
        this.accountType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    pointsBalance = json['points_balance'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pushNotificationsToken = json['push_notifications_token'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['points_balance'] = this.pointsBalance;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['push_notifications_token'] = this.pushNotificationsToken;
    data['account_type'] = this.accountType;
    return data;
  }
}
