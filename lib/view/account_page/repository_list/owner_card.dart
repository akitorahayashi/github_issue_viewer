import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/repository_owner/repository_owner.dart';

class OwnerCard extends StatelessWidget {
  final RepositoryOwner owner;
  const OwnerCard({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(owner.avatarUrl), // アバター画像をURLから読み込む
        ),
        title: Text(
          owner.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'ID: ${owner.id}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
