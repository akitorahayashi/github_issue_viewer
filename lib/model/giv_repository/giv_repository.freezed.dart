// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'giv_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GIVRepository _$GIVRepositoryFromJson(Map<String, dynamic> json) {
  return _GIVRepository.fromJson(json);
}

/// @nodoc
mixin _$GIVRepository {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String? get primaryLanguage => throw _privateConstructorUsedError;

  /// Serializes this GIVRepository to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GIVRepository
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GIVRepositoryCopyWith<GIVRepository> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GIVRepositoryCopyWith<$Res> {
  factory $GIVRepositoryCopyWith(
          GIVRepository value, $Res Function(GIVRepository) then) =
      _$GIVRepositoryCopyWithImpl<$Res, GIVRepository>;
  @useResult
  $Res call(
      {String name,
      String? description,
      String updatedAt,
      String? primaryLanguage});
}

/// @nodoc
class _$GIVRepositoryCopyWithImpl<$Res, $Val extends GIVRepository>
    implements $GIVRepositoryCopyWith<$Res> {
  _$GIVRepositoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GIVRepository
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? updatedAt = null,
    Object? primaryLanguage = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      primaryLanguage: freezed == primaryLanguage
          ? _value.primaryLanguage
          : primaryLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GIVRepositoryImplCopyWith<$Res>
    implements $GIVRepositoryCopyWith<$Res> {
  factory _$$GIVRepositoryImplCopyWith(
          _$GIVRepositoryImpl value, $Res Function(_$GIVRepositoryImpl) then) =
      __$$GIVRepositoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      String updatedAt,
      String? primaryLanguage});
}

/// @nodoc
class __$$GIVRepositoryImplCopyWithImpl<$Res>
    extends _$GIVRepositoryCopyWithImpl<$Res, _$GIVRepositoryImpl>
    implements _$$GIVRepositoryImplCopyWith<$Res> {
  __$$GIVRepositoryImplCopyWithImpl(
      _$GIVRepositoryImpl _value, $Res Function(_$GIVRepositoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of GIVRepository
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? updatedAt = null,
    Object? primaryLanguage = freezed,
  }) {
    return _then(_$GIVRepositoryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      primaryLanguage: freezed == primaryLanguage
          ? _value.primaryLanguage
          : primaryLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GIVRepositoryImpl implements _GIVRepository {
  const _$GIVRepositoryImpl(
      {required this.name,
      this.description,
      required this.updatedAt,
      this.primaryLanguage});

  factory _$GIVRepositoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GIVRepositoryImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final String updatedAt;
  @override
  final String? primaryLanguage;

  @override
  String toString() {
    return 'GIVRepository(name: $name, description: $description, updatedAt: $updatedAt, primaryLanguage: $primaryLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GIVRepositoryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.primaryLanguage, primaryLanguage) ||
                other.primaryLanguage == primaryLanguage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, updatedAt, primaryLanguage);

  /// Create a copy of GIVRepository
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GIVRepositoryImplCopyWith<_$GIVRepositoryImpl> get copyWith =>
      __$$GIVRepositoryImplCopyWithImpl<_$GIVRepositoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GIVRepositoryImplToJson(
      this,
    );
  }
}

abstract class _GIVRepository implements GIVRepository {
  const factory _GIVRepository(
      {required final String name,
      final String? description,
      required final String updatedAt,
      final String? primaryLanguage}) = _$GIVRepositoryImpl;

  factory _GIVRepository.fromJson(Map<String, dynamic> json) =
      _$GIVRepositoryImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  String get updatedAt;
  @override
  String? get primaryLanguage;

  /// Create a copy of GIVRepository
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GIVRepositoryImplCopyWith<_$GIVRepositoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
