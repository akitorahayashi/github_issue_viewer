import 'package:flutter/material.dart';
import 'package:github_issues_viewer/view/home_page.dart';

class GithubIssuesViewerApp extends StatelessWidget {
  const GithubIssuesViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
