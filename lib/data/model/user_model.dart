class UserModel {
  final String docId;
  final String email;
  final String fullName;

  UserModel({
    required this.fullName,
    required this.docId,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["full_name"] as String? ?? "",
      docId: json["doc_id"] as String? ?? "",
      email: json["user_email"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "doc_id": docId,
      "user_email": email,
    };
  }

  factory UserModel.initial() {
    return UserModel(
      fullName: "",
      docId: "",
      email: "",
    );
  }

  UserModel copyWith({
    String? docId,
    String? email,
    String? fullName,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      docId: docId ?? this.docId,
      email: email ?? this.email,
    );
  }
}
