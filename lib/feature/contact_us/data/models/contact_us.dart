class ContactModel {
  final bool? status;
  final Message? message;

  ContactModel({
    this.status,
    this.message,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      status: json['status'] as bool?,
      message: Message.fromJson(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
    };
  }
}

class Message {
  final String? ar;
  final String? en;

  Message({this.ar, this.en});

  factory Message.fromJson(dynamic json) {
    /// لو message جاية String
    if (json is String) {
      return Message(ar: json, en: json);
    }

    /// لو message جاية Object
    if (json is Map<String, dynamic>) {
      return Message(
        ar: json['ar'] as String?,
        en: json['en'] as String?,
      );
    }

    return Message();
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}
