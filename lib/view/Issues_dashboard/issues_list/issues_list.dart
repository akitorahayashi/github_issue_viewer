import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/view/issues_dashboard/issues_list/issue_row.dart';
import 'package:github_issues_viewer/view_model/issues_provider.dart';
import 'package:github_issues_viewer/view_model/repository_owner_provider.dart';

class IssuesList extends ConsumerStatefulWidget {
  final String repositoryName;
  final String? label;

  const IssuesList({
    super.key,
    required this.repositoryName,
    required this.label,
  });

  @override
  ConsumerState<IssuesList> createState() => _IssuesListState();
}

class _IssuesListState extends ConsumerState<IssuesList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final issesNotifier = ref.read(issuesProvider.notifier);
      final owner = ref.read(repositoryOwnerProvider).owner;
      issesNotifier.fetchIssues(
        login: owner!.login,
        name: widget.repositoryName,
        label: widget.label,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final issuesState = ref.watch(issuesProvider);

    return issuesState.when(
      data: (issues) => ListView.builder(
        itemCount: issues.length,
        itemBuilder: (context, index) {
          final issue = issues[index];
          return IssueRow(gvIssue: issue);
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          'Error: ${error.toString()}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
