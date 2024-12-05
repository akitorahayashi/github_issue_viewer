import 'package:github_issues_viewer/model/giv_repository.dart';

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

  // JSON からインスタンスを生成
  factory RepositoryOwner.fromJson(Map<String, dynamic> json) {
    // user が null の場合は例外をスロー
    final userData = json['user'];
    if (userData == null) {
      throw Exception('User data is null');
    }

    // repositories が null または欠落している場合に対応
    final repositories =
        (userData['repositories']?['nodes'] as List<dynamic>? ?? [])
            .map<GIVRepository>((repo) => GIVRepository.fromJson(repo))
            .toList();

    return RepositoryOwner(
      name: userData['name'] ?? 'No Name',
      login: userData['login'] ?? 'No Login',
      avatarUrl: userData['avatarUrl'] ?? '',
      repositories: repositories,
    );
  }
}
