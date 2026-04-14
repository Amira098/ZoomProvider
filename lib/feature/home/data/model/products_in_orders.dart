class ProductsInOrders {
  final bool? status;
  final Message? message;
  final List<ProductData>? data;

  const ProductsInOrders({
    this.status,
    this.message,
    this.data,
  });

  factory ProductsInOrders.fromJson(Map<String, dynamic> json) {
    return ProductsInOrders(
      status: json['status'] as bool?,
      message: json['message'] != null
          ? Message.fromJson(json['message'])
          : null,
      data: json['data'] != null
          ? List<ProductData>.from(
        json['data'].map((x) => ProductData.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message?.toJson(),
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class Message {
  final String? ar;
  final String? en;

  const Message({
    this.ar,
    this.en,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
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

class ProductData {
  final int? productId;
  final String? name;
  final int? quantity;
  final String? price;
  final double? total;

  const ProductData({
    this.productId,
    this.name,
    this.quantity,
    this.price,
    this.total,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      productId: json['product_id'] as int?,
      name: json['name'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price']?.toString(),
      total: (json['total'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}