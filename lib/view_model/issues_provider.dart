import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_graphql_client.dart';
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

    // クエリを条件で分岐
    final query = label != null
        ? GIVGraphqlClient.fetchIssuesForLabelQuery
        : GIVGraphqlClient.fetchAllIssuesQuery;

    // クエリ変数を動的に設定
    final Map<String, dynamic> variables = {
      'login': login,
      'name': name,
      if (label != null) 'label': label,
    };

    final client = ref.read(givGraphQLClientProvider);

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
