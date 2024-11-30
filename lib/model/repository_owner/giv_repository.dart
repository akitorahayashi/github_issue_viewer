import 'package:github_issues_viewer/model/giv_graphql_client.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class GIVRepository {
  final String name;
  final String? description;
  final String updatedAt;
  final String? primaryLanguage;

  GIVRepository({
    required this.name,
    this.description,
    required this.updatedAt,
    this.primaryLanguage,
  });

  factory GIVRepository.fromJson(Map<String, dynamic> json) {
    return GIVRepository(
      name: json['name'],
      description: json['description'],
      updatedAt: json['updatedAt'],
      primaryLanguage: json['primaryLanguage']
          ?['name'], // primaryLanguage is nullable
    );
  }

  Future<List<String>> fetchLabels(
      {required String login, required String name}) async {
    final client = GIVGraphqlClient.getGraphQLClient();

    // GraphQL query with placeholders for repository owner and name
    const String readLabels = """
    query(\$owner: String!, \$name: String!) {
      repository(owner: \$owner, name: \$name) {
        labels(first: 100) {
          nodes {
            name
          }
        }
      }
    }
  """;

    // QueryOptions with variable mapping
    final QueryOptions options = QueryOptions(
      document: gql(readLabels),
      variables: {
        'owner': login, // Pass the 'login' as the repository owner
        'name': name, // Pass the 'name' as the repository name
      },
    );

    try {
      final result = await client.query(options);

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      // Map the result to a list of label names
      final labels = (result.data?['repository']['labels']['nodes'] as List)
          .map((label) => label['name'] as String)
          .toList();

      return labels;
    } catch (e) {
      throw Exception('Failed to load labels: $e');
    }
  }
}
