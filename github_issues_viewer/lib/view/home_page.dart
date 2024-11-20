import 'package:flutter/material.dart';
import 'package:github_issues_viewer/view/issues_list.dart';

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
        body: const TabBarView(
          children: [
            IssuesListScreen(label: ''),
            IssuesListScreen(label: 'p: webview'),
            IssuesListScreen(label: 'p: shared_preferences'),
            IssuesListScreen(label: 'waiting for customer response'),
            IssuesListScreen(label: 'severe: new feature'),
            IssuesListScreen(label: 'p: share'),
          ],
        ),
      ),
    );
  }
}
