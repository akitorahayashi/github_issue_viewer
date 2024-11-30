class GIVIssue {
  final String title;
  final String body;
  final String url;
  final String createdAt;
  final String author;
  final String githubUrl;
  final bool isClosed;

  GIVIssue({
    required this.title,
    required this.body,
    required this.url,
    required this.createdAt,
    required this.author,
    required this.githubUrl,
    required this.isClosed,
  });
}
