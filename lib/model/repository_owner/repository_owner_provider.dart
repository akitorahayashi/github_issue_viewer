import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';
import 'repository_owner.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// プロバイダー
final repositoryOwnerProvider =
    StateNotifierProvider<RepositoryOwnerNotifier, RepositoryOwnerState>(
  (ref) => RepositoryOwnerNotifier(),
);

class RepositoryOwnerNotifier extends StateNotifier<RepositoryOwnerState> {
  RepositoryOwnerNotifier() : super(RepositoryOwnerState()) {
    _loadLoginFromPrefs();
  }

  Future<void> _loadLoginFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('ownerLogin');
    if (login != null) {
      await fetchOwnerData(login);
    } else {
      // ログイン情報がない場合は、ローディング終了
      state = state.copyWith(owner: null, isLoading: false);
    }
  }

  Future<void> _saveLoginToPrefs(String login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ownerLogin', login);
  }

  Future<void> _removeLoginFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ownerLogin');
  }

  // データを取得して状態を更新する
  Future<void> fetchOwnerData(String ownerLogin) async {
    try {
      final String token = GIVGraphqlClient.token ?? '';
      if (token.isEmpty) {
        throw Exception('GitHub Personal Access Token が指定されていません。');
      }

      final graphQLClient = GraphQLClient(
        link: HttpLink(GIVGraphqlClient.apiEndpoint,
            defaultHeaders: {'Authorization': 'Bearer $token'}),
        cache: GraphQLCache(store: InMemoryStore()),
      );

      const query = '''
    query(\$login: String!) {
      user(login: \$login) {
        name
        id
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
          QueryOptions(document: gql(query), variables: {'login': ownerLogin}));

      if (result.hasException) {
        throw Exception('Failed to fetch data: ${result.exception.toString()}');
      }

      final owner = RepositoryOwner.fromJson({'user': result.data!['user']});
      state = state.copyWith(owner: owner, isLoading: false);

      // ログイン情報をSharedPreferencesに保存
      _saveLoginToPrefs(ownerLogin);
    } catch (e) {
      print('Failed to fetch RepositoryOwner: $e');
      state = state.copyWith(owner: null, isLoading: false);
      _removeLoginFromPrefs();
    }
  }

  Future<void> logout() async {
    state = state.copyWith(owner: null, isLoading: false);
    _removeLoginFromPrefs();
  }
}
