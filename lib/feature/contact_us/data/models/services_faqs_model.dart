class ServicesFaqsModel {
  final bool? status;
  final Message? message;
  final List<Data>? data;

  ServicesFaqsModel({this.status, this.message, this.data});

  factory ServicesFaqsModel.fromJson(Map<String, dynamic> json) {
    return ServicesFaqsModel(
      status: json['status'] as bool?,
      message: json['message'] != null ? Message.fromJson(json['message']) : null,
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((item) => Data.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class Message {
  final String? ar;
  final String? en;

  Message({this.ar, this.en});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      ar: json['ar'] as String?,
      en: json['en'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'ar': ar,
    'en': en,
  };
}

class Data {
  final String? question;
  final String? answer;

  Data({this.question, this.answer});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'answer': answer,
  };
}
