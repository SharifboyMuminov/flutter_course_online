class UserModel {
  final String docId;
  final String phoneNumber;
  final String password;

  UserModel({
    required this.password,
    required this.docId,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json["password"] as String? ?? "",
      docId: json["doc_id"] as String? ?? "",
      phoneNumber: json["phone_number"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "doc_id": docId,
      "phone_number": phoneNumber,
    };
  }

  factory UserModel.initial() {
    return UserModel(
      password: "",
      docId: "",
      phoneNumber: "",
    );
  }

  UserModel copyWith({
    String? docId,
    String? phoneNumber,
    String? password,
  }) {
    return UserModel(
      password: password ?? this.password,
      docId: docId ?? this.docId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
