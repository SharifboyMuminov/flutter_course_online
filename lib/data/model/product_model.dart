class ProductModel {
  final String imageUrl;
  final String title;
  final String id;
  final String categoryId;
  final String adminId;
  final String about;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.categoryId,
    required this.id,
    required this.about,
    required this.adminId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imageUrl: json["imageUrl"] as String? ?? "",
      title: json["title"] as String? ?? "",
      id: json["id"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      about: json["about"] as String? ?? "",
      adminId: json["admin_id"] as String? ?? "",
    );
  }

  ProductModel copyWith({
    String? imageUrl,
    String? title,
    String? categoryId,
    String? id,
    String? about,
    String? adminId,
  }) {
    return ProductModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      id: id ?? this.id,
      about: about ?? this.about,
      adminId: adminId ?? this.adminId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_id": categoryId,
      "imageUrl": imageUrl,
      "title": title,
      "about": about,
      "admin_id": adminId,
    };
  }
}
