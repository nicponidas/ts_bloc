class TaskTypeModel {
  final String id;
  final String name;

  TaskTypeModel({required this.id, required this.name});

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) {
    return TaskTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name};
}
