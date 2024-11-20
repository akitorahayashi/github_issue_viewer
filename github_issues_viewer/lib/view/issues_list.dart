import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/issues_provider.dart';

class IssuesListScreen extends ConsumerWidget {
  final String label;

  const IssuesListScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issues = ref.watch(issuesProvider(label));

    return issues.when(
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final issue = data[index];
          return ListTile(
            title: Text(issue.title),
            subtitle: Text(issue.body),
            onTap: () {
              // Issue詳細画面への遷移を実装可能
            },
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
