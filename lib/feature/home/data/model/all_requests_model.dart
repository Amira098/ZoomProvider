import 'home_model.dart';

class AllRequestsModel {
  final bool? status;
  final MessageModel? message;
  final List<OrderModel>? data;

  AllRequestsModel({
    this.status,
    this.message,
    this.data,
  });

  factory AllRequestsModel.fromJson(Map<String, dynamic> json) {
    return AllRequestsModel(
      status: json['status'],
      message: json['message'] != null
          ? MessageModel.fromJson(json['message'])
          : null,
      data: (json['data'] as List?)
          ?.map((e) => OrderModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class OrderModel {
  final int? id;
  final List<ProductModel>? products;
  final StatusModel? status;
  final int? code;
  final String? createdAt;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? customer;
  final String? customerNotes;
  final String? customerDate;
  final bool? hasInvoice;

  OrderModel({
    this.id,
    this.products,
    this.status,
    this.code,
    this.createdAt,
    this.latitude,
    this.longitude,
    this.address,
    this.customer,
    this.customerNotes,
    this.customerDate,
    this.hasInvoice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      products: (json['products'] as List?)
          ?.map((e) => ProductModel.fromJson(e))
          .toList(),
      status: json['status'] != null
          ? StatusModel.fromJson(json['status'])
          : null,
      code: json['code'],
      createdAt: json['created_at'],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      address: json['address'],
      customer: json['customer'],
      customerNotes: json['customer_notes'],
      customerDate: json['customer_date'],
      hasInvoice: json['has_invoice'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products?.map((e) => e.toJson()).toList(),
    'status': status?.toJson(),
    'code': code,
    'created_at': createdAt,
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
    'customer': customer,
    'customer_notes': customerNotes,
    'customer_date': customerDate,
    'has_invoice': hasInvoice,
  };
}

class ProductModel {
  final int? id;
  final String? name;
  final String? type;
  final int? quantity;
  final WarehouseModel? warehouse;
  final String? image;

  ProductModel({
    this.id,
    this.name,
    this.type,
    this.quantity,
    this.warehouse,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      quantity: json['quantity'],
      warehouse: json['warehouse'] != null
          ? WarehouseModel.fromJson(json['warehouse'])
          : null,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'quantity': quantity,
    'warehouse': warehouse?.toJson(),
    'image': image,
  };
}

class WarehouseModel {
  final int? id;
  final String? name;

  WarehouseModel({this.id, this.name});

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class StatusModel {
  final String? label;
  final String? value;

  StatusModel({this.label, this.value});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      label: json['label'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'value': value,
  };
}