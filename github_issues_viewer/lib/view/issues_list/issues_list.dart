import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/view/issues_list/issue_row.dart';
import '../../provider/issues_provider.dart';

class IssuesList extends ConsumerWidget {
  final String label;

  const IssuesList({super.key, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issues = ref.watch(issuesProvider(label));

    return issues.when(
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final issue = data[index];
          return IssueRow(gvIssue: issue);
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
