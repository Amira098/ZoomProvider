import 'home_model.dart';

class RequestsDetailsModel {
  bool? status;
  MessageModel? message;
  OrderModel? data;

  RequestsDetailsModel({this.status, this.message, this.data});

  RequestsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] != null ? MessageModel.fromJson(json['message']) : null;
    data = json['data'] != null ? OrderModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
