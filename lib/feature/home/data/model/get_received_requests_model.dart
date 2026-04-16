class GetReceivedRequestsModel {
  final bool? status;
  final MessageModel? message;
  final List<RequestData>? data;
  final PaginationLinks? links;
  final MetaModel? meta;

  const GetReceivedRequestsModel({
    this.status,
    this.message,
    this.data,
    this.links,
    this.meta,
  });

  factory GetReceivedRequestsModel.fromJson(Map<String, dynamic> json) {
    return GetReceivedRequestsModel(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? MessageModel.fromJson(json['message'] as Map<String, dynamic>)
          : null,
      data: (json['data'] as List?)
          ?.map((e) => RequestData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] != null
          ? PaginationLinks.fromJson(json['links'] as Map<String, dynamic>)
          : null,
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'data': data?.map((e) => e.toJson()).toList(),
      'links': links?.toJson(),
      'meta': meta?.toJson(),
    };
  }
}

class MessageModel {
  final String? ar;
  final String? en;

  const MessageModel({
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

class RequestData {
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

  const RequestData({
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

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      id: json['id'] as int?,
      products: (json['products'] as List?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] != null
          ? StatusModel.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      code: json['code'] as int?,
      createdAt: json['created_at'] as String?,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      address: json['address'] as String?,
      customer: json['customer'] as String?,
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
      'customer': customer,
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
  final dynamic warehouse;
  final String? image;

  const ProductModel({
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
      warehouse: json['warehouse'],
      image: json['image'] as String?,
    );
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
  final String? label;
  final String? value;

  const StatusModel({
    this.label,
    this.value,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      label: json['label']?.toString(),
      value: json['value']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

class PaginationLinks {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  const PaginationLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class MetaModel {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<MetaPageLink>? links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  const MetaModel({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] as int?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      links: (json['links'] as List?)
          ?.map((e) => MetaPageLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links?.map((e) => e.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class MetaPageLink {
  final String? url;
  final String? label;
  final int? page;
  final bool? active;

  const MetaPageLink({
    this.url,
    this.label,
    this.page,
    this.active,
  });

  factory MetaPageLink.fromJson(Map<String, dynamic> json) {
    return MetaPageLink(
      url: json['url'] as String?,
      label: json['label'] as String?,
      page: json['page'] as int?,
      active: json['active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'page': page,
      'active': active,
    };
  }
}