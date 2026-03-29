class HomeModel {
  final bool status;
  final String message;
  final HomeData? data;

  const HomeModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data:
      json['data'] != null ? HomeData.fromJson(json['data']) : null,
    );
  }
}

class HomeData {
  final List<BannerModel> banners;
  final List<ServiceModel> services;
  final List<ProductModel> products;
  final List<BlogModel> blogs;

  const HomeData({
    required this.banners,
    required this.services,
    required this.products,
    required this.blogs,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      banners: (json['banners'] as List? ?? [])
          .map((e) => BannerModel.fromJson(e))
          .toList(),
      services: (json['services'] as List? ?? [])
          .map((e) => ServiceModel.fromJson(e))
          .toList(),
      products: (json['products'] as List? ?? [])
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      blogs: (json['blogs'] as List? ?? [])
          .map((e) => BlogModel.fromJson(e))
          .toList(),
    );
  }
}

class BannerModel {
  final int id;
  final LocalizedText? name;
  final String url;
  final String image;

  const BannerModel({
    required this.id,
    this.name,
    required this.url,
    required this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      name: json['name'] != null
          ? LocalizedText.fromJson(json['name'])
          : null,
      url: json['url'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class LocalizedText {
  final String ar;
  final String en;

  const LocalizedText({
    required this.ar,
    required this.en,
  });

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      ar: json['ar'] ?? '',
      en: json['en'] ?? '',
    );
  }
}

class ServiceModel {
  final int id;
  final LocalizedText? title;
  final LocalizedText? shortDescription;
  final String imageUrl;
  final String slug;

  const ServiceModel({
    required this.id,
    this.title,
    this.shortDescription,
    required this.imageUrl,
    required this.slug,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? LocalizedText.fromJson(json['title'])
          : null,
      shortDescription: json['short_description'] != null
          ? LocalizedText.fromJson(json['short_description'])
          : null,
      imageUrl: json['image_url'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class ProductModel {
  final int id;
  final LocalizedText? title;
  final LocalizedText? summary;
  final LocalizedText? categoryName;
  final String imageUrl;
  final String slug;

  const ProductModel({
    required this.id,
    this.title,
    this.summary,
    this.categoryName,
    required this.imageUrl,
    required this.slug,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? LocalizedText.fromJson(json['title'])
          : null,
      summary: json['summary'] != null
          ? LocalizedText.fromJson(json['summary'])
          : null,
      categoryName: json['category_name'] != null
          ? LocalizedText.fromJson(json['category_name'])
          : null,
      imageUrl: json['image_url'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class BlogModel {
  final int id;
  final LocalizedText? title;
  final LocalizedText? excerpt;
  final LocalizedText? tag;
  final String imageUrl;
  final AuthorModel? author;
  final String createdAt;

  const BlogModel({
    required this.id,
    this.title,
    this.excerpt,
    this.tag,
    required this.imageUrl,
    this.author,
    required this.createdAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? LocalizedText.fromJson(json['title'])
          : null,
      excerpt: json['excerpt'] != null
          ? LocalizedText.fromJson(json['excerpt'])
          : null,
      tag: json['tag'] != null
          ? LocalizedText.fromJson(json['tag'])
          : null,
      imageUrl: json['image_url'] ?? '',
      author: json['author'] != null
          ? AuthorModel.fromJson(json['author'])
          : null,
      createdAt: json['created_at'] ?? '',
    );
  }
}

class AuthorModel {
  final int id;
  final String name;
  final String avatar;

  const AuthorModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
