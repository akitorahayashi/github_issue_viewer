// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:github_issues_viewer/view/Issues_dashboard/issues_list/issue_row.dart';
// import '../../../model/giv_issues/issues_provider.dart';

// class IssuesList extends ConsumerStatefulWidget {
//   final String? label;

//   const IssuesList({super.key, required this.label});

//   @override
//   ConsumerState<IssuesList> createState() => _IssuesListState();
// }

// class _IssuesListState extends ConsumerState<IssuesList> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(issuesProvider.notifier).fetchIssues(
//             owner: 'akitorahayashi',
//             name: 'today_list',
//             label: widget.label,
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final issuesState = ref.watch(issuesProvider);

//     return issuesState.when(
//       data: (issues) => ListView.builder(
//         itemCount: issues.length,
//         itemBuilder: (context, index) {
//           final issue = issues[index];
//           return IssueRow(gvIssue: issue);
//         },
//       ),
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stack) => Center(
//         child: Text(
//           'Error: ${error.toString()}',
//           style: const TextStyle(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }
