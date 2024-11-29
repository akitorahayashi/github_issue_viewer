import 'package:flutter/material.dart';
import 'package:github_issues_viewer/view/issues_list/issues_list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Issues Viewer'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: '全て'),
              Tab(text: 'p: webview'),
              Tab(text: 'p: shared_preferences'),
              Tab(text: 'waiting for customer response'),
              Tab(text: 'severe: new feature'),
              Tab(text: 'p: share'),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: TabBarView(
            children: [
              IssuesList(label: ''),
              IssuesList(label: 'p: webview'),
              IssuesList(label: 'p: shared_preferences'),
              IssuesList(label: 'waiting for customer response'),
              IssuesList(label: 'severe: new feature'),
              IssuesList(label: 'p: share'),
            ],
          ),
        ),
      ),
    );
  }
}
