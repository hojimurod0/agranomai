import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'agronom_ai.g.dart';

@JsonSerializable()
class AgronomAi {
  @JsonKey(name: "data")
  final Data? data;

  AgronomAi({this.data});

  factory AgronomAi.fromJson(Map<String, dynamic> json) =>
      _$AgronomAiFromJson(json);

  Map<String, dynamic> toJson() => _$AgronomAiToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "type")
  final Type? type;
  @JsonKey(name: "confidence")
  final double? confidence;
  @JsonKey(name: "created_at")
  final String? createdAt;

  Data({this.image, this.type, this.confidence, this.createdAt});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "id")
  final int? typeId;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "name_uz")
  final String? nameUz;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "images")
  final List<dynamic>? images;

  Type({
    this.id,
    this.typeId,
    this.name,
    this.nameUz,
    this.description,
    this.images,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
