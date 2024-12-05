import 'package:github_issues_viewer/view_model/graphql_client_provider.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final labelsProvider =
    StateNotifierProvider<LabelsNotifier, AsyncValue<List<String>>>((ref) {
  return LabelsNotifier(ref);
});

class LabelsNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final Ref ref;

  LabelsNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> fetchLabels(
      {required String login, required String name}) async {
    state = const AsyncValue.loading();

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
        'owner': login,
        'name': name,
      },
    );

    final client = ref.read(givGraphQLClientProvider);

    try {
      final result = await client.query(options);

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      // Map the result to a list of label names
      final labels = (result.data?['repository']['labels']['nodes'] as List)
          .map((label) => label['name'] as String)
          .toList();

      state = AsyncValue.data(labels); // 非同期操作が成功した場合、状態をデータに更新
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // 非同期操作が失敗した場合、状態をエラーに更新
    }
  }
}
