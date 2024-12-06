// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'giv_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GIVRepositoryImpl _$$GIVRepositoryImplFromJson(Map<String, dynamic> json) =>
    _$GIVRepositoryImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      updatedAt: json['updatedAt'] as String,
      primaryLanguage: json['primaryLanguage'] as String?,
    );

Map<String, dynamic> _$$GIVRepositoryImplToJson(_$GIVRepositoryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'updatedAt': instance.updatedAt,
      'primaryLanguage': instance.primaryLanguage,
    };
