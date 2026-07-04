import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../theme/promo_theme.dart';

enum SoftwarePreviewType {
  dashboard,
  alarm,
  trend,
  report,
  production,
  recipe,
  spc,
  history,
}

class SoftwarePreviewSpec {
  const SoftwarePreviewSpec({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.type,
    required this.windowTitle,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final SoftwarePreviewType type;
  final String windowTitle;
}

class SoftwarePreviewData {
  SoftwarePreviewData._();

  static const items = [
    SoftwarePreviewSpec(
      title: '통합 대시보드',
      subtitle: 'KPI · 라인 상태 · 실시간 요약',
      icon: Icons.dashboard_customize,
      color: PromoColors.electricBlue,
      type: SoftwarePreviewType.dashboard,
      windowTitle: 'DASHBOARD / LINE OVERVIEW',
    ),
    SoftwarePreviewSpec(
      title: '알람 현황',
      subtitle: '설비 알람 · 우선순위 · 대응 상태',
      icon: Icons.warning_amber_rounded,
      color: PromoColors.alarm,
      type: SoftwarePreviewType.alarm,
      windowTitle: 'ALARM / EVENT MONITOR',
    ),
    SoftwarePreviewSpec(
      title: '트렌드 분석',
      subtitle: 'Torque · Angle · 공정 변수',
      icon: Icons.show_chart,
      color: PromoColors.cyan,
      type: SoftwarePreviewType.trend,
      windowTitle: 'TREND / PROCESS DATA',
    ),
    SoftwarePreviewSpec(
      title: '리포트',
      subtitle: '일/주/월 생산 · 품질 리포트',
      icon: Icons.summarize_outlined,
      color: PromoColors.success,
      type: SoftwarePreviewType.report,
      windowTitle: 'REPORT / PRODUCTION SUMMARY',
    ),
    SoftwarePreviewSpec(
      title: '생산 현황',
      subtitle: '공정 Step · OK/NG · 진행률',
      icon: Icons.precision_manufacturing,
      color: PromoColors.warning,
      type: SoftwarePreviewType.production,
      windowTitle: 'PRODUCTION / LINE STATUS',
    ),
    SoftwarePreviewSpec(
      title: '레시피 관리',
      subtitle: '공정 파라미터 · 작업 조건',
      icon: Icons.tune,
      color: PromoColors.purple,
      type: SoftwarePreviewType.recipe,
      windowTitle: 'RECIPE / PROCESS PARAM',
    ),
    SoftwarePreviewSpec(
      title: 'SPC 품질',
      subtitle: 'X-bar · UCL/LCL · 이탈 감시',
      icon: Icons.query_stats,
      color: PromoColors.tealAccent,
      type: SoftwarePreviewType.spc,
      windowTitle: 'SPC / QUALITY CONTROL',
    ),
    SoftwarePreviewSpec(
      title: '이력 조회',
      subtitle: 'LOT · Serial · 작업 로그',
      icon: Icons.history,
      color: PromoColors.electricBlue,
      type: SoftwarePreviewType.history,
      windowTitle: 'HISTORY / TRACE LOG',
    ),
  ];
}

class SoftwarePreviewScreen extends StatelessWidget {
  const SoftwarePreviewScreen({super.key, required this.spec});

  final SoftwarePreviewSpec spec;

  @override
  Widget build(BuildContext context) {
    return _PreviewChrome(
      windowTitle: spec.windowTitle,
      accent: spec.color,
      child: switch (spec.type) {
        SoftwarePreviewType.dashboard => _DashboardLayout(color: spec.color),
        SoftwarePreviewType.alarm => _AlarmLayout(color: spec.color),
        SoftwarePreviewType.trend => _TrendLayout(color: spec.color),
        SoftwarePreviewType.report => _ReportLayout(color: spec.color),
        SoftwarePreviewType.production => _ProductionLayout(color: spec.color),
        SoftwarePreviewType.recipe => _RecipeLayout(color: spec.color),
        SoftwarePreviewType.spc => _SpcLayout(color: spec.color),
        SoftwarePreviewType.history => _HistoryLayout(color: spec.color),
      },
    );
  }
}

class _PreviewChrome extends StatelessWidget {
  const _PreviewChrome({
    required this.windowTitle,
    required this.accent,
    required this.child,
  });

  final String windowTitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF050B16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
            ),
            child: Row(
              children: [
                const _TrafficLights(),
                const SizedBox(width: 12),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    windowTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: PromoColors.textMutedOnDark,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.all(10), child: child),
          ),
        ],
      ),
    );
  }
}

class _TrafficLights extends StatelessWidget {
  const _TrafficLights();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _dot(const Color(0xFFFF5F57)),
        const SizedBox(width: 5),
        _dot(const Color(0xFFFEBC2E)),
        const SizedBox(width: 5),
        _dot(const Color(0xFF28C840)),
      ],
    );
  }

  Widget _dot(Color c) => Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

// ── Dashboard: KPI grid + mini line status ──
class _DashboardLayout extends StatelessWidget {
  const _DashboardLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (final label in ['가동률', '생산', 'OK', 'NG']) ...[
              Expanded(
                child: _miniKpi(
                  label,
                  label == 'NG' ? PromoColors.alarm : color,
                ),
              ),
              if (label != 'NG') const SizedBox(width: 6),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: _panel(
                  child: CustomPaint(
                    painter: _LineGridPainter(color.withValues(alpha: 0.5)),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    for (var i = 0; i < 3; i++) ...[
                      Expanded(
                        child: _panel(
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: i == 1 ? PromoColors.warning : color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (i < 2) const SizedBox(height: 6),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniKpi(String label, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}

// ── Alarm: list rows with severity ──
class _AlarmLayout extends StatelessWidget {
  const _AlarmLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    const rows = [
      ('CRITICAL', 'PLC 통신 지연', PromoColors.alarm),
      ('WARNING', '체결 Torque 이탈', PromoColors.warning),
      ('WARNING', '바코드 미인식', PromoColors.warning),
      ('INFO', '공정 완료', PromoColors.success),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _badge('ACTIVE 3', color),
            const SizedBox(width: 6),
            _badge('ACK 1', PromoColors.steelGray),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            children: [
              for (var i = 0; i < rows.length; i++) ...[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: rows[i].$3.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: rows[i].$3.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: rows[i].$3,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          rows[i].$1,
                          style: TextStyle(
                            color: rows[i].$3,
                            fontSize: 7,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            rows[i].$2,
                            style: const TextStyle(
                              color: PromoColors.textMutedOnDark,
                              fontSize: 8,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (i < rows.length - 1) const SizedBox(height: 4),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _badge(String t, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        t,
        style: TextStyle(color: c, fontSize: 7, fontWeight: FontWeight.w800),
      ),
    );
  }
}

// ── Trend: large line chart ──
class _TrendLayout extends StatelessWidget {
  const _TrendLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _chip('Torque', color, true),
            const SizedBox(width: 4),
            _chip('Angle', PromoColors.steelGray, false),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _panel(
            child: CustomPaint(
              painter: _TrendLinePainter(color, secondary: PromoColors.cyan),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            for (final t in ['10:00', '10:05', '10:10', '10:15', '10:20'])
              Expanded(
                child: Text(
                  t,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 7,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _chip(String label, Color c, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: active ? c.withValues(alpha: 0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c.withValues(alpha: active ? 0.5 : 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? c : PromoColors.steelGray,
          fontSize: 7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}

// ── Report: table grid ──
class _ReportLayout extends StatelessWidget {
  const _ReportLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.picture_as_pdf, color: color, size: 14),
            const SizedBox(width: 4),
            Text(
              '일일 생산 리포트',
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.table_chart,
              color: color.withValues(alpha: 0.6),
              size: 12,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            children: [
              _tableRow(['공정', '생산', 'OK', 'NG'], header: true, color: color),
              for (var i = 0; i < 4; i++) ...[
                const SizedBox(height: 3),
                _tableRow([
                  'OP-${i + 1}',
                  '${120 + i * 15}',
                  '${115 + i * 14}',
                  '${5 + i}',
                ], color: color),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _tableRow(
    List<String> cells, {
    bool header = false,
    required Color color,
  }) {
    return Expanded(
      child: Row(
        children: [
          for (var i = 0; i < cells.length; i++)
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: header
                      ? color.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: Text(
                  cells[i],
                  style: TextStyle(
                    color: header ? color : PromoColors.textMutedOnDark,
                    fontSize: 7,
                    fontWeight: header ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Production: steps + OK/NG ──
class _ProductionLayout extends StatelessWidget {
  const _ProductionLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _counter('OK', '248', PromoColors.success),
            const SizedBox(width: 6),
            _counter('NG', '7', PromoColors.alarm),
            const Spacer(),
            Text(
              '진행 78%',
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < 4; i++) ...[
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: i < 3
                              ? color.withValues(alpha: 0.25)
                              : Colors.white.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: i == 3
                                ? color
                                : color.withValues(alpha: 0.5),
                            width: i == 3 ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: i < 3
                                  ? color
                                  : PromoColors.textMutedOnDark,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      if (i < 3)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            color: color.withValues(alpha: 0.4),
                          ),
                        ),
                    ],
                  ),
                ),
                if (i < 3)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Icon(
                      Icons.arrow_forward,
                      color: color.withValues(alpha: 0.5),
                      size: 10,
                    ),
                  ),
              ],
            ],
          ),
        ),
        Row(
          children: [
            for (final s in ['스캔', '체결', '검사', '완료'])
              Expanded(
                child: Text(
                  s,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 7,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _counter(String label, String val, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 8,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            val,
            style: TextStyle(
              color: c,
              fontSize: 9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recipe: parameter sliders ──
class _RecipeLayout extends StatelessWidget {
  const _RecipeLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    const params = [
      ('Torque', 0.72),
      ('Angle', 0.55),
      ('Speed', 0.38),
      ('Wait', 0.65),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe A-102',
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            children: [
              for (final p in params) ...[
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Text(
                          p.$1,
                          style: const TextStyle(
                            color: PromoColors.textMutedOnDark,
                            fontSize: 7,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: p.$2,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ── SPC: control chart with UCL/LCL ──
class _SpcLayout extends StatelessWidget {
  const _SpcLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _limit('UCL', PromoColors.alarm),
            const SizedBox(width: 4),
            _limit('CL', color),
            const SizedBox(width: 4),
            _limit('LCL', PromoColors.alarm),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomPaint(
            painter: _SpcChartPainter(color),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }

  Widget _limit(String label, Color c) {
    return Row(
      children: [
        Container(width: 10, height: 2, color: c),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(color: c, fontSize: 7, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// ── History: search + log list ──
class _HistoryLayout extends StatelessWidget {
  const _HistoryLayout({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    const logs = [
      ('LOT-240701', '10:24 OK'),
      ('LOT-240702', '10:18 NG'),
      ('LOT-240703', '10:11 OK'),
      ('LOT-240704', '10:05 OK'),
    ];
    return Column(
      children: [
        Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 11, color: color),
              const SizedBox(width: 6),
              Text(
                'LOT / Serial 검색',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            children: [
              for (final log in logs) ...[
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.fiber_manual_record, size: 6, color: color),
                      const SizedBox(width: 6),
                      Text(
                        log.$1,
                        style: TextStyle(
                          color: color,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        log.$2,
                        style: TextStyle(
                          color: log.$2.contains('NG')
                              ? PromoColors.alarm
                              : PromoColors.success,
                          fontSize: 7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.white.withValues(alpha: 0.06)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ── Painters ──
class _LineGridPainter extends CustomPainter {
  _LineGridPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;
    for (var i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrendLinePainter extends CustomPainter {
  _TrendLinePainter(this.primary, {required this.secondary});
  final Color primary;
  final Color secondary;

  @override
  void paint(Canvas canvas, Size size) {
    for (final spec in [(primary, 0.0), (secondary, 0.15)]) {
      final paint = Paint()
        ..color = spec.$1
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke;
      final path = Path();
      for (var i = 0; i < 12; i++) {
        final x = size.width * i / 11;
        final y =
            size.height *
            (0.55 - math.sin(i * 0.7 + spec.$2) * 0.28 + (i % 3) * 0.04);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
    final limit = Paint()
      ..color = PromoColors.alarm.withValues(alpha: 0.4)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height * 0.25),
      Offset(size.width, size.height * 0.25),
      limit,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.75),
      Offset(size.width, size.height * 0.75),
      limit,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SpcChartPainter extends CustomPainter {
  _SpcChartPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final ucl = size.height * 0.2;
    final cl = size.height * 0.5;
    final lcl = size.height * 0.8;
    for (final y in [ucl, cl, lcl]) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        Paint()
          ..color = (y == cl ? color : PromoColors.alarm).withValues(alpha: 0.5)
          ..strokeWidth = y == cl ? 1.5 : 1,
      );
    }
    final vals = [0.48, 0.52, 0.45, 0.55, 0.5, 0.47, 0.72, 0.49, 0.51];
    for (var i = 0; i < vals.length; i++) {
      final x = size.width * (i + 0.5) / vals.length;
      final y = size.height * vals[i];
      final outOfControl = vals[i] > 0.65;
      canvas.drawCircle(
        Offset(x, y),
        3,
        Paint()..color = outOfControl ? PromoColors.alarm : color,
      );
      if (i > 0) {
        canvas.drawLine(
          Offset(
            size.width * (i - 0.5) / vals.length,
            size.height * vals[i - 1],
          ),
          Offset(x, y),
          Paint()
            ..color = color.withValues(alpha: 0.6)
            ..strokeWidth = 1.2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
