import 'package:flutter/material.dart';
import '../models/project_case.dart';
import '../models/solution_feature.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class ProjectCaseCard extends StatelessWidget {
  const ProjectCaseCard({super.key, required this.projectCase});

  final ProjectCase projectCase;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: PromoColors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    promoIcon(projectCase.iconName),
                    color: PromoColors.teal,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    projectCase.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _LabelSection(label: '목적', content: projectCase.purpose),
            const SizedBox(height: 16),
            _LabelSection(
              label: '주요 기능',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: projectCase.features.map((f) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(color: PromoColors.teal),
                        ),
                        Expanded(
                          child: Text(
                            f,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _LabelSection(label: '기대 효과', content: projectCase.expectedEffect),
          ],
        ),
      ),
    );
  }
}

class _LabelSection extends StatelessWidget {
  const _LabelSection({required this.label, this.content, this.child});

  final String label;
  final String? content;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PromoColors.teal,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        if (content != null)
          Text(content!, style: Theme.of(context).textTheme.bodyMedium),
        ?child,
      ],
    );
  }
}

class ApplicationAreasSection extends StatelessWidget {
  const ApplicationAreasSection({super.key, required this.areas});

  final List<ApplicationArea> areas;

  @override
  Widget build(BuildContext context) {
    final columns = PromoLayout.gridColumns(context, max: 3);

    return SectionContainer(
      id: 'applications',
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const SectionTitle(title: '적용 가능한 현장'),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - (columns - 1) * PromoLayout.cardGap) /
                  columns;
              return Wrap(
                spacing: PromoLayout.cardGap,
                runSpacing: PromoLayout.cardGap,
                children: areas.map((area) {
                  return SizedBox(
                    width: columns == 1 ? constraints.maxWidth : itemWidth,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              promoIcon(area.iconName),
                              color: PromoColors.teal,
                              size: 32,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              area.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              area.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key, required this.cases});

  final List<ProjectCase> cases;

  @override
  Widget build(BuildContext context) {
    final columns = PromoLayout.gridColumns(context, max: 2);

    return SectionContainer(
      id: 'portfolio',
      child: Column(
        children: [
          const SectionTitle(
            title: '개발 경험 기반 포트폴리오',
            subtitle: '실제 고객명 없이 일반화된 프로젝트 유형으로 정리한 개발 경험입니다.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - (columns - 1) * PromoLayout.cardGap) /
                  columns;
              return Wrap(
                spacing: PromoLayout.cardGap,
                runSpacing: PromoLayout.cardGap,
                children: cases.map((c) {
                  return SizedBox(
                    width: columns == 1 ? constraints.maxWidth : itemWidth,
                    child: ProjectCaseCard(projectCase: c),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
