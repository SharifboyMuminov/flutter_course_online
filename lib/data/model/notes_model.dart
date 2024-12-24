class NotesModel {
  final String title;
  final String subTitle;

  NotesModel({
    required this.subTitle,
    required this.title,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      subTitle: json["sub_title"] as String? ?? "",
      title: json["title"] as String? ?? "",
    );
  }

  Map<String, String> toJson() {
    return {
      "title": title,
      "sub_title": subTitle,
    };
  }
}
