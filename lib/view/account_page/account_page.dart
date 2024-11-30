import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/repository_owner/repository_owner.dart';
import 'package:github_issues_viewer/model/repository_owner/repository_owner_provider.dart';
import 'package:github_issues_viewer/view/account_page/login_form/login_form.dart';
import 'package:github_issues_viewer/view/account_page/repository_list/repository_list.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final owner = ref.watch(repositoryOwnerProvider);
    final repositoryOwnerNotifier = ref.read(repositoryOwnerProvider.notifier);

    // ref.listenをbuildメソッド内で使用
    ref.listen<RepositoryOwner?>(
      repositoryOwnerProvider,
      (_, __) {
        setState(() {
          isLoading = repositoryOwnerNotifier.isLoading;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: (!isLoading && owner != null)
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : owner == null
              ? LoginForm()
              : RepositoryList(owner: owner),
    );
  }
}
