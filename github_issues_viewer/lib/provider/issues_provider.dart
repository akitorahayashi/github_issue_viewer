import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/gv_issue.dart';
import '../model/gv_graphql_client.dart';

final issuesProvider =
    FutureProvider.family<List<GvIssue>, String>((ref, label) async {
  final githubService = GVGraphqlClient();
  return githubService.fetchIssues(label);
});
