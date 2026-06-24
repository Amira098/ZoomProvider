class CreateReservationModel {
  final bool? status;
  final ReservationMessageModel? message;
  final ReservationDataModel? data;

  CreateReservationModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateReservationModel.fromJson(Map<String, dynamic> json) {
    return CreateReservationModel(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? ReservationMessageModel.fromJson(json['message'] as Map<String, dynamic>)
          : null,
      data: json['data'] != null
          ? ReservationDataModel.fromJson(json['data'] as Map<String, dynamic>)
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

class ReservationMessageModel {
  final String? ar;
  final String? en;

  ReservationMessageModel({
    this.ar,
    this.en,
  });

  factory ReservationMessageModel.fromJson(Map<String, dynamic> json) {
    return ReservationMessageModel(
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

class ReservationDataModel {
  final int? id;
  final String? date;
  final String? time;
  final String? status;
  final String? patientName;
  final String? patientPhone;
  final String? statusLabel;
  final String? notes;

  ReservationDataModel({
    this.id,
    this.date,
    this.time,
    this.status,
    this.patientName,
    this.patientPhone,
    this.statusLabel,
    this.notes,
  });

  factory ReservationDataModel.fromJson(Map<String, dynamic> json) {
    return ReservationDataModel(
      id: json['id'] as int?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      status: json['status'] as String?,
      patientName: json['patient_name'] as String?,
      patientPhone: json['patient_phone'] as String?,
      statusLabel: json['status_label'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'status': status,
      'patient_name': patientName,
      'patient_phone': patientPhone,
      'status_label': statusLabel,
      'notes': notes,
    };
  }
}
