
class ToDoModel {
  String title;
  final String id;
  bool isComplete;
  String description;

  ToDoModel({
    required this.title,
    required this.isComplete,
    required this.id,
    this.description = "",
  });

  void toggle() {
    isComplete = !isComplete;
  }


  Map<String, dynamic> toApiMap() {
    return {
      "title": title,
      "isComplete": isComplete,
      "description": description,
    };

  }


  Map<String, dynamic> toLocalMap() {
    return {
      "_id": id,
      "title": title,
      "description": description,
      "isComplete": isComplete,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map["_id"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      isComplete: map["isComplete"] ?? true,

    );
  }
}

