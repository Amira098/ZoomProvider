class AllRequestsModel {
  bool? status;
  Message? message;
  List<Data>? data;

  AllRequestsModel({this.status, this.message, this.data});

  AllRequestsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? address;
  String? customer;
  String? customerNotes;
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
  Warehouse? warehouse;
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
    warehouse = json['warehouse'] != null
        ? new Warehouse.fromJson(json['warehouse'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Warehouse {
  int? id;
  String? name;

  Warehouse({this.id, this.name});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
