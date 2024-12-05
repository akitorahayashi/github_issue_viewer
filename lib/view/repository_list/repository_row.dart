import 'package:flutter/material.dart';
import 'package:github_issues_viewer/model/giv_repository.dart';
import 'package:github_issues_viewer/styles.dart';
import 'package:github_issues_viewer/view/Issues_dashboard/Issues_dashboard.dart';

class RepositoryRow extends StatelessWidget {
  final GIVRepository repository;

  const RepositoryRow({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () => Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => IssuesDashboard(repository: repository))),
        title: Text(
          repository.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (repository.description != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  repository.description!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  if (repository.primaryLanguage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        repository.primaryLanguage!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 3.0),
                    child: Icon(Icons.refresh, color: Colors.grey, size: 12),
                  ),
                  Text(
                    formatDate(repository.updatedAt),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
