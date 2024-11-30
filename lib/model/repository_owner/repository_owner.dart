import 'package:github_issues_viewer/model/repository_owner/giv_repository.dart';

class RepositoryOwner {
  final String name;
  final String id;
  final String avatarUrl;
  final List<GIVRepository> repositories; // Repositoryオブジェクトをリストで保持

  RepositoryOwner({
    required this.name,
    required this.id,
    required this.avatarUrl,
    required this.repositories,
  });

  // Factory method to create an instance from API response
  factory RepositoryOwner.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];
    final repositories = (userData['repositories']['nodes'] as List)
        .map<GIVRepository>((repo) => GIVRepository.fromJson(repo))
        .toList();

    return RepositoryOwner(
      name: userData['name'] ?? 'No Name',
      id: userData['id'] as String,
      avatarUrl: userData['avatarUrl'] as String,
      repositories: repositories,
    );
  }
}
