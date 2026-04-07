class RequestsDetailsModel {
  bool? status;
  Message? message;
  Data? data;

  RequestsDetailsModel({this.status, this.message, this.data});

  RequestsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Message {
  String? ar;
  String? en;

  Message({this.ar, this.en});

  Message.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}

class Data {
  int? id;
  List<Products>? products;
  Status? status;
  int? code;
  String? createdAt;
  Null? latitude;
  Null? longitude;
  Null? address;
  String? customer;
  Null? customerNotes;
  String? customerDate;
  bool? hasInvoice;

  Data(
      {this.id,
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
        this.hasInvoice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['customer'] = this.customer;
    data['customer_notes'] = this.customerNotes;
    data['customer_date'] = this.customerDate;
    data['has_invoice'] = this.hasInvoice;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? type;
  int? quantity;
  Null? warehouse;
  String? image;

  Products(
      {this.id,
        this.name,
        this.type,
        this.quantity,
        this.warehouse,
        this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    quantity = json['quantity'];
    warehouse = json['warehouse'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['warehouse'] = this.warehouse;
    data['image'] = this.image;
    return data;
  }
}

class Status {
  String? label;
  String? value;

  Status({this.label, this.value});

  Status.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}
