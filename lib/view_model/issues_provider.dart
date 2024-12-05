import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/view_model/graphql_client_provider.dart';
import '../model/giv_issue.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

final issuesProvider =
    StateNotifierProvider<IssuesNotifier, AsyncValue<List<GIVIssue>>>(
  (ref) => IssuesNotifier(ref),
);

class IssuesNotifier extends StateNotifier<AsyncValue<List<GIVIssue>>> {
  IssuesNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  // ラベルの状態を管理
  AsyncValue<List<String>> labelsState = const AsyncValue.loading();

  // ラベルによってIssueを取得
  Future<void> fetchIssues({
    required String login,
    required String name,
    String? label,
  }) async {
    state = const AsyncValue.loading();

    final client = ref.read(graphQLClientProvider);

    // クエリを条件で分岐
    final query = label != null
        ? '''
          query GetIssues(\$login: String!, \$name: String!, \$label: String!) {
            repository(owner: \$login, name: \$name) {
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
                    state
                  }
                }
              }
            }
          }
        '''
        : '''
          query GetAllIssues(\$login: String!, \$name: String!) {
            repository(owner: \$login, name: \$name) {
              issues(first: 20) {
                edges {
                  node {
                    title
                    body
                    url
                    createdAt
                    author {
                      login
                    }
                    state
                  }
                }
              }
            }
          }
        ''';

    // クエリ変数を動的に設定
    final Map<String, dynamic> variables = {
      'login': login,
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
        final isClosed = node['state'] == 'CLOSED'; // Issueが閉じられているかどうかを判定
        return GIVIssue(
          title: node['title'] ?? '',
          body: node['body'] ?? '',
          url: node['url'] ?? '',
          createdAt: node['createdAt'] ?? '',
          author: node['author']['login'] ?? '',
          githubUrl: node['url'] ?? '',
          isClosed: isClosed,
        );
      }).toList());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
