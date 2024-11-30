import 'package:graphql_flutter/graphql_flutter.dart';

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
    final repositories = userData['repositories']['nodes']
        .map<String>((repo) => repo['name'] as String)
        .toList();

    return RepositoryOwner(
      name: userData['name'] ?? 'No Name',
      id: userData['id'],
      avatarUrl: userData['avatarUrl'],
      repositories: repositories,
    );
  }

  // Fetch owner data from GitHub API using graphql_flutter
  static Future<RepositoryOwner> fetchOwnerData(
      String ownerLogin, String githubToken) async {
    final GraphQLClient client = await _initGraphQLClient(githubToken);

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
    final Map<String, dynamic> variables = {
      'login': ownerLogin,
    };

    // Send the request using GraphQLClient
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: variables,
      ),
    );

    if (result.hasException) {
      throw Exception('Failed to fetch data: ${result.exception.toString()}');
    }

    // Parse the result into RepositoryOwner object
    final data = result.data;
    return RepositoryOwner.fromJson(data!['data']);
  }

  // Initialize GraphQLClient
  static Future<GraphQLClient> _initGraphQLClient(String githubToken) async {
    final HttpLink httpLink = HttpLink(
      'https://api.github.com/graphql',
      defaultHeaders: {
        'Authorization': 'Bearer $githubToken',
      },
    );

    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}
