import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate/giv_repository.freezed.dart';
part 'generate/giv_repository.g.dart';

@freezed
class GIVRepository with _$GIVRepository {
  const factory GIVRepository({
    required String name,
    String? description,
    required String updatedAt,
    String? primaryLanguage,
  }) = _GIVRepository;

  factory GIVRepository.fromJson(Map<String, dynamic> json) =>
      _$GIVRepositoryFromJson(json);
}
