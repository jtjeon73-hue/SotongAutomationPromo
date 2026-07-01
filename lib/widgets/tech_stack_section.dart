import 'package:flutter/material.dart';
import '../models/solution_feature.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key, required this.items});

  final List<TechStackItem> items;

  @override
  Widget build(BuildContext context) {
    final columns = PromoLayout.gridColumns(context, max: 4);

    return SectionContainer(
      id: 'tech',
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const SectionTitle(
            title: '기술 영역',
            subtitle: '실제 경험 기반의 안정적인 기술 영역입니다.',
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
                children: items.map((item) {
                  return SizedBox(
                    width: columns == 1 ? constraints.maxWidth : itemWidth,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              promoIcon(item.iconName),
                              color: PromoColors.teal,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.title,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(fontSize: 14),
                              ),
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
