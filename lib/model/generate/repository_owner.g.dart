// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../repository_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryOwnerImpl _$$RepositoryOwnerImplFromJson(
        Map<String, dynamic> json) =>
    _$RepositoryOwnerImpl(
      name: json['name'] as String,
      login: json['login'] as String,
      avatarUrl: json['avatarUrl'] as String,
      repositories: (json['repositories'] as List<dynamic>)
          .map((e) => GIVRepository.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RepositoryOwnerImplToJson(
        _$RepositoryOwnerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'login': instance.login,
      'avatarUrl': instance.avatarUrl,
      'repositories': instance.repositories,
    };
