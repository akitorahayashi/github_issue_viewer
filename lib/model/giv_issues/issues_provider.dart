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

  // ラベルの状態を管理
  AsyncValue<List<String>> labelsState = const AsyncValue.loading();

  // ラベルによってIssueを取得
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
                    state
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
                    state
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
        final isClosed = node['state'] == 'CLOSED'; // Issueが閉じられているかどうかを判定
        return GIVIssue(
          title: node['title'] ?? '',
          body: node['body'] ?? '',
          url: node['url'] ?? '',
          createdAt: node['createdAt'] ?? '',
          author: node['author']['login'] ?? '',
          githubUrl: node['url'] ?? '',
          isClosed: isClosed, // isClosedを設定
        );
      }).toList());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // ラベルを取得する関数
  Future<void> fetchLabels({
    required String owner,
    required String name,
  }) async {
    final client = GIVGraphqlClient().getGraphQLClient();

    const String query = '''
      query GetLabels(\$owner: String!, \$name: String!) {
        repository(owner: \$owner, name: \$name) {
          labels(first: 100) {
            edges {
              node {
                name
              }
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> variables = {
      'owner': owner,
      'name': name,
    };

    try {
      final result = await client.query(
        QueryOptions(
          document: gql(query),
          variables: variables,
        ),
      );

      if (result.hasException) {
        throw Exception('GraphQL Exception: ${result.exception.toString()}');
      }

      // ラベルをパースしてstateに格納
      final labels = result.data!['repository']['labels']['edges'] as List;
      labelsState = AsyncValue.data(
        labels.map((label) => label['node']['name'] as String).toList(),
      );
    } catch (e, stack) {
      labelsState = AsyncValue.error(e, stack);
    }
  }
}
