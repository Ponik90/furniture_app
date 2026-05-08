import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final Timestamp? createAt;
  final String? dob;
  final String? email;
  final String? id;
  final String? image;
  final String? name;
  final String? number;
  final Timestamp? updateAt;

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

  factory ProfileModel.fromJson(String str) =>
      ProfileModel.fromMap(json.decode(str));

  ProfileModel copyWith({
    Timestamp? createAt,
    String? dob,
    String? email,
    String? id,
    String? image,
    String? name,
    String? number,
    Timestamp? updateAt,
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

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
    createAt: json["create_at"],
    dob: json["dob"],
    email: json["email"],
    id: json["id"],
    image: json["image"],
    name: json["name"],
    number: json["number"],
    updateAt: json["update_at"],
  );

  Map<String, dynamic> toMap() => {
    "create_at": createAt,
    "dob": dob,
    "email": email,
    "id": id,
    "image": image,
    "name": name,
    "number": number,
    "update_at": updateAt,
  };
}
