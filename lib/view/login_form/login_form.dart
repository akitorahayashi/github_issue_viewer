import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/view_model/repository_owner_provider.dart';

class LoginForm extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();
  LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(repositoryOwnerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Card(
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Your GitHub ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final login = _controller.text.trim();
                    await notifier.fetchOwnerData(login);
                  },
                  child: const Text('Fetch Repository Data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
