class SolutionFeature {
  const SolutionFeature({
    required this.title,
    required this.description,
    required this.bullets,
    required this.iconName,
  });

  final String title;
  final String description;
  final List<String> bullets;
  final String iconName;
}

class ProblemItem {
  const ProblemItem({
    required this.label,
    required this.title,
    required this.description,
  });

  final String label;
  final String title;
  final String description;
}

class SolutionItem {
  const SolutionItem({required this.title, required this.iconName});

  final String title;
  final String iconName;
}

class ApplicationArea {
  const ApplicationArea({
    required this.title,
    required this.description,
    required this.iconName,
  });

  final String title;
  final String description;
  final String iconName;
}

class BenefitItem {
  const BenefitItem({
    required this.title,
    required this.description,
    required this.iconName,
  });

  final String title;
  final String description;
  final String iconName;
}

class TechStackItem {
  const TechStackItem({required this.title, required this.iconName});

  final String title;
  final String iconName;
}

class ArchitectureNode {
  const ArchitectureNode({
    required this.title,
    required this.subtitle,
    required this.iconName,
  });

  final String title;
  final String subtitle;
  final String iconName;
}
