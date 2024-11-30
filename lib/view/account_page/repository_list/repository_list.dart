import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/repository_owner/repository_owner_provider.dart';
import 'package:github_issues_viewer/view/account_page/repository_list/repository_row.dart';

class RepositoryList extends ConsumerWidget {
  const RepositoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = ref.watch(repositoryOwnerProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: owner?.repositories.length ?? 0, // アイテム数を指定
        itemBuilder: (context, index) {
          final repo = owner?.repositories[index];
          return RepositoryRow(repository: repo!);
        },
      ),
    );
  }
}
