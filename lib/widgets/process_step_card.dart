import 'package:flutter/material.dart';
import '../models/process_step.dart';
import '../models/solution_feature.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class ProcessStepCard extends StatelessWidget {
  const ProcessStepCard({super.key, required this.step});

  final ProcessStep step;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: PromoColors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${step.stepNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.description,
                    style: Theme.of(context).textTheme.bodyMedium,
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

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key, required this.steps});

  final List<ProcessStep> steps;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'process',
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const SectionTitle(title: '개발 진행 방식'),
          const SizedBox(height: 48),
          Column(
            children: steps.map((step) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ProcessStepCard(step: step),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key, required this.benefits});

  final List<BenefitItem> benefits;

  @override
  Widget build(BuildContext context) {
    final columns = PromoLayout.gridColumns(context, max: 4);

    return SectionContainer(
      id: 'benefits',
      child: Column(
        children: [
          const SectionTitle(title: '도입 기대 효과'),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - (columns - 1) * PromoLayout.cardGap) /
                  columns;
              return Wrap(
                spacing: PromoLayout.cardGap,
                runSpacing: PromoLayout.cardGap,
                children: benefits.map((benefit) {
                  return SizedBox(
                    width: columns == 1 ? constraints.maxWidth : itemWidth,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              promoIcon(benefit.iconName),
                              color: PromoColors.teal,
                              size: 26,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              benefit.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              benefit.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 13),
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
