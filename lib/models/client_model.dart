import 'dart:ui';

class ClientModel {
  final String id;
  final String name;
  final String shortName;
  final Color clientColor;

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
      'color': clientColor
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as String,
      name: map['name'] as String,
      shortName: map['shortName'] as String,
      clientColor: Color(map['clientColor'] as int),
    );
  }

  ClientModel copyWith({String? id, String? name}) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName,
        clientColor: clientColor
    );
  }
}
