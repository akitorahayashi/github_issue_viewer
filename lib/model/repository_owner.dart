import 'package:github_issues_viewer/model/giv_repository.dart';

/// Repository Owner モデル
class RepositoryOwner {
  final String name;
  final String login;
  final String avatarUrl;
  final List<GIVRepository> repositories;

  RepositoryOwner({
    required this.name,
    required this.login,
    required this.avatarUrl,
    required this.repositories,
  });

  /// JSON からインスタンスを生成
  factory RepositoryOwner.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];
    final repositories = (userData['repositories']['nodes'] as List)
        .map<GIVRepository>((repo) => GIVRepository.fromJson(repo))
        .toList();

    return RepositoryOwner(
      name: userData['name'] ?? 'No Name',
      login: userData['login'] as String,
      avatarUrl: userData['avatarUrl'] as String,
      repositories: repositories,
    );
  }
}
