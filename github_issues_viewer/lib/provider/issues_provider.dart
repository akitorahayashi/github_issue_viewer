import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/gv_issue.dart';
import '../model/gv_graphql_client.dart';

final issuesProvider =
    FutureProvider.family<List<GVIssue>, String?>((ref, label) async {
  final githubService = GVGraphqlClient();
  final List<GVIssue> issues = await githubService.fetchIssues(label: label);
  return issues;
});
