class MbtiType {
  final String code;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> careerPaths;
  final String compatibility;

  MbtiType({
    required this.code,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.strengths,
    required this.weaknesses,
    required this.careerPaths,
    required this.compatibility,
  });

  factory MbtiType.fromJson(Map<String, dynamic> json) {
    return MbtiType(
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String? ?? 'assets/images/default.png',
      strengths: List<String>.from(json['strengths'] ?? []),
      weaknesses: List<String>.from(json['weaknesses'] ?? []),
      careerPaths: List<String>.from(json['careerPaths'] ?? []),
      compatibility: json['compatibility'] as String? ?? '未知',
    );
  }
}
