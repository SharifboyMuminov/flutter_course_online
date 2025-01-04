class CategoryModel {
  final String imageUrl;
  final String title;
  final String categoryId;

  CategoryModel({
    required this.imageUrl,
    required this.title,
    required this.categoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      imageUrl: json["imageUrl"] as String? ?? "",
      title: json["title"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
    );
  }

  CategoryModel copyWith({
    String? imageUrl,
    String? title,
    String? categoryId,
  }) {
    return CategoryModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category_id": categoryId,
      "imageUrl": imageUrl,
      "title": title,
    };
  }
}
