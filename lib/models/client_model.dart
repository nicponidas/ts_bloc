class ClientModel {
  final String id;
  final String name;
  final String shortName;
  final int clientColor;

  ClientModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.clientColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'clientColor': clientColor
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as String,
      name: map['name'] as String,
      shortName: map['shortName'] as String,
      clientColor: map['clientColor'] as int,
    );
  }

  ClientModel copyWith({String? id, String? name}) {
    return ClientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        shortName: shortName,
        clientColor: clientColor);
  }
}
