class HomeModel {
  final bool? status;
  final MessageModel? message;
  final StatsModel? stats;
  final List<OrderModel>? data;

  HomeModel({
    this.status,
    this.message,
    this.stats,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? MessageModel.fromJson(json['message'] as Map<String, dynamic>)
          : null,
      stats: json['stats'] != null
          ? StatsModel.fromJson(json['stats'] as Map<String, dynamic>)
          : null,
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'stats': stats?.toJson(),
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class MessageModel {
  final String? ar;
  final String? en;

  MessageModel({
    this.ar,
    this.en,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
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

class StatsModel {
  final int? total;
  final int? canceled;
  final int? completed;
  final int? pending;

  StatsModel({
    this.total,
    this.canceled,
    this.completed,
    this.pending,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      total: json['total'] as int?,
      canceled: json['canceled'] as int?,
      completed: json['completed'] as int?,
      pending: json['pending'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'canceled': canceled,
      'completed': completed,
      'pending': pending,
    };
  }
}

class OrderModel {
  final int? id;
  final List<ProductModel>? products;
  final OrderStatusModel? status;
  final int? code;
  final String? createdAt;
  final String? latitude;
  final String? longitude;
  final String? address;
  final CustomerModel? customer;
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
      id: json['id'] as int?,
      products: json['products'] != null
          ? (json['products'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList()
          : null,
      status: json['status'] != null
          ? OrderStatusModel.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      code: json['code'] as int?,
      createdAt: json['created_at'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      customer: json['customer'] != null
          ? (json['customer'] is String
              ? CustomerModel(name: json['customer'] as String)
              : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>))
          : null,
      customerNotes: json['customer_notes'] as String?,
      customerDate: json['customer_date'] as String?,
      hasInvoice: json['has_invoice'] as bool?,
    );
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
      'customer': customer?.toJson(),
      'customer_notes': customerNotes,
      'customer_date': customerDate,
      'has_invoice': hasInvoice,
    };
  }
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
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      quantity: json['quantity'] as int?,
      warehouse: json['warehouse'] != null
          ? (json['warehouse'] is Map<String, dynamic>
              ? WarehouseModel.fromJson(json['warehouse'] as Map<String, dynamic>)
              : WarehouseModel(name: json['warehouse'].toString()))
          : null,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'warehouse': warehouse?.toJson(),
      'image': image,
    };
  }
}

class WarehouseModel {
  final int? id;
  final String? name;

  WarehouseModel({
    this.id,
    this.name,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class OrderStatusModel {
  final String? label;
  final String? value;

  OrderStatusModel({
    this.label,
    this.value,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      label: json['label'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

class CustomerModel {
  final int? id;
  final String? name;
  final String? phone;

  CustomerModel({
    this.id,
    this.name,
    this.phone,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
