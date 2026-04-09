class RequestsDetailsModel {
  bool? status;
  MessageModel? message;
  OrderModel? data;

  RequestsDetailsModel({this.status, this.message, this.data});

  RequestsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
    json['message'] != null ? MessageModel.fromJson(json['message']) : null;
    data = json['data'] != null ? OrderModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'data': data?.toJson(),
    };
  }
}

class MessageModel {
  String? ar;
  String? en;

  MessageModel({this.ar, this.en});

  MessageModel.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}

class OrderModel {
  int? id;
  List<ProductModel>? products;
  StatusModel? status;
  int? code;
  String? createdAt;
  String? latitude;
  String? longitude;
  String? address;
  String? customer;
  String? customerNotes;
  String? customerDate;
  bool? hasInvoice;

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

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if (json['products'] != null) {
      products = (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }

    status =
    json['status'] != null ? StatusModel.fromJson(json['status']) : null;

    code = json['code'];
    createdAt = json['created_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    customer = json['customer'];
    customerNotes = json['customer_notes'];
    customerDate = json['customer_date'];
    hasInvoice = json['has_invoice'];
  }

  Map<String, dynamic> toJson() {
    return {
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
}

class ProductModel {
  int? id;
  String? name;
  String? type;
  int? quantity;
  dynamic warehouse;
  String? image;

  ProductModel({
    this.id,
    this.name,
    this.type,
    this.quantity,
    this.warehouse,
    this.image,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    quantity = json['quantity'];
    warehouse = json['warehouse'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'warehouse': warehouse,
      'image': image,
    };
  }
}

class StatusModel {
  String? label;
  String? value;

  StatusModel({this.label, this.value});

  StatusModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}