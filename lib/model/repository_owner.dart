import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart'; // GIVGraphqlClientをインポート

class RepositoryOwner {
  final String name;
  final String id;
  final String avatarUrl;
  final List<String> repositories;

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
        .map<String>((repo) => repo['name'] as String)
        .toList();

    return RepositoryOwner(
      name: userData['name'] ?? 'No Name',
      id: userData['id'] as String,
      avatarUrl: userData['avatarUrl'] as String,
      repositories: repositories,
    );
  }

  // Fetch owner data from GitHub API using GIVGraphqlClient
  static Future<RepositoryOwner> fetchOwnerData({
    required String ownerLogin,
  }) async {
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

// 使用例
void main() async {
  await dotenv.load();

  try {
    final owner = await RepositoryOwner.fetchOwnerData(
      ownerLogin: 'octocat',
    );
    print('Name: ${owner.name}');
    print('Repositories: ${owner.repositories}');
  } catch (e) {
    print('Error: $e');
  }
}
