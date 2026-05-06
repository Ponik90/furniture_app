import 'dart:convert';

class ProfileModel {
  final DateTime? createAt;
  final DateTime? dob;
  final String? email;
  final String? id;
  final String? image;
  final String? name;
  final String? number;
  final DateTime? updateAt;

  ProfileModel({
    this.createAt,
    this.dob,
    this.email,
    this.id,
    this.image,
    this.name,
    this.number,
    this.updateAt,
  });

  ProfileModel copyWith({
    DateTime? createAt,
    DateTime? dob,
    String? email,
    String? id,
    String? image,
    String? name,
    String? number,
    DateTime? updateAt,
  }) => ProfileModel(
    createAt: createAt ?? this.createAt,
    dob: dob ?? this.dob,
    email: email ?? this.email,
    id: id ?? this.id,
    image: image ?? this.image,
    name: name ?? this.name,
    number: number ?? this.number,
    updateAt: updateAt ?? this.updateAt,
  );

  factory ProfileModel.fromJson(String str) =>
      ProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
    createAt: json["create_at"] == null
        ? null
        : DateTime.parse(json["create_at"]),
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    email: json["email"],
    id: json["id"],
    image: json["image"],
    name: json["name"],
    number: json["number"],
    updateAt: json["update_at"] == null
        ? null
        : DateTime.parse(json["update_at"]),
  );

  Map<String, dynamic> toMap() => {
    "create_at": createAt?.toIso8601String(),
    "dob":
        "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "email": email,
    "id": id,
    "image": image,
    "name": name,
    "number": number,
    "update_at": updateAt?.toIso8601String(),
  };
}
