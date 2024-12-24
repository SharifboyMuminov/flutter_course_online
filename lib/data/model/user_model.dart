import 'package:fire_auth/data/model/notes_model.dart';

class UserModel {
  final String docId;
  final String email;
  final String fullName;
  final List<NotesModel> userNotes;

  UserModel({
    required this.fullName,
    required this.docId,
    required this.email,
    required this.userNotes,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["full_name"] as String? ?? "",
      docId: json["doc_id"] as String? ?? "",
      email: json["user_email"] as String? ?? "",
      userNotes: (json["user_notes"] as List?)
              ?.map((value) => NotesModel.fromJson(value))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "doc_id": docId,
      "user_email": email,
      "user_notes": userNotes.map((value) => value.toJson()).toList(),
    };
  }

  factory UserModel.initial() {
    return UserModel(
      fullName: "",
      docId: "",
      email: "",
      userNotes: [],
    );
  }

  UserModel copyWith({
    String? docId,
    String? email,
    String? fullName,
    List<NotesModel>? userNotes,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      docId: docId ?? this.docId,
      email: email ?? this.email,
      userNotes: userNotes ?? this.userNotes,
    );
  }

  Map<String, dynamic> toJsonUserNotes() {
    return {"user_notes": userNotes.map((value) => value.toJson()).toList()};
  }
}
