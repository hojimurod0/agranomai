// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agronom_ai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgronomAi _$AgronomAiFromJson(Map<String, dynamic> json) => AgronomAi(
  data:
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AgronomAiToJson(AgronomAi instance) => <String, dynamic>{
  'data': instance.data,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  image: json['image'] as String?,
  type:
      json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
  confidence: (json['confidence'] as num?)?.toDouble(),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'image': instance.image,
  'type': instance.type,
  'confidence': instance.confidence,
  'created_at': instance.createdAt,
};

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
  id: json['_id'] as String?,
  typeId: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  nameUz: json['name_uz'] as String?,
  description: json['description'] as String?,
  images: json['images'] as List<dynamic>?,
);

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
  '_id': instance.id,
  'id': instance.typeId,
  'name': instance.name,
  'name_uz': instance.nameUz,
  'description': instance.description,
  'images': instance.images,
};
