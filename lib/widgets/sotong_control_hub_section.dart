import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/promo_contact.dart';
import '../data/sotong_hub_config.dart';
import '../theme/promo_theme.dart';

/// 소통총관제 연동 — 온라인 문의·피드백·지시 흐름 섹션
class SotongControlHubSection extends StatelessWidget {
  const SotongControlHubSection({super.key, this.onInquiry, this.onDemo});

  final VoidCallback? onInquiry;
  final VoidCallback? onDemo;

  Future<void> _defaultInquiry() async {
    await launchUrl(PromoContact.hubInquiryUri());
  }

  Future<void> _defaultDemo() async {
    await launchUrl(PromoContact.hubDemoUri());
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 900;

    return Container(
      width: double.infinity,
      color: const Color(0xFF060D18),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 32 : 20,
              vertical: isWide ? 72 : 48,
            ),
            child: Column(
              children: [
                _heading(),
                const SizedBox(height: 48),
                _flowDiagram(isWide),
                const SizedBox(height: 40),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: _ticketPanel()),
                          const SizedBox(width: 24),
                          Expanded(flex: 2, child: _instructionPanel()),
                        ],
                      )
                    : Column(
                        children: [
                          _ticketPanel(),
                          const SizedBox(height: 20),
                          _instructionPanel(),
                        ],
                      ),
                const SizedBox(height: 36),
                _ctaRow(onInquiry ?? _defaultInquiry, onDemo ?? _defaultDemo),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heading() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: PromoColors.cyan.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'SOTONG CENTRAL COMMAND HUB',
            style: TextStyle(
              color: PromoColors.cyan,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '소통총관제 연동 구조',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: PromoColors.textOnDark,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            '온라인 고객의 상담·데모·기술 문의는 ${SotongHubConfig.hubName}로 접수되고, '
            '검토·피드백·후속 지시까지 하나의 흐름으로 관리됩니다. '
            '본 홍보사이트는 소통총관제와 연계된 고객 접점 채널입니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PromoColors.textMutedOnDark.withValues(alpha: 0.95),
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flowDiagram(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PromoColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PromoColors.border),
      ),
      child: isWide
          ? Row(
              children: [
                for (var i = 0; i < SotongHubConfig.flowSteps.length; i++) ...[
                  Expanded(child: _flowStepCard(SotongHubConfig.flowSteps[i])),
                  if (i < SotongHubConfig.flowSteps.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.arrow_forward,
                        color: PromoColors.cyan.withValues(alpha: 0.5),
                        size: 20,
                      ),
                    ),
                ],
              ],
            )
          : Column(
              children: [
                for (var i = 0; i < SotongHubConfig.flowSteps.length; i++) ...[
                  _flowStepCard(SotongHubConfig.flowSteps[i]),
                  if (i < SotongHubConfig.flowSteps.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(
                        Icons.arrow_downward,
                        color: PromoColors.cyan.withValues(alpha: 0.5),
                        size: 20,
                      ),
                    ),
                ],
              ],
            ),
    );
  }

  Widget _flowStepCard(HubFlowStep step) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: step.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: step.color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: step.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${step.step}',
                  style: TextStyle(
                    color: step.color,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(step.icon, color: step.color, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            step.title,
            style: const TextStyle(
              color: PromoColors.textOnDark,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step.description,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ticketPanel() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: PromoColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: PromoColors.electricBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.inbox_outlined,
                color: PromoColors.electricBlue,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                '온라인 문의 현황 (소통총관제)',
                style: TextStyle(
                  color: PromoColors.textOnDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '실제 고객명 없이 흐름을 보여주는 샘플 화면입니다.',
            style: TextStyle(color: PromoColors.steelGray, fontSize: 11),
          ),
          const SizedBox(height: 18),
          for (final ticket in SotongHubConfig.sampleTickets) ...[
            _ticketRow(ticket),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _ticketRow(HubTicket ticket) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      ticket.id,
                      style: TextStyle(
                        color: PromoColors.cyan,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ticket.type,
                      style: const TextStyle(
                        color: PromoColors.textMutedOnDark,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.summary,
                  style: const TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ticket.status.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: ticket.status.color.withValues(alpha: 0.35),
              ),
            ),
            child: Text(
              ticket.status.label,
              style: TextStyle(
                color: ticket.status.color,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _instructionPanel() {
    const instructions = [
      ('자료 보완 요청', '현장 공정도·연동 대상 설비 목록 전달'),
      ('데모 일정 확정', '온라인 미팅 7/12 14:00 안내'),
      ('견적 검토 지시', 'PLC 2대·바코드 1식 기준 1차 제안'),
    ];
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [PromoColors.navy, PromoColors.deepNavy],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: PromoColors.cyan.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.campaign_outlined, color: PromoColors.cyan, size: 22),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  '소통총관제 지시 · 피드백',
                  style: TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '총관제에서 내려진 후속 조치와 피드백이 고객 채널로 전달되는 구조입니다.',
            style: TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          for (final item in instructions) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PromoColors.cyan.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: PromoColors.cyan.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_right,
                        size: 14,
                        color: PromoColors.cyan,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          color: PromoColors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.$2,
                    style: const TextStyle(
                      color: PromoColors.textMutedOnDark,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.link, size: 16, color: PromoColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '접점: ${PromoContact.email} → ${SotongHubConfig.hubName}',
                    style: const TextStyle(
                      color: PromoColors.textMutedOnDark,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ctaRow(VoidCallback onInquiry, VoidCallback onDemo) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      alignment: WrapAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: onInquiry,
          icon: const Icon(Icons.hub_outlined, size: 20),
          label: const Text('소통총관제 경유 상담 문의'),
          style: FilledButton.styleFrom(
            backgroundColor: PromoColors.electricBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        OutlinedButton.icon(
          onPressed: onDemo,
          icon: const Icon(Icons.play_circle_outline, size: 20),
          label: const Text('데모 요청 (총관제 접수)'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PromoColors.cyan,
            side: const BorderSide(color: PromoColors.cyan),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ],
    );
  }
}
