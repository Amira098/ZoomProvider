// login_model.dart

class LoginModel {
  final bool? status;
  final Message? message;
  final String? token;
  final User? user;

  LoginModel({
    this.status,
    this.message,
    this.token,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message:
      json['message'] != null ? Message.fromJson(json['message']) : null,
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'token': token,
      'user': user?.toJson(),
    };
  }
}

class Message {
  final String? ar;
  final String? en;

  Message({
    this.ar,
    this.en,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      ar: json['ar'],
      en: json['en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}

class User {
  final int? id;
  final String? name;
  final String? avatar;
  final String? email;
  final String? phone;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? pushNotificationsToken;
  final String? accountType;

  User({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.pushNotificationsToken,
    this.accountType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      pushNotificationsToken: json['push_notifications_token'],
      accountType: json['account_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'email': email,
      'phone': phone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'push_notifications_token': pushNotificationsToken,
      'account_type': accountType,
    };
  }
}
