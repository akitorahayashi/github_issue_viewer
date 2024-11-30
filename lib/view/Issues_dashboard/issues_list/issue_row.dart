// import 'package:flutter/material.dart';
// import 'package:github_issues_viewer/model/giv_issues/giv_issue.dart';
// import 'package:github_issues_viewer/styles.dart';

// class IssueRow extends StatefulWidget {
//   final GIVIssue gvIssue;
//   const IssueRow({super.key, required this.gvIssue});

//   @override
//   State<IssueRow> createState() => _IssueRowState();
// }

// class _IssueRowState extends State<IssueRow> {
//   bool _shouldShowDetail = false;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(widget.gvIssue.title),
//       subtitle: _shouldShowDetail
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.gvIssue.body),
//                 const SizedBox(height: 8),
//                 Text('Author: ${widget.gvIssue.author}'),
//                 Text('Created at: ${formatDate(widget.gvIssue.createdAt)}'),
//                 Text(
//                   'Status: ${widget.gvIssue.isClosed ? "Closed" : "Open"}',
//                   style: TextStyle(
//                     color: widget.gvIssue.isClosed ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 Text('GitHub URL: ${widget.gvIssue.githubUrl}'),
//               ],
//             )
//           : null,
//       onTap: () {
//         setState(() {
//           _shouldShowDetail = !_shouldShowDetail;
//         });
//       },
//     );
//   }
// }
