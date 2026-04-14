class SendResetEmail {
  bool? status;
  Message? message;
  bool? success;

  SendResetEmail({
    this.status,
    this.message,
    this.success,
  });

  factory SendResetEmail.fromJson(Map<String, dynamic> json) {
    return SendResetEmail(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? Message.fromJson(json['message'])
          : null,
      success: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'success': success,
    };
  }
}

class Message {
  String? en;
  String? ar;

  Message({
    this.en,
    this.ar,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      en: json['en'] as String?,
      ar: json['ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}