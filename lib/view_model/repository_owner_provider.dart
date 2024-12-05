import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';
import 'package:github_issues_viewer/model/repository_owner.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RepositoryOwnerState {
  final RepositoryOwner? owner;
  final bool isLoading;

  RepositoryOwnerState({this.owner, this.isLoading = true});

  RepositoryOwnerState copyWith({
    required RepositoryOwner? owner,
    required bool isLoading,
  }) {
    return RepositoryOwnerState(
      owner: owner,
      isLoading: isLoading,
    );
  }
}

// Provider
final repositoryOwnerProvider =
    StateNotifierProvider<RepositoryOwnerNotifier, RepositoryOwnerState>(
  (ref) => RepositoryOwnerNotifier(),
);

/// Repository Owner を管理する Notifier
class RepositoryOwnerNotifier extends StateNotifier<RepositoryOwnerState> {
  RepositoryOwnerNotifier() : super(RepositoryOwnerState()) {
    _loadLoginFromPrefs();
  }

  // SharedPreferences からログイン情報を読み込み
  Future<void> _loadLoginFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('ownerLogin');
    if (login != null) {
      await fetchOwnerData(login);
    } else {
      state = state.copyWith(owner: null, isLoading: false);
    }
  }

  // SharedPreferences にログイン情報を保存
  Future<void> _saveLoginToPrefs(String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ownerLogin', login);
  }

  // SharedPreferences からログイン情報を削除
  Future<void> _removeLoginFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ownerLogin');
  }

  // GraphQL からユーザーデータを取得
  Future<void> fetchOwnerData(String ownerLogin) async {
    try {
      final token = GIVGraphqlClient.token ?? '';
      if (token.isEmpty) {
        throw Exception('GitHub Personal Access Token が指定されていません。');
      }

      final graphQLClient = GraphQLClient(
        link: HttpLink(
          GIVGraphqlClient.apiEndpoint,
          defaultHeaders: {'Authorization': 'Bearer $token'},
        ),
        cache: GraphQLCache(store: InMemoryStore()),
      );

      const query = '''
      query(\$login: String!) {
        user(login: \$login) {
          name
          login
          avatarUrl
          repositories(first: 100, privacy: PUBLIC) {
            nodes {
              name
              description
              updatedAt
              primaryLanguage {
                name
              }
            }
          }
        }
      }
      ''';

      final result = await graphQLClient.query(
        QueryOptions(document: gql(query), variables: {'login': ownerLogin}),
      );

      if (result.hasException) {
        throw Exception('Failed to fetch data: ${result.exception.toString()}');
      }

      final owner = RepositoryOwner.fromJson({'user': result.data!['user']});
      state = state.copyWith(owner: owner, isLoading: false);

      await _saveLoginToPrefs(ownerLogin);
    } catch (e) {
      print('Failed to fetch RepositoryOwner: $e');
      state = state.copyWith(owner: null, isLoading: false);
      await _removeLoginFromPrefs();
    }
  }

  // ログアウト処理
  Future<void> logout() async {
    state = state.copyWith(owner: null, isLoading: true);
    await _removeLoginFromPrefs();
    state = state.copyWith(owner: null, isLoading: false);
  }
}
