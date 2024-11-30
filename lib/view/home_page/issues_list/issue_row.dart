import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/giv_issues/giv_issue.dart';

class IssueRow extends StatefulWidget {
  final GIVIssue gvIssue;
  const IssueRow({super.key, required this.gvIssue});

  @override
  State<IssueRow> createState() => _IssueRowState();
}

class _IssueRowState extends State<IssueRow> {
  bool _shouldShowDetail = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.gvIssue.title),
      subtitle: _shouldShowDetail ? Text(widget.gvIssue.body) : null,
      onTap: () {
        setState(() {
          _shouldShowDetail = !_shouldShowDetail;
        });
      },
    );
  }
}
