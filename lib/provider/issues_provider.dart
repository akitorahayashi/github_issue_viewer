import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/giv_issue.dart';
import '../model/giv_graphql_client.dart';

final issuesProvider =
    FutureProvider.family<List<GIVIssue>, String?>((ref, label) async {
  final githubService = GIVGraphqlClient();
  final List<GIVIssue> issues = await githubService.fetchIssues(
      label: label, owner: "akitorahayashi", name: "today_list");
  return issues;
});
