import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'giv_issue.dart';
import '../giv_graphql_client.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

final issuesProvider =
    StateNotifierProvider<IssuesNotifier, AsyncValue<List<GIVIssue>>>(
  (ref) => IssuesNotifier(),
);

class IssuesNotifier extends StateNotifier<AsyncValue<List<GIVIssue>>> {
  IssuesNotifier() : super(const AsyncValue.loading());

  Future<void> fetchIssues({
    required String owner,
    required String name,
    String? label,
  }) async {
    state = const AsyncValue.loading();

    final client = GIVGraphqlClient().getGraphQLClient();

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
                    createdAt
                    author {
                      login
                    }
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
                    createdAt
                    author {
                      login
                    }
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

    try {
      // GraphQL クエリ実行
      final result = await client.query(
        QueryOptions(
          document: gql(query),
          variables: variables,
        ),
      );

      if (result.hasException) {
        throw Exception('GraphQL Exception: ${result.exception.toString()}');
      }

      // 結果をパースして状態を更新
      final issues = result.data!['repository']['issues']['edges'] as List;
      state = AsyncValue.data(issues.map((issue) {
        final node = issue['node'];
        return GIVIssue(
          title: node['title'] ?? '',
          body: node['body'] ?? '',
          url: node['url'] ?? '',
          createdAt: node['createdAt'] ?? '', // 作成日時を取得
          author: node['author']['login'] ?? '', // 作成者を取得
          githubUrl: node['url'] ?? '', // GitHubページのURL
        );
      }).toList());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
