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
      status: json['status'] as bool?,
      message: json['message'] is Map<String, dynamic>
          ? Message.fromJson(json['message'])
          : null,
      token: json['token']?.toString(),
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
      ar: json['ar']?.toString(),
      en: json['en']?.toString(),
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
      name: json['name']?.toString(),
      avatar: json['avatar']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),

      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),

      pushNotificationsToken: json['push_notifications_token']?.toString(),
      accountType: json['account_type']?.toString(),
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

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}