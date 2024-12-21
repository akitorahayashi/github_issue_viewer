import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/repository_owner.dart';

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
        leading: Card(
          shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(owner.avatarUrl),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              owner.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              owner.login,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
