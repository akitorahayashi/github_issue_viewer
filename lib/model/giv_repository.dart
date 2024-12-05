class GIVRepository {
  final String name;
  final String? description;
  final String updatedAt;
  final String? primaryLanguage;

  GIVRepository({
    required this.name,
    this.description,
    required this.updatedAt,
    this.primaryLanguage,
  });

  factory GIVRepository.fromJson(Map<String, dynamic> json) {
    return GIVRepository(
      name: json['name'],
      description: json['description'],
      updatedAt: json['updatedAt'],
      primaryLanguage: json['primaryLanguage']
          ?['name'], // primaryLanguage is nullable
    );
  }
}
