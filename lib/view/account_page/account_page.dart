import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issues_viewer/model/repository_owner/ro_provider.dart';

class AccountPage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = ref.watch(repositoryOwnerProvider);
    final notifier = ref.read(repositoryOwnerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repository Owner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'GitHub Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final login = _controller.text;
                if (login.isNotEmpty) {
                  try {
                    await notifier.fetchOwnerData(login);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error fetching data: $e')),
                    );
                  }
                }
              },
              child: Text('Fetch Owner Data'),
            ),
            SizedBox(height: 16),
            if (owner == null) Text('No data available.'),
            if (owner != null) ...[
              Text('Name: ${owner.name}'),
              Text('ID: ${owner.id}'),
              Image.network(owner.avatarUrl, height: 100),
              SizedBox(height: 16),
              Text('Repositories:'),
              ...owner.repositories.map((repo) => Text(repo)).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
