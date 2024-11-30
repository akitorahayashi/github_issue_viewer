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
    final ownerState = ref.watch(repositoryOwnerProvider);
    final repositoryOwnerNotifier = ref.read(repositoryOwnerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: (!ownerState.isLoading && ownerState.owner != null)
            ? GestureDetector(
                onTap: () => repositoryOwnerNotifier.logout(),
                child: Transform.rotate(
                  angle: 3.14159, // 180度回転
                  child: const Icon(Icons.logout),
                ),
              )
            : null,
        title: const Text(
          'GitHub Issues Viewer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: ownerState.isLoading
            ? const Center(
                key: ValueKey('loading'),
                child: CircularProgressIndicator(),
              )
            : ownerState.owner == null
                ? LoginForm(
                    key: const ValueKey('loginForm'),
                  )
                : RepositoryList(
                    key: const ValueKey('repositoryList'),
                    owner: ownerState.owner!,
                  ),
      ),
    );
  }
}
