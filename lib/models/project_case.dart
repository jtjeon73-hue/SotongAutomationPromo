class ProjectCase {
  const ProjectCase({
    required this.title,
    required this.purpose,
    required this.features,
    required this.expectedEffect,
    required this.iconName,
  });

  final String title;
  final String purpose;
  final List<String> features;
  final String expectedEffect;
  final String iconName;
}
