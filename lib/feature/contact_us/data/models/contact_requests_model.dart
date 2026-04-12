class ContactRequestsModel {
  bool? status;
  Message? message;
  String? number;
  String? email;

  ContactRequestsModel({
    this.status,
    this.message,
    this.number,
    this.email,
  });

  factory ContactRequestsModel.fromJson(Map<String, dynamic> json) {
    return ContactRequestsModel(
      status: json['status'],
      message:
      json['message'] != null ? Message.fromJson(json['message']) : null,
      number: json['number'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'number': number,
      'email': email,
    };
  }
}

class Message {
  String? ar;
  String? en;

  Message({this.ar, this.en});

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