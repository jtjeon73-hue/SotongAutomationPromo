import 'package:flutter/material.dart';
import '../data/sample_automation_data.dart';
import '../theme/promo_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onScrollToFeatures,
    required this.onScrollToApplications,
    required this.onScrollToProcess,
  });

  final VoidCallback onScrollToFeatures;
  final VoidCallback onScrollToApplications;
  final VoidCallback onScrollToProcess;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [PromoColors.deepNavy, PromoColors.navy, Color(0xFF1A3A4A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: -40,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PromoColors.teal.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            left: -60,
            bottom: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PromoColors.teal.withValues(alpha: 0.04),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: PromoLayout.maxContentWidth,
              ),
              child: Padding(
                padding: PromoLayout.sectionPaddingOf(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: PromoColors.tealAccent.withValues(alpha: 0.5),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Sotong Automation Monitoring System',
                        style: TextStyle(
                          color: PromoColors.tealAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '산업자동화\n모니터링 시스템',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isWide ? 48 : 34,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '생산라인의 작업, 설비, 데이터 흐름을 한눈에 관리합니다',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: PromoColors.tealAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Text(
                        '소통웨어는 제조 생산라인과 조립 공정에서 필요한 작업순서 관리, 바코드 연동, '
                        'PLC/MES 연동, 작업자 Tool 데이터 수집, CSV 저장, 그래프 분석, '
                        '라인별 PC 상태 모니터링을 통합하는 PC 기반 산업자동화 모니터링 시스템을 '
                        '기획하고 개발합니다.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: PromoColors.textMutedOnDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: SampleAutomationData.heroKeywords
                          .map((keyword) => Chip(label: Text(keyword)))
                          .toList(),
                    ),
                    const SizedBox(height: 40),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton(
                          onPressed: onScrollToFeatures,
                          child: const Text('주요 기능 보기'),
                        ),
                        OutlinedButton(
                          onPressed: onScrollToApplications,
                          child: const Text('적용 분야 보기'),
                        ),
                        OutlinedButton(
                          onPressed: onScrollToProcess,
                          child: const Text('개발 프로세스 보기'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
