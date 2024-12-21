import 'package:freezed_annotation/freezed_annotation.dart';
import 'giv_repository.dart';

part 'generate/repository_owner.freezed.dart';
part 'generate/repository_owner.g.dart';

@freezed
class RepositoryOwner with _$RepositoryOwner {
  const factory RepositoryOwner({
    required String name,
    required String login,
    required String avatarUrl,
    required List<GIVRepository> repositories,
  }) = _RepositoryOwner;

  factory RepositoryOwner.fromJson(Map<String, dynamic> json) =>
      _$RepositoryOwnerFromJson(json);
}
