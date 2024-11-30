import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/gv_issue.dart';

class IssueRow extends StatefulWidget {
  final GVIssue gvIssue;
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
      subtitle: _shouldShowDetail ? Text(widget.gvIssue.title) : null,
      onTap: () {
        // Issue詳細画面への遷移を実装可能
        setState(() {
          _shouldShowDetail = !_shouldShowDetail;
        });
      },
    );
  }
}
