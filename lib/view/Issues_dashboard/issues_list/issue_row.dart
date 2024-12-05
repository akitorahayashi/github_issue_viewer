import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/giv_issue.dart';
import 'package:github_issues_viewer/styles.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IssueRow extends HookWidget {
  final GIVIssue gvIssue;
  const IssueRow({super.key, required this.gvIssue});

  @override
  Widget build(BuildContext context) {
    final shouldShowDetail = useState(false);

    return ListTile(
      title: Text(gvIssue.title),
      subtitle: shouldShowDetail.value
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(gvIssue.body),
                const SizedBox(height: 8),
                Text('Author: ${gvIssue.author}'),
                Text('Created at: ${formatDate(gvIssue.createdAt)}'),
                Text(
                  'Status: ${gvIssue.isClosed ? "Closed" : "Open"}',
                  style: TextStyle(
                    color: gvIssue.isClosed ? Colors.green : Colors.red,
                  ),
                ),
                Text('GitHub URL: ${gvIssue.githubUrl}'),
              ],
            )
          : null,
      onTap: () => shouldShowDetail.value = !shouldShowDetail.value,
    );
  }
}
