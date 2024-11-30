import 'package:flutter/material.dart';
import 'package:github_issues_viewer/view/home_page/home_page.dart';

class GithubIssuesViewerApp extends StatelessWidget {
  const GithubIssuesViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Issues Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const MyHomePage(),
    );
  }
}
