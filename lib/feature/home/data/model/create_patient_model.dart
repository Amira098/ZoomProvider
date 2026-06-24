class CreatePatientModel {
  final bool? status;
  final PatientMessageModel? message;
  final PatientDataModel? data;

  CreatePatientModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreatePatientModel.fromJson(Map<String, dynamic> json) {
    return CreatePatientModel(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? PatientMessageModel.fromJson(json['message'] as Map<String, dynamic>)
          : null,
      data: json['data'] != null
          ? PatientDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'data': data?.toJson(),
    };
  }
}

class PatientMessageModel {
  final String? ar;
  final String? en;

  PatientMessageModel({
    this.ar,
    this.en,
  });

  factory PatientMessageModel.fromJson(Map<String, dynamic> json) {
    return PatientMessageModel(
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

class PatientDataModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? createdAt;

  PatientDataModel({
    this.id,
    this.name,
    this.phone,
    this.createdAt,
  });

  factory PatientDataModel.fromJson(Map<String, dynamic> json) {
    return PatientDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'created_at': createdAt,
    };
  }
}
