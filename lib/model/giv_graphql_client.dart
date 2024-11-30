import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:github_issues_viewer/model/giv_issue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GIVGraphqlClient {
  static final String? token = dotenv.env['GITHUB_PERSONAL_ACCESS_TOKEN'];
  static const String apiEndpoint = 'https://api.github.com/graphql';

  GIVGraphqlClient() {
    if (token == null) {
      throw Exception(
          '.envから GITHUB_PERSONAL_ACCESS_TOKEN または GITHUB_GRAPHQL_API が読み取れていません');
    }
  }

  GraphQLClient getGraphQLClient() {
    final link = HttpLink(
      apiEndpoint,
      defaultHeaders: {
        'Authorization': 'Bearer $token',
      },
    );

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  Future<List<GIVIssue>> fetchIssues({
    required String owner,
    required String name,
    String? label,
  }) async {
    final client = getGraphQLClient();

    // クエリを条件で分岐
    final query = label != null
        ? '''
        query GetIssues(\$owner: String!, \$name: String!, \$label: String!) {
          repository(owner: \$owner, name: \$name) {
            issues(labels: [\$label], first: 10) {
              edges {
                node {
                  title
                  body
                  url
                }
              }
            }
          }
        }
      '''
        : '''
        query GetAllIssues(\$owner: String!, \$name: String!) {
          repository(owner: \$owner, name: \$name) {
            issues(first: 10) {
              edges {
                node {
                  title
                  body
                  url
                }
              }
            }
          }
        }
      ''';

    // クエリ変数を動的に設定
    final Map<String, dynamic> variables = {
      'owner': owner,
      'name': name,
      if (label != null) 'label': label,
    };

    final result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: variables,
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('GraphQL Exception: ${result.exception.toString()}');
    }

    // 結果をパース
    final issues = result.data!['repository']['issues']['edges'] as List;
    return issues.map((issue) {
      final node = issue['node'];
      return GIVIssue(
        title: node['title'] ?? '',
        body: node['body'] ?? '',
        url: node['url'] ?? '',
      );
    }).toList();
  }
}
