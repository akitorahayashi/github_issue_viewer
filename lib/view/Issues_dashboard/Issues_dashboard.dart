import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/repository_owner/giv_repository.dart';
import 'package:github_issues_viewer/model/repository_owner/repository_owner_provider.dart';
import 'package:github_issues_viewer/view/Issues_dashboard/issues_list/issues_list.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class IssuesDashboard extends ConsumerStatefulWidget {
  final GIVRepository repository;
  const IssuesDashboard({super.key, required this.repository});

  @override
  ConsumerState<IssuesDashboard> createState() => IssuesDashboardState();
}

class IssuesDashboardState extends ConsumerState<IssuesDashboard> {
  late Future<List<String>> labelsFuture;

  @override
  void initState() {
    super.initState();
    final owner = ref.read(repositoryOwnerProvider).owner;
    // ラベルを初期化時に非同期で取得
    labelsFuture = widget.repository
        .fetchLabels(login: owner!.login, name: widget.repository.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: labelsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        // ラベルが正常に取得できた場合
        final labels = snapshot.data!;
        final allLabels = ['全て', ...labels];

        return DefaultTabController(
          length: allLabels.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('GitHub Issues Viewer'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                isScrollable: true,
                tabs: allLabels.map((label) => Tab(text: label)).toList(),
              ),
            ),
            body: TabBarView(
              children: allLabels.map((label) {
                // '全て'タブには特定のラベルを渡さない
                final labelForIssuesList = label == '全て' ? null : label;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IssuesList(label: labelForIssuesList),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
