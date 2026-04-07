import 'home_model.dart';

class AllRequestsModel {
  bool? status;
  MessageModel? message;
  List<OrderModel>? data;

  AllRequestsModel({this.status, this.message, this.data});

  AllRequestsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] != null ? MessageModel.fromJson(json['message']) : null;
    if (json['data'] != null) {
      data = <OrderModel>[];
      json['data'].forEach((v) {
        data!.add(OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
