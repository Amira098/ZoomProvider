class SuspendOrderModel {
  final bool? status;
  final Message? message;
  final dynamic payload;

  SuspendOrderModel({
    this.status,
    this.message,
    this.payload,
  });

  factory SuspendOrderModel.fromJson(Map<String, dynamic> json) {
    return SuspendOrderModel(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? Message.fromJson(json['message'])
          : null,
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'payload': payload,
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
      ar: json['ar'] as String?,
      en: json['en'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}