import 'package:flutter/material.dart';
import '../models/solution_feature.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class ProblemSolutionSection extends StatelessWidget {
  const ProblemSolutionSection({
    super.key,
    required this.problems,
    required this.solutions,
  });

  final List<ProblemItem> problems;
  final List<SolutionItem> solutions;

  @override
  Widget build(BuildContext context) {
    final columns = PromoLayout.gridColumns(context, max: 3);

    return Column(
      children: [
        SectionContainer(
          id: 'problems',
          child: Column(
            children: [
              const SectionTitle(title: '현장에서 자주 발생하는 문제'),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth =
                      (constraints.maxWidth -
                          (columns - 1) * PromoLayout.cardGap) /
                      columns;
                  return Wrap(
                    spacing: PromoLayout.cardGap,
                    runSpacing: PromoLayout.cardGap,
                    children: problems.map((problem) {
                      return SizedBox(
                        width: columns == 1 ? constraints.maxWidth : itemWidth,
                        child: _ProblemCard(problem: problem),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
        SectionContainer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              const SectionTitle(
                title: '소통웨어의 통합 모니터링 접근',
                subtitle:
                    '각 공정의 작업 흐름과 설비 데이터를 하나의 화면에서 관리할 수 있도록, '
                    '작업자 UI, 설비 연동, 데이터 저장, 그래프 표시, 이력 조회, '
                    '상위 시스템 연동 구조를 함께 설계합니다.',
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final solColumns = PromoLayout.gridColumns(context, max: 4);
                  final itemWidth =
                      (constraints.maxWidth -
                          (solColumns - 1) * PromoLayout.cardGap) /
                      solColumns;
                  return Wrap(
                    spacing: PromoLayout.cardGap,
                    runSpacing: PromoLayout.cardGap,
                    children: solutions.map((solution) {
                      return SizedBox(
                        width: solColumns == 1
                            ? constraints.maxWidth
                            : itemWidth,
                        child: _SolutionChip(solution: solution),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProblemCard extends StatelessWidget {
  const _ProblemCard({required this.problem});

  final ProblemItem problem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: PromoColors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                problem.label,
                style: const TextStyle(
                  color: PromoColors.teal,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(problem.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              problem.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _SolutionChip extends StatelessWidget {
  const _SolutionChip({required this.solution});

  final SolutionItem solution;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Icon(
              promoIcon(solution.iconName),
              color: PromoColors.teal,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                solution.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
