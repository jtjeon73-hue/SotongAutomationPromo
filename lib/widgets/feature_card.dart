import 'package:flutter/material.dart';
import '../models/solution_feature.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key, required this.feature});

  final SolutionFeature feature;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PromoColors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                promoIcon(feature.iconName),
                color: PromoColors.teal,
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            Text(feature.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              feature.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ...feature.bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: PromoColors.teal,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        bullet,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key, required this.features});

  final List<SolutionFeature> features;

  @override
  Widget build(BuildContext context) {
    final columns = PromoLayout.gridColumns(context, max: 2);

    return SectionContainer(
      id: 'features',
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const SectionTitle(title: '핵심 기능'),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - (columns - 1) * PromoLayout.cardGap) /
                  columns;
              return Wrap(
                spacing: PromoLayout.cardGap,
                runSpacing: PromoLayout.cardGap,
                children: features.map((feature) {
                  return SizedBox(
                    width: columns == 1 ? constraints.maxWidth : itemWidth,
                    child: FeatureCard(feature: feature),
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
