import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:github_issues_viewer/model/gv_issue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GVGraphqlClient {
  final String? token = dotenv.env['GITHUB_PERSONAL_ACCESS_TOKEN'];
  final String? apiEndpoint = dotenv.env['GITHUB_GRAPHQL_API'];

  GVGraphqlClient() {
    if (token == null || apiEndpoint == null) {
      throw Exception(
          '.envから GITHUB_PERSONAL_ACCESS_TOKEN または GITHUB_GRAPHQL_API が読み取れていません');
    }
  }

  GraphQLClient getGraphQLClient() {
    final link = HttpLink(
      apiEndpoint!,
      defaultHeaders: {
        'Authorization': 'Bearer $token', // トークンを設定
      },
    );

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  Future<List<GvIssue>> fetchIssues(String label) async {
    final client = getGraphQLClient();

    // クエリ（labelをクエリ変数として渡す）
    const query = '''
      query GetIssues(\$label: String!) {
        repository(owner: "flutter", name: "flutter") {
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
    ''';

    final result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: {'label': label},
      ),
    );

    if (result.hasException) {
      throw Exception('GraphQL Exception: ${result.exception.toString()}');
    }

    // 結果をパース
    final issues = result.data!['repository']['issues']['edges'] as List;
    return issues.map((issue) {
      final node = issue['node'];
      return GvIssue(
        title: node['title'] ?? '',
        body: node['body'] ?? '',
        url: node['url'] ?? '',
      );
    }).toList();
  }
}
