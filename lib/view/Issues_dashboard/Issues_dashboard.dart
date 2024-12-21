import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/giv_repository.dart';
import 'package:github_issues_viewer/view/Issues_dashboard/issues_list/issues_list.dart';
import 'package:github_issues_viewer/view_model/repository_owner_provider.dart';
import 'package:github_issues_viewer/view_model/labels_provider.dart';

class IssuesDashboard extends ConsumerStatefulWidget {
  final GIVRepository repository;
  const IssuesDashboard({super.key, required this.repository});

  @override
  ConsumerState<IssuesDashboard> createState() => IssuesDashboardState();
}

class IssuesDashboardState extends ConsumerState<IssuesDashboard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final ownerState = ref.read(repositoryOwnerProvider).owner;
      // ラベルを初期化時に非同期で取得
      ref.read(labelsProvider.notifier).fetchLabels(
            login: ownerState!.login,
            name: widget.repository.name,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelsState = ref.watch(labelsProvider);

    return labelsState.when(
      data: (labels) {
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
                  child: IssuesList(
                    repositoryName: widget.repository.name,
                    label: labelForIssuesList,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
