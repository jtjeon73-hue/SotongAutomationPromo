import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/promo_contact.dart';
import '../theme/promo_theme.dart';

class IndustrialLandingPage extends StatefulWidget {
  const IndustrialLandingPage({super.key});

  @override
  State<IndustrialLandingPage> createState() => _IndustrialLandingPageState();
}

class _IndustrialLandingPageState extends State<IndustrialLandingPage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _homeKey = GlobalKey();
  final _introKey = GlobalKey();
  final _featuresKey = GlobalKey();
  final _architectureKey = GlobalKey();
  final _previewKey = GlobalKey();
  final _casesKey = GlobalKey();
  final _benefitsKey = GlobalKey();
  final _contactKey = GlobalKey();
  late final AnimationController _pulseController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    Future<void>.delayed(const Duration(milliseconds: 850), () {
      if (mounted) {
        setState(() => _loading = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openEmail(String subject) async {
    await launchUrl(PromoContact.mailtoUri(subject: subject));
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PromoColors.deepNavy,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                toolbarHeight: 72,
                elevation: 0,
                backgroundColor: PromoColors.deepNavy.withValues(alpha: 0.92),
                surfaceTintColor: Colors.transparent,
                titleSpacing: 24,
                title: const _BrandMark(),
                actions: [
                  if (MediaQuery.sizeOf(context).width > 1120) ...[
                    _NavButton('HOME', () => _scrollTo(_homeKey)),
                    _NavButton('시스템소개', () => _scrollTo(_introKey)),
                    _NavButton('핵심기능', () => _scrollTo(_featuresKey)),
                    _NavButton('시스템구성도', () => _scrollTo(_architectureKey)),
                    _NavButton('소프트웨어 화면', () => _scrollTo(_previewKey)),
                    _NavButton('적용사례', () => _scrollTo(_casesKey)),
                    _NavButton('도입효과', () => _scrollTo(_benefitsKey)),
                    _NavButton('문의하기', () => _scrollTo(_contactKey)),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(right: 24, left: 10),
                    child: _ActionButton(
                      label: '데모 요청',
                      icon: Icons.play_circle_outline,
                      onPressed: () => _openEmail('데모 요청'),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _homeKey,
                  child: _HeroSection(
                    animation: _pulseController,
                    onDemo: () => _openEmail('데모 요청'),
                    onConsult: () => _openEmail('상담 문의'),
                    onExplore: () => _scrollTo(_previewKey),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _introKey,
                  child: const _IntroSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _featuresKey,
                  child: const _FeatureSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _architectureKey,
                  child: const _ArchitectureSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _previewKey,
                  child: const _SoftwarePreviewSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _casesKey,
                  child: const _IndustryCaseSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _benefitsKey,
                  child: const _BenefitsSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _contactKey,
                  child: _ContactSection(
                    onDemo: () => _openEmail('데모 요청'),
                    onConsult: () => _openEmail('상담 문의'),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: _Footer()),
            ],
          ),
          IgnorePointer(
            ignoring: !_loading,
            child: AnimatedOpacity(
              opacity: _loading ? 1 : 0,
              duration: const Duration(milliseconds: 450),
              child: const _LoadingOverlay(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [PromoColors.electricBlue, PromoColors.cyan],
            ),
            boxShadow: [
              BoxShadow(
                color: PromoColors.electricBlue.withValues(alpha: 0.36),
                blurRadius: 22,
              ),
            ],
          ),
          child: const Icon(Icons.factory, color: Colors.white, size: 19),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              '소통웨어',
              style: TextStyle(
                color: PromoColors.textOnDark,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 1),
            Text(
              'Factory Monitoring Platform',
              style: TextStyle(
                color: PromoColors.cyan,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton(this.label, this.onPressed);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: PromoColors.textMutedOnDark,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.animation,
    required this.onDemo,
    required this.onConsult,
    required this.onExplore,
  });

  final Animation<double> animation;
  final VoidCallback onDemo;
  final VoidCallback onConsult;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 1060;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isWide ? 830 : 980),
      decoration: const BoxDecoration(color: PromoColors.deepNavy),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return CustomPaint(
                  painter: _SmartFactoryBackgroundPainter(animation.value),
                );
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    PromoColors.deepNavy.withValues(alpha: 0.92),
                    PromoColors.deepNavy.withValues(alpha: 0.68),
                    const Color(0xFF020611).withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),
          _SectionShell(
            top: isWide ? 90 : 60,
            bottom: 70,
            child: _FadeIn(
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 11,
                          child: _HeroCopy(
                            onDemo: onDemo,
                            onConsult: onConsult,
                            onExplore: onExplore,
                          ),
                        ),
                        const SizedBox(width: 44),
                        const Expanded(
                          flex: 10,
                          child: _LiveDashboardShowcase(),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroCopy(
                          onDemo: onDemo,
                          onConsult: onConsult,
                          onExplore: onExplore,
                        ),
                        const SizedBox(height: 34),
                        const _LiveDashboardShowcase(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.onDemo,
    required this.onConsult,
    required this.onExplore,
  });

  final VoidCallback onDemo;
  final VoidCallback onConsult;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 1100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusPill(
          label: 'ENTERPRISE INDUSTRIAL AUTOMATION PLATFORM',
          icon: Icons.hexagon_outlined,
        ),
        const SizedBox(height: 30),
        Text(
          '소통웨어\n산업자동화 모니터링 시스템',
          style: TextStyle(
            color: PromoColors.textOnDark,
            fontSize: isDesktop ? 68 : 44,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -2.4,
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: const Text(
            '실시간 설비 모니터링, 데이터 수집, AI 분석, 예지보전, MES/PLC/SCADA 연동을 하나의 운영 플랫폼으로 통합합니다.',
            style: TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 20,
              height: 1.72,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _KeywordChip('실시간 설비 모니터링'),
            _KeywordChip('데이터 수집'),
            _KeywordChip('AI 분석'),
            _KeywordChip('예지보전'),
            _KeywordChip('MES 연동'),
            _KeywordChip('PLC 연동'),
            _KeywordChip('SCADA'),
            _KeywordChip('Factory Monitoring Platform'),
          ],
        ),
        const SizedBox(height: 38),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _ActionButton(
              label: '데모 요청',
              icon: Icons.play_arrow_rounded,
              onPressed: onDemo,
              large: true,
            ),
            _GhostButton(
              label: '상담 문의',
              icon: Icons.support_agent,
              onPressed: onConsult,
              large: true,
            ),
            _GhostButton(
              label: '소프트웨어 화면 보기',
              icon: Icons.dashboard_customize_outlined,
              onPressed: onExplore,
              large: true,
            ),
          ],
        ),
        const SizedBox(height: 44),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _HeroMetric(value: '24/7', label: '라인 관제'),
            _HeroMetric(value: 'OPC UA', label: '표준 통신'),
            _HeroMetric(value: 'AI', label: '이상 예측'),
          ],
        ),
      ],
    );
  }
}

class _LiveDashboardShowcase extends StatelessWidget {
  const _LiveDashboardShowcase();

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: EdgeInsets.zero,
      borderColor: PromoColors.electricBlue.withValues(alpha: 0.5),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 620),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: PromoColors.cardBg.withValues(alpha: 0.9),
          boxShadow: [
            BoxShadow(
              color: PromoColors.electricBlue.withValues(alpha: 0.18),
              blurRadius: 50,
              offset: const Offset(0, 24),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const _TrafficLights(),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'SOTONG / Plant A / Line 03 Command Center',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: PromoColors.textOnDark,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: PromoColors.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: PromoColors.success.withValues(alpha: 0.45),
                        ),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: PromoColors.success,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.1,
                      children: const [
                        _MiniMetricCard(
                          label: '설비가동률',
                          value: '94.8%',
                          color: PromoColors.success,
                          icon: Icons.precision_manufacturing,
                        ),
                        _MiniMetricCard(
                          label: '생산량',
                          value: '12,840',
                          color: PromoColors.cyan,
                          icon: Icons.inventory_2_outlined,
                        ),
                        _MiniMetricCard(
                          label: 'Alarm',
                          value: '03',
                          color: PromoColors.alarm,
                          icon: Icons.warning_amber_rounded,
                        ),
                        _MiniMetricCard(
                          label: '전력사용량',
                          value: '418 kW',
                          color: PromoColors.warning,
                          icon: Icons.bolt,
                        ),
                        _MiniMetricCard(
                          label: 'OEE',
                          value: '88.6%',
                          color: PromoColors.electricBlue,
                          icon: Icons.donut_large,
                        ),
                        _MiniMetricCard(
                          label: 'Temperature',
                          value: '36.8C',
                          color: PromoColors.warning,
                          icon: Icons.thermostat,
                        ),
                        _MiniMetricCard(
                          label: 'Pressure',
                          value: '6.4 bar',
                          color: PromoColors.cyan,
                          icon: Icons.speed,
                        ),
                        _MiniMetricCard(
                          label: 'Cycle Time',
                          value: '42.1s',
                          color: PromoColors.success,
                          icon: Icons.timer_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          flex: 7,
                          child: _DashboardPanel(
                            title: 'Real-time Throughput',
                            child: SizedBox(height: 156, child: _LineChart()),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 4,
                          child: _DashboardPanel(
                            title: 'Quality',
                            child: SizedBox(height: 156, child: _DonutChart()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: _DashboardPanel(
                            title: 'OEE Gauge',
                            child: SizedBox(height: 138, child: _GaugeChart()),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _DashboardPanel(
                            title: 'Energy Bar',
                            child: SizedBox(height: 138, child: _BarChart()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Expanded(flex: 4, child: _MachineImagePanel()),
                        SizedBox(width: 12),
                        Expanded(flex: 5, child: _AlarmListPanel()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: 'SYSTEM INTRODUCTION',
            title: '현장 장비부터 경영 시스템까지 연결되는 산업 데이터 허브',
            subtitle:
                'CNC, Robot, Conveyor, PLC, 품질 검사 장비와 상위 MES/ERP를 연결해 생산 현장의 상태, 이력, 알람, 에너지 데이터를 실시간으로 관제합니다.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 980;
              final cards = const [
                _IntroCard(
                  icon: Icons.settings_input_component,
                  title: 'Field Connectivity',
                  description:
                      'PLC, Modbus TCP, OPC UA, MQTT, SQL 기반의 다중 통신 구조',
                ),
                _IntroCard(
                  icon: Icons.analytics_outlined,
                  title: 'Operations Intelligence',
                  description: 'OEE, Cycle Time, Alarm, 품질 지표를 한 화면에서 상관 분석',
                ),
                _IntroCard(
                  icon: Icons.auto_awesome,
                  title: 'AI Predictive Layer',
                  description: '온도, 압력, 진동, 전력 데이터를 기반으로 이상 징후를 조기 탐지',
                ),
              ];

              final cardColumn = Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    if (card != cards.last) const SizedBox(height: 16),
                  ],
                ],
              );

              if (isWide) {
                return Row(
                  children: [
                    const Expanded(flex: 6, child: _ControlRoomCard()),
                    const SizedBox(width: 24),
                    Expanded(flex: 5, child: cardColumn),
                  ],
                );
              }

              return Column(
                children: [
                  const _ControlRoomCard(),
                  const SizedBox(height: 18),
                  cardColumn,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection();

  static const features = [
    _IconSpec(
      '실시간 모니터링',
      'Live data acquisition',
      Icons.monitor_heart_outlined,
    ),
    _IconSpec('AI 분석', 'Anomaly & prediction', Icons.auto_graph),
    _IconSpec('예지보전', 'Predictive maintenance', Icons.build_circle_outlined),
    _IconSpec('설비관리', 'Asset lifecycle', Icons.precision_manufacturing),
    _IconSpec('생산관리', 'Production control', Icons.fact_check_outlined),
    _IconSpec('품질관리', 'SPC & traceability', Icons.verified_outlined),
    _IconSpec('알람관리', 'Alarm workflow', Icons.notification_important_outlined),
    _IconSpec('에너지관리', 'Power monitoring', Icons.energy_savings_leaf_outlined),
    _IconSpec('MES 연동', 'Order & result sync', Icons.hub_outlined),
    _IconSpec('PLC 통신', 'Machine signal I/O', Icons.memory),
    _IconSpec('Modbus TCP', 'Industrial protocol', Icons.lan),
    _IconSpec('OPC UA', 'Standard interface', Icons.account_tree),
    _IconSpec('MQTT', 'Message broker', Icons.sensors),
    _IconSpec('SQL', 'Data warehouse', Icons.storage),
    _IconSpec('Report', 'Auto reporting', Icons.summarize_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: const Color(0xFF07101D),
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: 'CORE CAPABILITIES',
            title: '핵심 기능',
            subtitle:
                '현장 설비, 생산, 품질, 에너지, 알람, 리포트를 하나의 통합 화면에서 운영할 수 있도록 구성했습니다.',
          ),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 1120
                  ? 5
                  : constraints.maxWidth > 820
                  ? 3
                  : constraints.maxWidth > 560
                  ? 2
                  : 1;
              final gap = columns == 1 ? 14.0 : 16.0;
              final width =
                  (constraints.maxWidth - (columns - 1) * gap) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final feature in features)
                    SizedBox(
                      width: width,
                      child: _FeatureTile(feature: feature),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ArchitectureSection extends StatelessWidget {
  const _ArchitectureSection();

  static const layers = [
    _ArchitectureLayer(
      label: 'FIELD & MACHINE',
      nodes: [
        _IconSpec('PLC', 'I/O Signal', Icons.memory),
        _IconSpec('Field Network', 'Ethernet / Serial', Icons.cable),
        _IconSpec('Robot / CNC', 'Machine Data', Icons.smart_toy_outlined),
      ],
    ),
    _ArchitectureLayer(
      label: 'DATA PLATFORM',
      nodes: [
        _IconSpec('Data Collector', 'Protocol Gateway', Icons.sensors),
        _IconSpec('Application Server', 'Business Logic', Icons.dns_outlined),
        _IconSpec('Database', 'History / Trend', Icons.storage),
        _IconSpec(
          'AI Engine',
          'Prediction Model',
          Icons.psychology_alt_outlined,
        ),
      ],
    ),
    _ArchitectureLayer(
      label: 'OPERATIONS UI',
      nodes: [
        _IconSpec('Web Dashboard', 'Control Room', Icons.dashboard_customize),
        _IconSpec('Mobile', 'Remote Check', Icons.phone_iphone),
        _IconSpec('Report', 'PDF / Excel', Icons.summarize_outlined),
        _IconSpec('Notification', 'Alarm Push', Icons.campaign_outlined),
      ],
    ),
    _ArchitectureLayer(
      label: 'ENTERPRISE & CLOUD',
      nodes: [
        _IconSpec('MES', 'Production Order', Icons.hub_outlined),
        _IconSpec('ERP', 'Business Link', Icons.apartment),
        _IconSpec('Cloud', 'Scalable Infra', Icons.cloud_queue),
        _IconSpec('AI Analysis', 'Optimization', Icons.auto_awesome),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: 'PROFESSIONAL ARCHITECTURE DIAGRAM',
            title: '시스템 구성도',
            subtitle:
                'PLC와 Field Network에서 수집된 현장 데이터가 Collector, Application Server, Database, AI Engine을 거쳐 Web/Mobile/Report/MES/ERP/Cloud로 확장되는 구조입니다.',
          ),
          const SizedBox(height: 48),
          _HoverGlowCard(
            padding: const EdgeInsets.all(24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 760;
                return Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _ArchitectureBackgroundPainter(),
                      ),
                    ),
                    Column(
                      children: [
                        for (var i = 0; i < layers.length; i++) ...[
                          _ArchitectureLayerView(
                            layer: layers[i],
                            compact: compact,
                          ),
                          if (i < layers.length - 1)
                            _ArchitectureArrow(compact: compact),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftwarePreviewSection extends StatelessWidget {
  const _SoftwarePreviewSection();

  static const previews = [
    _PreviewSpec(
      'Dashboard',
      Icons.dashboard_customize,
      PromoColors.electricBlue,
    ),
    _PreviewSpec('Alarm', Icons.warning_amber_rounded, PromoColors.alarm),
    _PreviewSpec('Trend', Icons.show_chart, PromoColors.cyan),
    _PreviewSpec('Report', Icons.summarize_outlined, PromoColors.success),
    _PreviewSpec(
      'Production',
      Icons.precision_manufacturing,
      PromoColors.warning,
    ),
    _PreviewSpec('Recipe', Icons.tune, PromoColors.purple),
    _PreviewSpec('SPC', Icons.query_stats, PromoColors.cyan),
    _PreviewSpec('History', Icons.history, PromoColors.electricBlue),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: const Color(0xFF07101D),
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: 'SOFTWARE SCREEN PREVIEW',
            title: '소프트웨어 미리보기',
            subtitle:
                '실제 산업자동화 모니터링 프로그램처럼 대시보드, 알람, 트렌드, 리포트, 생산, 레시피, SPC, 이력 화면을 구성했습니다.',
          ),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 1180
                  ? 4
                  : constraints.maxWidth > 760
                  ? 2
                  : 1;
              const gap = 18.0;
              final width =
                  (constraints.maxWidth - (columns - 1) * gap) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < previews.length; i++)
                    SizedBox(
                      width: width,
                      child: _SoftwarePreviewCard(
                        preview: previews[i],
                        index: i,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _IndustryCaseSection extends StatelessWidget {
  const _IndustryCaseSection();

  static const industries = [
    _IconSpec('자동차', 'Assembly / EOL', Icons.directions_car),
    _IconSpec('반도체', 'Equipment FAB', Icons.memory),
    _IconSpec('배터리', 'Cell / Module', Icons.battery_charging_full),
    _IconSpec('식품', 'HACCP Line', Icons.restaurant),
    _IconSpec('제약', 'GMP Process', Icons.medication_outlined),
    _IconSpec('철강', 'Mill Operation', Icons.factory),
    _IconSpec('화학', 'Process Plant', Icons.science_outlined),
    _IconSpec('물류', 'Conveyor / Sorter', Icons.local_shipping_outlined),
    _IconSpec('에너지', 'Power Facility', Icons.bolt),
    _IconSpec('전자', 'SMT / Test', Icons.devices_other),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: 'INDUSTRY APPLICATIONS',
            title: '적용사례',
            subtitle:
                '자동차, 반도체, 배터리, 식품, 제약, 철강, 화학, 물류, 에너지, 전자 산업의 생산/검사/설비 데이터를 통합합니다.',
          ),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 1080
                  ? 5
                  : constraints.maxWidth > 760
                  ? 3
                  : constraints.maxWidth > 520
                  ? 2
                  : 1;
              const gap = 16.0;
              final width =
                  (constraints.maxWidth - (columns - 1) * gap) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final item in industries)
                    SizedBox(
                      width: width,
                      child: _IndustryCard(item: item),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 34),
          const _CaseStrip(),
        ],
      ),
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  const _BenefitsSection();

  static const benefits = [
    _BenefitSpec('설비가동률', '20~30%', Icons.trending_up, PromoColors.success),
    _BenefitSpec(
      '생산성',
      '15~25%',
      Icons.rocket_launch_outlined,
      PromoColors.cyan,
    ),
    _BenefitSpec(
      '불량감소',
      '10~20%',
      Icons.verified_outlined,
      PromoColors.electricBlue,
    ),
    _BenefitSpec(
      '유지보수비',
      '20~40%',
      Icons.savings_outlined,
      PromoColors.warning,
    ),
    _BenefitSpec('다운타임', '30%', Icons.timer_off_outlined, PromoColors.alarm),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: const Color(0xFF07101D),
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: 'BUSINESS IMPACT',
            title: '도입 효과',
            subtitle:
                '현장 데이터의 실시간 가시화와 분석 자동화를 통해 설비 운영 효율, 생산성, 품질, 유지보수 비용을 동시에 개선합니다.',
          ),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 1060
                  ? 5
                  : constraints.maxWidth > 760
                  ? 3
                  : constraints.maxWidth > 520
                  ? 2
                  : 1;
              const gap = 16.0;
              final width =
                  (constraints.maxWidth - (columns - 1) * gap) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final benefit in benefits)
                    SizedBox(
                      width: width,
                      child: _BenefitCard(benefit: benefit),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({required this.onDemo, required this.onConsult});

  final VoidCallback onDemo;
  final VoidCallback onConsult;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: PromoColors.deepNavy,
      child: _HoverGlowCard(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 46),
        borderColor: PromoColors.cyan.withValues(alpha: 0.42),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _CtaCircuitPainter())),
            Column(
              children: [
                const _StatusPill(
                  label: 'REQUEST A DEMO',
                  icon: Icons.rocket_launch_outlined,
                ),
                const SizedBox(height: 22),
                const Text(
                  '지금 바로\n소통웨어 산업자동화 모니터링 시스템을 경험해보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 42,
                    height: 1.22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.4,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '현장의 PLC, 설비, 생산, 품질, 알람 데이터를 연결해 대기업 SI 수준의 통합 관제 환경을 설계합니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 17,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 34),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    _ActionButton(
                      label: '데모 요청',
                      icon: Icons.play_arrow_rounded,
                      onPressed: onDemo,
                      large: true,
                    ),
                    _GhostButton(
                      label: '상담 문의',
                      icon: Icons.support_agent,
                      onPressed: onConsult,
                      large: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  PromoContact.email,
                  style: const TextStyle(
                    color: PromoColors.cyan,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF040914),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      child: const Center(
        child: Text(
          'SOTONGWARE INDUSTRIAL AUTOMATION MONITORING SYSTEM  |  PLC  MES  SCADA  AI  CLOUD',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: PromoColors.textMutedOnDark,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.child,
    this.background,
    this.top,
    this.bottom,
  });

  final Widget child;
  final Color? background;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      color: background ?? PromoColors.deepNavy,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              width > 760 ? 48 : 22,
              top ?? (width > 760 ? 92 : 58),
              width > 760 ? 48 : 22,
              bottom ?? (width > 760 ? 92 : 58),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;
    return Column(
      children: [
        _StatusPill(label: eyebrow, icon: Icons.grid_view_rounded),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PromoColors.textOnDark,
              fontSize: isWide ? 42 : 30,
              height: 1.22,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 16,
              height: 1.72,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: PromoColors.electricBlue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: PromoColors.cyan.withValues(alpha: 0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: PromoColors.cyan, size: 15),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: PromoColors.cyan,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeywordChip extends StatelessWidget {
  const _KeywordChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.13)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: PromoColors.textOnDark,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.large = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool large;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.035 : 1,
        duration: const Duration(milliseconds: 160),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: widget.large ? 21 : 18),
          label: Text(widget.label),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: PromoColors.electricBlue,
            shadowColor: PromoColors.electricBlue.withValues(alpha: 0.5),
            elevation: _hovered ? 12 : 6,
            minimumSize: Size(widget.large ? 168 : 132, widget.large ? 54 : 42),
            padding: EdgeInsets.symmetric(
              horizontal: widget.large ? 24 : 16,
              vertical: widget.large ? 16 : 11,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  const _GhostButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.large = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool large;

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: PromoColors.cyan.withValues(alpha: 0.18),
                    blurRadius: 24,
                  ),
                ]
              : null,
        ),
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: widget.large ? 21 : 18),
          label: Text(widget.label),
          style: OutlinedButton.styleFrom(
            foregroundColor: PromoColors.textOnDark,
            side: BorderSide(
              color: _hovered ? PromoColors.cyan : PromoColors.blueStroke,
            ),
            minimumSize: Size(widget.large ? 168 : 132, widget.large ? 54 : 42),
            padding: EdgeInsets.symmetric(
              horizontal: widget.large ? 24 : 16,
              vertical: widget.large ? 16 : 11,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: PromoColors.textOnDark,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverGlowCard extends StatefulWidget {
  const _HoverGlowCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderColor,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? borderColor;

  @override
  State<_HoverGlowCard> createState() => _HoverGlowCardState();
}

class _HoverGlowCardState extends State<_HoverGlowCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _hovered ? -4.0 : 0.0, 0.0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: PromoColors.cardBg.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? PromoColors.cyan.withValues(alpha: 0.62)
                : (widget.borderColor ??
                      PromoColors.blueStroke.withValues(alpha: 0.55)),
          ),
          boxShadow: [
            BoxShadow(
              color: (_hovered ? PromoColors.electricBlue : Colors.black)
                  .withValues(alpha: _hovered ? 0.18 : 0.22),
              blurRadius: _hovered ? 38 : 24,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

class _FadeIn extends StatelessWidget {
  const _FadeIn({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 950),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 22 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}

class _TrafficLights extends StatelessWidget {
  const _TrafficLights();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Dot(PromoColors.alarm),
        SizedBox(width: 6),
        _Dot(PromoColors.warning),
        SizedBox(width: 6),
        _Dot(PromoColors.success),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.55), blurRadius: 8),
        ],
      ),
    );
  }
}

class _MiniMetricCard extends StatelessWidget {
  const _MiniMetricCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1629),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const Spacer(),
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: PromoColors.textOnDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: PromoColors.textMutedOnDark,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardPanel extends StatelessWidget {
  const _DashboardPanel({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF071224),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _MachineImagePanel extends StatelessWidget {
  const _MachineImagePanel();

  @override
  Widget build(BuildContext context) {
    return const _DashboardPanel(
      title: 'Machine Image',
      child: SizedBox(height: 136, child: _MachinePainterBox()),
    );
  }
}

class _AlarmListPanel extends StatelessWidget {
  const _AlarmListPanel();

  @override
  Widget build(BuildContext context) {
    return _DashboardPanel(
      title: 'Alarm List',
      child: Column(
        children: const [
          _AlarmRow(
            '11:24:03',
            'CNC-02 Spindle load high',
            PromoColors.warning,
          ),
          _AlarmRow('11:23:41', 'Robot-07 cycle delay', PromoColors.alarm),
          _AlarmRow('11:22:08', 'Conveyor speed restored', PromoColors.success),
          _AlarmRow('11:21:35', 'PLC heartbeat normal', PromoColors.cyan),
        ],
      ),
    );
  }
}

class _AlarmRow extends StatelessWidget {
  const _AlarmRow(this.time, this.text, this.color);

  final String time;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(
              color: PromoColors.textMutedOnDark.withValues(alpha: 0.72),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: PromoColors.textOnDark,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlRoomCard extends StatelessWidget {
  const _ControlRoomCard();

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.grid_view_rounded, color: PromoColors.cyan, size: 22),
              SizedBox(width: 10),
              Text(
                'Integrated Control Room',
                style: TextStyle(
                  color: PromoColors.textOnDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SizedBox(height: 240, child: _FactoryTopologyMiniMap()),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _ControlStat(label: 'Connected Machines', value: '128'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ControlStat(label: 'Data Points / sec', value: '42K'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ControlStat(label: 'AI Alerts', value: '7'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: PromoColors.electricBlue.withValues(alpha: 0.12),
              border: Border.all(
                color: PromoColors.cyan.withValues(alpha: 0.18),
              ),
            ),
            child: Icon(icon, color: PromoColors.cyan),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 14,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlStat extends StatelessWidget {
  const _ControlStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF071224),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: PromoColors.textOnDark,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.feature});

  final _IconSpec feature;

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  PromoColors.electricBlue.withValues(alpha: 0.2),
                  PromoColors.cyan.withValues(alpha: 0.08),
                ],
              ),
            ),
            child: Icon(feature.icon, color: PromoColors.cyan, size: 24),
          ),
          const SizedBox(height: 18),
          Text(
            feature.title,
            style: const TextStyle(
              color: PromoColors.textOnDark,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            feature.subtitle,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchitectureLayerView extends StatelessWidget {
  const _ArchitectureLayerView({required this.layer, required this.compact});

  final _ArchitectureLayer layer;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF071224).withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            layer.label,
            style: const TextStyle(
              color: PromoColors.cyan,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final node in layer.nodes)
                SizedBox(
                  width: compact ? 260 : 190,
                  child: _ArchitectureNodeCard(node: node),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArchitectureNodeCard extends StatelessWidget {
  const _ArchitectureNodeCard({required this.node});

  final _IconSpec node;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: PromoColors.cardBg,
        border: Border.all(
          color: PromoColors.blueStroke.withValues(alpha: 0.65),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: PromoColors.electricBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(node.icon, color: PromoColors.cyan, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  node.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  node.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchitectureArrow extends StatelessWidget {
  const _ArchitectureArrow({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Container(
            width: 2,
            height: compact ? 28 : 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [PromoColors.electricBlue, PromoColors.cyan],
              ),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: PromoColors.cyan,
            size: 28,
          ),
        ],
      ),
    );
  }
}

class _SoftwarePreviewCard extends StatelessWidget {
  const _SoftwarePreviewCard({required this.preview, required this.index});

  final _PreviewSpec preview;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: EdgeInsets.zero,
      borderColor: preview.color.withValues(alpha: 0.28),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 205,
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF101F37), Color(0xFF071224)],
                ),
              ),
              child: _PreviewScreen(spec: preview, index: index),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Icon(preview.icon, color: preview.color, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    preview.title,
                    style: const TextStyle(
                      color: PromoColors.textOnDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward,
                    color: PromoColors.textMutedOnDark,
                    size: 18,
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

class _PreviewScreen extends StatelessWidget {
  const _PreviewScreen({required this.spec, required this.index});

  final _PreviewSpec spec;
  final int index;

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
                Expanded(
                  child: Text(
                    '${spec.title.toUpperCase()} / PLANT OPS',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: PromoColors.textMutedOnDark,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var i = 0; i < 4; i++)
                          Icon(
                            i == index % 4 ? spec.icon : Icons.circle,
                            color: i == index % 4
                                ? spec.color
                                : Colors.white.withValues(alpha: 0.2),
                            size: i == index % 4 ? 18 : 8,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _PreviewBlock(
                                  color: spec.color,
                                  tall: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: _PreviewBlock(color: spec.color),
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: _PreviewBlock(
                                        color: PromoColors.cyan,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 42,
                          child: Row(
                            children: [
                              for (var i = 0; i < 5; i++) ...[
                                Expanded(
                                  child: _PreviewBar(
                                    color: i == index % 5
                                        ? spec.color
                                        : PromoColors.blueStroke,
                                  ),
                                ),
                                if (i < 4) const SizedBox(width: 6),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({required this.color, this.tall = false});

  final Color color;
  final bool tall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: CustomPaint(
        painter: tall ? _MiniTrendPainter(color) : _MiniBarsPainter(color),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _PreviewBar extends StatelessWidget {
  const _PreviewBar({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
    );
  }
}

class _IndustryCard extends StatelessWidget {
  const _IndustryCard({required this.item});

  final _IconSpec item;

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: PromoColors.cyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(item.icon, color: PromoColors.cyan, size: 23),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseStrip extends StatelessWidget {
  const _CaseStrip();

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          const copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Representative Deployment Scenario',
                style: TextStyle(
                  color: PromoColors.cyan,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '자동차 부품 조립라인 통합 관제',
                style: TextStyle(
                  color: PromoColors.textOnDark,
                  fontSize: 26,
                  height: 1.25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '체결툴, 바코드, PLC, MES, 품질 검사 데이터를 연결해 작업순서, OK/NG, Cycle Time, Alarm 이력을 통합합니다.',
                style: TextStyle(
                  color: PromoColors.textMutedOnDark,
                  fontSize: 15,
                  height: 1.65,
                ),
              ),
            ],
          );
          const topology = SizedBox(
            height: 210,
            child: _FactoryTopologyMiniMap(),
          );

          if (isWide) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: copy),
                SizedBox(width: 24),
                Expanded(flex: 6, child: topology),
              ],
            );
          }

          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [copy, SizedBox(height: 20), topology],
          );
        },
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.benefit});

  final _BenefitSpec benefit;

  @override
  Widget build(BuildContext context) {
    final number =
        double.tryParse(benefit.value.replaceAll(RegExp('[^0-9]'), '')) ?? 0;
    return _HoverGlowCard(
      padding: const EdgeInsets.all(22),
      borderColor: benefit.color.withValues(alpha: 0.28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(benefit.icon, color: benefit.color, size: 30),
          const SizedBox(height: 22),
          Text(
            benefit.title,
            style: const TextStyle(
              color: PromoColors.textOnDark,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 0, end: number),
            builder: (context, value, _) {
              final label = benefit.value.contains('~')
                  ? benefit.value
                  : '${value.round()}%';
              return Text(
                label,
                style: TextStyle(
                  color: benefit.color,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: math.min(number / 40, 1),
              minHeight: 7,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation<Color>(benefit.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PromoColors.deepNavy,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 850),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, _) {
                return Transform.rotate(
                  angle: value * math.pi * 2,
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: PromoColors.cyan.withValues(alpha: 0.18),
                        width: 7,
                      ),
                    ),
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 3,
                      color: PromoColors.cyan,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            const Text(
              'INITIALIZING FACTORY MONITORING PLATFORM',
              style: TextStyle(
                color: PromoColors.cyan,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconSpec {
  const _IconSpec(this.title, this.subtitle, this.icon);

  final String title;
  final String subtitle;
  final IconData icon;
}

class _PreviewSpec {
  const _PreviewSpec(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final Color color;
}

class _ArchitectureLayer {
  const _ArchitectureLayer({required this.label, required this.nodes});

  final String label;
  final List<_IconSpec> nodes;
}

class _BenefitSpec {
  const _BenefitSpec(this.title, this.value, this.icon, this.color);

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}

class _SmartFactoryBackgroundPainter extends CustomPainter {
  _SmartFactoryBackgroundPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF08111F), Color(0xFF0B1830), Color(0xFF030713)],
        ).createShader(rect),
    );

    final gridPaint = Paint()
      ..color = PromoColors.cyan.withValues(alpha: 0.045)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 72) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y < size.height; y += 72) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              PromoColors.electricBlue.withValues(alpha: 0.23),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(
                size.width * (0.74 + math.sin(t * math.pi * 2) * 0.04),
                size.height * 0.32,
              ),
              radius: size.width * 0.34,
            ),
          );
    canvas.drawRect(rect, glowPaint);

    final floorY = size.height * 0.73;
    final machinePaint = Paint()
      ..color = const Color(0xFF12213A).withValues(alpha: 0.82);
    final edgePaint = Paint()
      ..color = PromoColors.cyan.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (var i = 0; i < 8; i++) {
      final x = size.width * (0.06 + i * 0.12);
      final h = 72.0 + (i % 3) * 22;
      final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, floorY - h, 74, h),
        const Radius.circular(8),
      );
      canvas.drawRRect(r, machinePaint);
      canvas.drawRRect(r, edgePaint);
      canvas.drawCircle(
        Offset(x + 18, floorY - h + 18),
        5,
        Paint()..color = PromoColors.success.withValues(alpha: 0.75),
      );
      canvas.drawCircle(
        Offset(x + 35, floorY - h + 18),
        5,
        Paint()..color = PromoColors.warning.withValues(alpha: 0.65),
      );
    }

    final conveyorPaint = Paint()
      ..color = const Color(0xFF172946).withValues(alpha: 0.78)
      ..style = PaintingStyle.fill;
    final conveyor = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.04, floorY + 18, size.width * 0.82, 28),
      const Radius.circular(999),
    );
    canvas.drawRRect(conveyor, conveyorPaint);

    final networkPaint = Paint()
      ..color = PromoColors.cyan.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (var i = 0; i < 9; i++) {
      final start = Offset(
        size.width * (0.12 + i * 0.09),
        floorY - 76 - (i % 2) * 36,
      );
      final end = Offset(
        size.width * (0.52 + math.sin(i) * 0.24),
        size.height * (0.14 + (i % 4) * 0.08),
      );
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(
          start.dx + 40,
          start.dy - 80,
          end.dx - 90,
          end.dy + 80,
          end.dx,
          end.dy,
        );
      canvas.drawPath(path, networkPaint);
      canvas.drawCircle(
        end,
        3.5,
        Paint()..color = PromoColors.cyan.withValues(alpha: 0.54),
      );
    }

    final robotPaint = Paint()
      ..color = PromoColors.electricBlue.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final base = Offset(size.width * 0.18, floorY - 18);
    canvas.drawLine(base, base.translate(34, -70), robotPaint);
    canvas.drawLine(
      base.translate(34, -70),
      base.translate(90, -112),
      robotPaint,
    );
    canvas.drawLine(
      base.translate(90, -112),
      base.translate(124, -80),
      robotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SmartFactoryBackgroundPainter oldDelegate) {
    return oldDelegate.t != t;
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    for (var i = 1; i < 5; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final values = [0.62, 0.44, 0.52, 0.39, 0.56, 0.35, 0.48, 0.31, 0.46, 0.28];
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final p = Offset(
        size.width * i / (values.length - 1),
        size.height * values[i],
      );
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = PromoColors.cyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    for (var i = 0; i < values.length; i++) {
      final p = Offset(
        size.width * i / (values.length - 1),
        size.height * values[i],
      );
      canvas.drawCircle(p, 3.5, Paint()..color = PromoColors.electricBlue);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DonutChart extends StatelessWidget {
  const _DonutChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DonutChartPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.36;
    const segments = [
      (0.76, PromoColors.success),
      (0.14, PromoColors.warning),
      (0.10, PromoColors.alarm),
    ];
    var start = -math.pi / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;
    for (final segment in segments) {
      paint.color = segment.$2;
      final sweep = math.pi * 2 * segment.$1;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep - 0.08,
        false,
        paint,
      );
      start += sweep;
    }
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '98.2%\nOK',
        style: TextStyle(
          color: PromoColors.textOnDark,
          fontSize: 17,
          fontWeight: FontWeight.w900,
          height: 1.25,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GaugeChart extends StatelessWidget {
  const _GaugeChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GaugeChartPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _GaugeChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.88);
    final radius = math.min(size.width * 0.42, size.height * 0.78);
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.08);
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, math.pi, math.pi, false, base);
    canvas.drawArc(
      rect,
      math.pi,
      math.pi * 0.886,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round
        ..color = PromoColors.success,
    );
    final angle = math.pi + math.pi * 0.886;
    final needle = Offset(
      center.dx + math.cos(angle) * radius * 0.82,
      center.dy + math.sin(angle) * radius * 0.82,
    );
    canvas.drawLine(
      center,
      needle,
      Paint()
        ..color = PromoColors.cyan
        ..strokeWidth = 3,
    );
    canvas.drawCircle(center, 5, Paint()..color = PromoColors.cyan);
    final tp = TextPainter(
      text: const TextSpan(
        text: '88.6',
        style: TextStyle(
          color: PromoColors.textOnDark,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - radius * 0.65),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BarChartPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final values = [0.52, 0.68, 0.43, 0.75, 0.58, 0.86, 0.62];
    final barWidth = size.width / (values.length * 1.8);
    for (var i = 0; i < values.length; i++) {
      final h = size.height * values[i] * 0.82;
      final x = size.width * (i + 0.55) / values.length;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, size.height - h, barWidth, h),
        const Radius.circular(6),
      );
      final color = i == 5 ? PromoColors.warning : PromoColors.electricBlue;
      canvas.drawRRect(rect, Paint()..color = color.withValues(alpha: 0.85));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MachinePainterBox extends StatelessWidget {
  const _MachinePainterBox();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MachinePainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _MachinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final machine = Paint()..color = const Color(0xFF142745);
    final accent = Paint()..color = PromoColors.cyan.withValues(alpha: 0.8);
    final stroke = Paint()
      ..color = PromoColors.blueStroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final base = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.58,
        size.width * 0.84,
        size.height * 0.16,
      ),
      const Radius.circular(12),
    );
    canvas.drawRRect(base, machine);
    canvas.drawRRect(base, stroke);
    for (var i = 0; i < 3; i++) {
      final cell = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * (0.14 + i * 0.25),
          size.height * 0.28,
          size.width * 0.18,
          size.height * 0.28,
        ),
        const Radius.circular(10),
      );
      canvas.drawRRect(cell, machine);
      canvas.drawRRect(cell, stroke);
      canvas.drawCircle(
        Offset(size.width * (0.22 + i * 0.25), size.height * 0.42),
        8,
        accent,
      );
    }
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.24),
      Offset(size.width * 0.5, size.height * 0.1),
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.24),
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FactoryTopologyMiniMap extends StatelessWidget {
  const _FactoryTopologyMiniMap();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TopologyPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _TopologyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(20),
    );
    canvas.drawRRect(bg, Paint()..color = const Color(0xFF071224));
    final grid = Paint()
      ..color = PromoColors.cyan.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    for (var x = 20.0; x < size.width; x += 38) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 20.0; y < size.height; y += 38) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final points = [
      Offset(size.width * 0.16, size.height * 0.62),
      Offset(size.width * 0.32, size.height * 0.34),
      Offset(size.width * 0.52, size.height * 0.52),
      Offset(size.width * 0.68, size.height * 0.28),
      Offset(size.width * 0.84, size.height * 0.58),
    ];
    final line = Paint()
      ..color = PromoColors.electricBlue.withValues(alpha: 0.42)
      ..strokeWidth = 2;
    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], line);
    }
    for (var i = 0; i < points.length; i++) {
      final color = i == 3 ? PromoColors.warning : PromoColors.success;
      canvas.drawCircle(
        points[i],
        18,
        Paint()..color = color.withValues(alpha: 0.18),
      );
      canvas.drawCircle(points[i], 7, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ArchitectureBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PromoColors.electricBlue.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 44) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += 44) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CtaCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PromoColors.cyan.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (var i = 0; i < 8; i++) {
      final y = size.height * (0.15 + i * 0.1);
      final path = Path()
        ..moveTo(size.width * 0.06, y)
        ..lineTo(size.width * 0.28, y)
        ..quadraticBezierTo(size.width * 0.36, y, size.width * 0.42, y + 30)
        ..lineTo(size.width * 0.92, y + 30);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniTrendPainter extends CustomPainter {
  _MiniTrendPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final x = size.width * i / 7;
      final y =
          size.height * (0.62 - math.sin(i * 0.9) * 0.22 + (i % 2) * 0.05);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MiniTrendPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _MiniBarsPainter extends CustomPainter {
  _MiniBarsPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const vals = [0.3, 0.62, 0.46, 0.78, 0.54];
    final bar = size.width / 9;
    for (var i = 0; i < vals.length; i++) {
      final h = size.height * vals[i];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * (i + 0.7) / vals.length,
            size.height - h,
            bar,
            h,
          ),
          const Radius.circular(4),
        ),
        Paint()..color = color.withValues(alpha: 0.85),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MiniBarsPainter oldDelegate) =>
      oldDelegate.color != color;
}
