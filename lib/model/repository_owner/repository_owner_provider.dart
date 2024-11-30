import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';
import 'repository_owner.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

// プロバイダー
final repositoryOwnerProvider =
    StateNotifierProvider<RepositoryOwnerNotifier, RepositoryOwner?>(
  (ref) => RepositoryOwnerNotifier(),
);

class RepositoryOwnerNotifier extends StateNotifier<RepositoryOwner?> {
  RepositoryOwnerNotifier() : super(null);

  // データを取得して状態を更新する
  Future<void> fetchOwnerData(String ownerLogin) async {
    try {
      final owner = await _fetchOwnerDataFromApi(ownerLogin); // データを取得
      state = owner; // 状態を更新
    } catch (e) {
      print('Failed to fetch RepositoryOwner: $e');
      state = null; // エラー時は null に戻す
      rethrow;
    }
  }

  // GitHub APIからリポジトリオーナーデータを取得するメソッド
  Future<RepositoryOwner> _fetchOwnerDataFromApi(String ownerLogin) async {
    // GIVGraphqlClientを使用してトークンとAPIエンドポイントを取得
    final String token = GIVGraphqlClient.token ?? '';
    if (token.isEmpty) {
      throw Exception('GitHub Personal Access Token が指定されていません。');
    }

    // Initialize GraphQL client using GIVGraphqlClient
    final HttpLink httpLink = HttpLink(
      GIVGraphqlClient.apiEndpoint,
      defaultHeaders: {
        'Authorization': 'Bearer $token',
      },
    );

    final GraphQLClient graphQLClient = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );

    // GraphQL query for fetching owner data and repositories
    const String query = '''
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

    // Query variables
    final Map<String, dynamic> variables = {'login': ownerLogin};

    // Send the request using GraphQLClient
    final QueryResult result = await graphQLClient.query(
      QueryOptions(
        document: gql(query),
        variables: variables,
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('Failed to fetch data: ${result.exception.toString()}');
    }

    // Parse the result into RepositoryOwner object
    final data = result.data!['user'];
    return RepositoryOwner.fromJson({'user': data});
  }
}
