// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository_owner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RepositoryOwner _$RepositoryOwnerFromJson(Map<String, dynamic> json) {
  return _RepositoryOwner.fromJson(json);
}

/// @nodoc
mixin _$RepositoryOwner {
  String get name => throw _privateConstructorUsedError;
  String get login => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  List<GIVRepository> get repositories => throw _privateConstructorUsedError;

  /// Serializes this RepositoryOwner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepositoryOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepositoryOwnerCopyWith<RepositoryOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepositoryOwnerCopyWith<$Res> {
  factory $RepositoryOwnerCopyWith(
          RepositoryOwner value, $Res Function(RepositoryOwner) then) =
      _$RepositoryOwnerCopyWithImpl<$Res, RepositoryOwner>;
  @useResult
  $Res call(
      {String name,
      String login,
      String avatarUrl,
      List<GIVRepository> repositories});
}

/// @nodoc
class _$RepositoryOwnerCopyWithImpl<$Res, $Val extends RepositoryOwner>
    implements $RepositoryOwnerCopyWith<$Res> {
  _$RepositoryOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepositoryOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? login = null,
    Object? avatarUrl = null,
    Object? repositories = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      repositories: null == repositories
          ? _value.repositories
          : repositories // ignore: cast_nullable_to_non_nullable
              as List<GIVRepository>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepositoryOwnerImplCopyWith<$Res>
    implements $RepositoryOwnerCopyWith<$Res> {
  factory _$$RepositoryOwnerImplCopyWith(_$RepositoryOwnerImpl value,
          $Res Function(_$RepositoryOwnerImpl) then) =
      __$$RepositoryOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String login,
      String avatarUrl,
      List<GIVRepository> repositories});
}

/// @nodoc
class __$$RepositoryOwnerImplCopyWithImpl<$Res>
    extends _$RepositoryOwnerCopyWithImpl<$Res, _$RepositoryOwnerImpl>
    implements _$$RepositoryOwnerImplCopyWith<$Res> {
  __$$RepositoryOwnerImplCopyWithImpl(
      _$RepositoryOwnerImpl _value, $Res Function(_$RepositoryOwnerImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepositoryOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? login = null,
    Object? avatarUrl = null,
    Object? repositories = null,
  }) {
    return _then(_$RepositoryOwnerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      repositories: null == repositories
          ? _value._repositories
          : repositories // ignore: cast_nullable_to_non_nullable
              as List<GIVRepository>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepositoryOwnerImpl implements _RepositoryOwner {
  const _$RepositoryOwnerImpl(
      {required this.name,
      required this.login,
      required this.avatarUrl,
      required final List<GIVRepository> repositories})
      : _repositories = repositories;

  factory _$RepositoryOwnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepositoryOwnerImplFromJson(json);

  @override
  final String name;
  @override
  final String login;
  @override
  final String avatarUrl;
  final List<GIVRepository> _repositories;
  @override
  List<GIVRepository> get repositories {
    if (_repositories is EqualUnmodifiableListView) return _repositories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_repositories);
  }

  @override
  String toString() {
    return 'RepositoryOwner(name: $name, login: $login, avatarUrl: $avatarUrl, repositories: $repositories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepositoryOwnerImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality()
                .equals(other._repositories, _repositories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, login, avatarUrl,
      const DeepCollectionEquality().hash(_repositories));

  /// Create a copy of RepositoryOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepositoryOwnerImplCopyWith<_$RepositoryOwnerImpl> get copyWith =>
      __$$RepositoryOwnerImplCopyWithImpl<_$RepositoryOwnerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepositoryOwnerImplToJson(
      this,
    );
  }
}

abstract class _RepositoryOwner implements RepositoryOwner {
  const factory _RepositoryOwner(
      {required final String name,
      required final String login,
      required final String avatarUrl,
      required final List<GIVRepository> repositories}) = _$RepositoryOwnerImpl;

  factory _RepositoryOwner.fromJson(Map<String, dynamic> json) =
      _$RepositoryOwnerImpl.fromJson;

  @override
  String get name;
  @override
  String get login;
  @override
  String get avatarUrl;
  @override
  List<GIVRepository> get repositories;

  /// Create a copy of RepositoryOwner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepositoryOwnerImplCopyWith<_$RepositoryOwnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
