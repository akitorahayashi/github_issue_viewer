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
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Issues Viewer'),
      ),
      body: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        crossFadeState: owner == null
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: LoginForm(),
        secondChild: owner == null
            ? const SizedBox.shrink()
            : RepositoryList(owner: owner),
      ),
    );
  }
}
