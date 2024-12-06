import 'package:flutter/material.dart';
import 'package:github_issues_viewer/view/account_page.dart';

class GithubIssuesViewerApp extends StatelessWidget {
  const GithubIssuesViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Issues Viewer',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      home: const AccountPage(),
    );
  }
}
