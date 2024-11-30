import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/repository_owner/repository_owner_provider.dart';
import 'package:github_issues_viewer/view/account_page/login_form/login_form.dart';
import 'package:github_issues_viewer/view/account_page/repository_list/repository_list.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final owner = ref.watch(repositoryOwnerProvider);
    final isLoading = ref.watch(repositoryOwnerProvider.notifier).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Issues Viewer'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : owner == null
              ? LoginForm()
              : RepositoryList(owner: owner),
    );
  }
}
