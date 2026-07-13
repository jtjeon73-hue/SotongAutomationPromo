import 'package:flutter/material.dart';
import '../models/solution_feature.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class SystemArchitectureSection extends StatelessWidget {
  const SystemArchitectureSection({super.key, required this.nodes});

  final List<ArchitectureNode> nodes;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'architecture',
      child: Column(
        children: [
          const SectionTitle(
            title: '시스템 구성 개념',
            subtitle:
                '생산설비·센서·검사장비 → PLC·컨트롤러 → 현장 PC 산업자동화 프로그램 → '
                '표시·저장·조회 → 필요 시 MES·ERP·사내 서버로 확장',
          ),
          const SizedBox(height: 56),
          _ArchitectureDiagram(nodes: nodes),
        ],
      ),
    );
  }
}

class _ArchitectureDiagram extends StatelessWidget {
  const _ArchitectureDiagram({required this.nodes});

  final List<ArchitectureNode> nodes;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 768;

    if (isWide) {
      return Column(
        children: [
          _LayerRow(
            label: '현장 장비 / 작업자',
            nodeIndices: [0, 1, 2, 3],
            nodes: nodes,
          ),
          _Connector(),
          _LayerRow(
            label: '공정 PC',
            nodeIndices: [4],
            nodes: nodes,
            highlight: true,
          ),
          _Connector(),
          _LayerRow(label: '데이터 / 조회', nodeIndices: [5, 6], nodes: nodes),
          _Connector(),
          _LayerRow(
            label: '확장 영역 (필요 시 연계)',
            nodeIndices: [7, 8],
            nodes: nodes,
          ),
          const SizedBox(height: 32),
          _FlowSummary(),
        ],
      );
    }

    return Column(
      children: [
        for (var i = 0; i < nodes.length; i++) ...[
          _NodeCard(node: nodes[i], highlight: i == 4),
          if (i < nodes.length - 1) _Connector(compact: true),
        ],
        const SizedBox(height: 24),
        _FlowSummary(),
      ],
    );
  }
}

class _LayerRow extends StatelessWidget {
  const _LayerRow({
    required this.label,
    required this.nodeIndices,
    required this.nodes,
    this.highlight = false,
  });

  final String label;
  final List<int> nodeIndices;
  final List<ArchitectureNode> nodes;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: PromoColors.steelGray,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: nodeIndices.map((i) {
            return SizedBox(
              width: 180,
              child: _NodeCard(node: nodes[i], highlight: highlight),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({required this.node, this.highlight = false});

  final ArchitectureNode node;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: highlight ? PromoColors.teal : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight ? PromoColors.teal : PromoColors.border,
          width: highlight ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            promoIcon(node.iconName),
            color: highlight ? Colors.white : PromoColors.teal,
            size: 28,
          ),
          const SizedBox(height: 10),
          Text(
            node.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: highlight ? Colors.white : PromoColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            node.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: highlight
                  ? Colors.white.withValues(alpha: 0.85)
                  : PromoColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 4 : 12),
      child: Column(
        children: [
          Container(
            width: 2,
            height: compact ? 20 : 28,
            color: PromoColors.teal.withValues(alpha: 0.4),
          ),
          Icon(
            Icons.arrow_downward,
            size: compact ? 16 : 20,
            color: PromoColors.teal.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}

class _FlowSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PromoColors.deepNavy,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          _flowChip('생산설비 · PLC'),
          const Icon(
            Icons.arrow_forward,
            color: PromoColors.tealAccent,
            size: 16,
          ),
          _flowChip('현장 PC 프로그램'),
          const Icon(
            Icons.arrow_forward,
            color: PromoColors.tealAccent,
            size: 16,
          ),
          _flowChip('표시 · 저장 · 조회'),
          const Icon(
            Icons.arrow_forward,
            color: PromoColors.tealAccent,
            size: 16,
          ),
          _flowChip('MES · ERP 확장'),
          const Icon(
            Icons.arrow_forward,
            color: PromoColors.tealAccent,
            size: 16,
          ),
          _flowChip('생산 이력 관리'),
        ],
      ),
    );
  }

  Widget _flowChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: PromoColors.navy,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: PromoColors.teal.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: PromoColors.tealAccent,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
