class ClientModel {
  final String id;
  final String name;

  ClientModel({required this.id, required this.name});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
  ClientModel copyWith({String? id, String? name}) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
