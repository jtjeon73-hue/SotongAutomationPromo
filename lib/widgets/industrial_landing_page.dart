import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/promo_contact.dart';
import '../theme/promo_theme.dart';
import 'software_preview_layouts.dart';
import 'sotong_control_hub_section.dart';

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
  final _expansionKey = GlobalKey();
  final _hubKey = GlobalKey();
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

  Future<void> _openHubInquiry() async {
    await launchUrl(PromoContact.hubInquiryUri());
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
    final viewportWidth = MediaQuery.sizeOf(context).width;

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
                titleSpacing: viewportWidth > 420 ? 24 : 14,
                title: const _BrandMark(),
                actions: [
                  if (viewportWidth > 1120) ...[
                    _NavButton('HOME', () => _scrollTo(_homeKey)),
                    _NavButton('시스템소개', () => _scrollTo(_introKey)),
                    _NavButton('핵심기능', () => _scrollTo(_featuresKey)),
                    _NavButton('시스템구성도', () => _scrollTo(_architectureKey)),
                    _NavButton('소프트웨어 화면', () => _scrollTo(_previewKey)),
                    _NavButton('개발 가능 분야', () => _scrollTo(_casesKey)),
                    _NavButton('도입효과', () => _scrollTo(_benefitsKey)),
                    _NavButton('소통총관제', () => _scrollTo(_hubKey)),
                    _NavButton('문의하기', _openHubInquiry),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(right: 24, left: 10),
                    child: _ActionButton(
                      label: '문의하기',
                      icon: Icons.mail_outline,
                      onPressed: _openHubInquiry,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _homeKey,
                  child: _HeroSection(
                    animation: _pulseController,
                    onInquiry: _openHubInquiry,
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
                child: _MidPageCta(onInquiry: _openHubInquiry),
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
                  key: _expansionKey,
                  child: const _FutureExpansionSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _hubKey,
                  child: SotongControlHubSection(onInquiry: _openHubInquiry),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _contactKey,
                  child: _ContactSection(onInquiry: _openHubInquiry),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact =
            constraints.maxWidth < 180 ||
            MediaQuery.sizeOf(context).width < 420;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 30 : 34,
              height: compact ? 30 : 34,
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
              child: Icon(
                Icons.factory,
                color: Colors.white,
                size: compact ? 17 : 19,
              ),
            ),
            SizedBox(width: compact ? 8 : 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '소통웨어',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: PromoColors.textOnDark,
                      fontSize: compact ? 16 : 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 1),
                    const Text(
                      '산업자동화 소프트웨어',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        color: PromoColors.cyan,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
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
    required this.onInquiry,
    required this.onExplore,
  });

  final Animation<double> animation;
  final VoidCallback onInquiry;
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
                            onInquiry: onInquiry,
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
                        _HeroCopy(onInquiry: onInquiry, onExplore: onExplore),
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
  const _HeroCopy({required this.onInquiry, required this.onExplore});

  final VoidCallback onInquiry;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 1100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusPill(
          label: '맞춤형 산업자동화 소프트웨어',
          icon: Icons.precision_manufacturing_outlined,
        ),
        const SizedBox(height: 30),
        Text(
          '현장 데이터를 연결하여\n제조·생산 업무를 더 편리하게',
          style: TextStyle(
            color: PromoColors.textOnDark,
            fontSize: isDesktop ? 52 : 34,
            height: 1.15,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.6,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: const Text(
            'PLC와 생산설비의 데이터를 현장 PC에서 수집하고, 모니터링·저장·조회할 수 있는 맞춤형 산업자동화 소프트웨어를 개발합니다.',
            style: TextStyle(
              color: PromoColors.cyan,
              fontSize: 18,
              height: 1.7,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: const Text(
            '생산설비마다 다른 작업 환경과 관리 방식을 분석하여 작업자에게는 편리한 화면을, 관리자에게는 체계적인 데이터 관리 환경을 제공합니다. 필요에 따라 MES, ERP 등 상위 시스템과 연계할 수 있도록 확장 가능한 구조로 개발합니다.',
            style: TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 16,
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
            _KeywordChip('PLC 연동'),
            _KeywordChip('설비 데이터 수집'),
            _KeywordChip('실시간 상태 표시'),
            _KeywordChip('생산 데이터 저장'),
            _KeywordChip('이력 조회'),
            _KeywordChip('작업자 편의성'),
            _KeywordChip('관리 효율 향상'),
            _KeywordChip('맞춤형 소프트웨어'),
            _KeywordChip('MES·ERP 연계 확장'),
          ],
        ),
        const SizedBox(height: 38),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _ActionButton(
              label: '문의하기',
              icon: Icons.mail_outline,
              onPressed: onInquiry,
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
            _HeroMetric(value: 'PLC', label: '설비 연동'),
            _HeroMetric(value: 'PC', label: '현장 수집·표시'),
            _HeroMetric(value: 'MES', label: '연계 확장'),
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
                        '현장 PC / 생산라인 모니터링 화면 예시',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: PromoColors.textOnDark,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          letterSpacing: 0.2,
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth > 520 ? 4 : 2;
                        return GridView.count(
                          crossAxisCount: columns,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: columns == 4 ? 1.1 : 1.25,
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
                        );
                      },
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
            eyebrow: '시스템 소개',
            title: '현장 설비 데이터를 모아 보기 쉽게 만들고 관리합니다',
            subtitle:
                'PLC와 생산설비에서 발생하는 데이터를 현장 PC에서 수집하고, 화면에 표시하며, 저장·조회할 수 있는 맞춤형 산업자동화 소프트웨어를 개발합니다.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 980;
              final cards = const [
                _IntroCard(
                  icon: Icons.settings_input_component,
                  title: '설비 데이터 수집',
                  description: 'PLC, 센서, 계측기, 체결기, 검사장비 데이터를 통신으로 수집합니다.',
                ),
                _IntroCard(
                  icon: Icons.desktop_windows_outlined,
                  title: '현장 모니터링',
                  description: '설비 상태, 생산 수량, 작업 결과, 경보를 작업자 화면으로 제공합니다.',
                ),
                _IntroCard(
                  icon: Icons.folder_shared_outlined,
                  title: '저장·조회·확장',
                  description: '생산·이력 데이터를 관리하고, 필요 시 MES·ERP와 연계할 수 있습니다.',
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
      'PLC·설비 데이터 연동',
      'PLC, 센서, 계측기, 체결기, 검사장비 등에서 발생하는 데이터를 통신을 통해 수집합니다.',
      Icons.settings_input_component,
    ),
    _IconSpec(
      '현장 모니터링 화면',
      '설비 상태, 생산 수량, 측정값, 작업 결과, 경보 상태를 작업자가 보기 쉬운 화면으로 제공합니다.',
      Icons.monitor_heart_outlined,
    ),
    _IconSpec(
      '데이터 저장 및 이력 조회',
      '수집된 생산정보와 설비 데이터를 저장하고 날짜, 설비, 제품, 작업 조건 등에 따라 조회합니다.',
      Icons.storage,
    ),
    _IconSpec(
      '작업 편의성 개선',
      '작업 순서 안내, 설정값 관리, 오류 메시지, 작업 결과 확인 등 현장 작업자가 쉽게 사용할 수 있는 기능을 구성합니다.',
      Icons.touch_app_outlined,
    ),
    _IconSpec(
      '생산·설비 관리 효율 향상',
      '관리자가 생산 현황과 설비 정보를 빠르게 확인하고, 누적된 이력을 관리할 수 있도록 지원합니다.',
      Icons.fact_check_outlined,
    ),
    _IconSpec(
      '맞춤형 시스템 개발',
      '업체별 설비 구성, 통신 방식, 생산 공정, 관리 항목에 맞추어 필요한 기능을 맞춤 개발합니다.',
      Icons.handyman_outlined,
    ),
    _IconSpec(
      '상위 시스템 연계 확장',
      '필요에 따라 MES, ERP, 사내 서버, 데이터베이스 등과 연계할 수 있도록 확장 가능한 구조를 적용합니다.',
      Icons.hub_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: const Color(0xFF07101D),
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: '핵심 기능',
            title: '제조 현장에 바로 도움이 되는 기능',
            subtitle:
                '데이터 수집부터 화면 표시, 저장·조회, 작업 편의, 관리 효율, 맞춤 개발, 상위 시스템 연계까지 단계적으로 구성합니다.',
          ),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 1120
                  ? 3
                  : constraints.maxWidth > 720
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
      label: '현장 장비',
      nodes: [
        _IconSpec('생산설비', '조립·가공 라인', Icons.precision_manufacturing),
        _IconSpec('센서', '상태·계측 신호', Icons.sensors),
        _IconSpec('계측기', '측정 데이터', Icons.speed),
        _IconSpec('체결기', '토크·각도', Icons.build),
        _IconSpec('검사장비', '측정·판정', Icons.center_focus_strong),
      ],
    ),
    _ArchitectureLayer(
      label: '제어·통신',
      nodes: [
        _IconSpec('PLC', '설비 제어', Icons.memory),
        _IconSpec('장비 컨트롤러', '장비 제어기', Icons.settings_input_component),
        _IconSpec('Modbus RTU/TCP', '산업 통신', Icons.lan),
        _IconSpec('Serial', '시리얼 통신', Icons.cable),
        _IconSpec('Ethernet', '네트워크', Icons.settings_ethernet),
      ],
    ),
    _ArchitectureLayer(
      label: '현장 PC 산업자동화 프로그램',
      nodes: [
        _IconSpec('실시간 데이터 수집', '설비 신호 수집', Icons.download_for_offline),
        _IconSpec('상태 모니터링', '설비·공정 상태', Icons.monitor_heart_outlined),
        _IconSpec('생산정보 표시', '수량·결과 표시', Icons.desktop_windows),
        _IconSpec('데이터 저장', 'CSV·DB 저장', Icons.save_outlined),
        _IconSpec('이력 조회', '조건별 검색', Icons.history),
        _IconSpec('경보·오류 표시', '이상 상태 안내', Icons.warning_amber_rounded),
      ],
    ),
    _ArchitectureLayer(
      label: '확장 영역 (필요 시 연계 개발)',
      nodes: [
        _IconSpec('MES', '생산관리 연계', Icons.hub_outlined),
        _IconSpec('ERP', '경영정보 연계', Icons.apartment),
        _IconSpec('사내 서버', '데이터 전송', Icons.dns_outlined),
        _IconSpec('데이터베이스', '통합 저장', Icons.storage),
        _IconSpec('생산관리 시스템', '상위 시스템', Icons.account_tree_outlined),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: '시스템 구성도',
            title: '현장 데이터가 흐르는 단순한 구조',
            subtitle:
                '생산설비 → PLC·컨트롤러 → 현장 PC 프로그램 → 표시·저장·조회 → 필요 시 MES·ERP 등으로 확장합니다.',
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

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: const Color(0xFF07101D),
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: '소프트웨어 화면 예시',
            title: '현장·관리 화면 구성 예시',
            subtitle:
                '모니터링, 경보, 트렌드, 생산 현황, 이력 조회 등 현장 PC와 관리 화면에서 구성할 수 있는 화면 예시입니다.',
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
                  for (final preview in SoftwarePreviewData.items)
                    SizedBox(
                      width: width,
                      child: _SoftwarePreviewCard(preview: preview),
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

class _MidPageCta extends StatelessWidget {
  const _MidPageCta({required this.onInquiry});

  final VoidCallback onInquiry;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    return _SectionShell(
      background: PromoColors.deepNavy,
      top: isWide ? 36 : 28,
      bottom: isWide ? 36 : 28,
      child: _HoverGlowCard(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 38 : 22,
          vertical: isWide ? 30 : 24,
        ),
        borderColor: PromoColors.electricBlue.withValues(alpha: 0.42),
        child: isWide
            ? Row(
                children: [
                  const Expanded(child: _MidPageCtaCopy()),
                  const SizedBox(width: 28),
                  _ActionButton(
                    label: '문의하기',
                    icon: Icons.mail_outline,
                    onPressed: onInquiry,
                    large: true,
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _MidPageCtaCopy(),
                  const SizedBox(height: 22),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _ActionButton(
                      label: '문의하기',
                      icon: Icons.mail_outline,
                      onPressed: onInquiry,
                      large: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _MidPageCtaCopy extends StatelessWidget {
  const _MidPageCtaCopy();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusPill(label: '개발 상담', icon: Icons.support_agent),
        const SizedBox(height: 16),
        Text(
          '현장 환경에 맞는 맞춤 개발을 상담해 보세요.',
          style: TextStyle(
            color: PromoColors.textOnDark,
            fontSize: isWide ? 32 : 26,
            height: 1.22,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '설비 구성과 업무 방식을 확인한 뒤, 수집·표시·저장·조회에 필요한 프로그램 방향을 제안드립니다.',
          style: TextStyle(
            color: PromoColors.textMutedOnDark,
            fontSize: 15,
            height: 1.65,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _IndustryCaseSection extends StatelessWidget {
  const _IndustryCaseSection();

  static const industries = [
    _IconSpec('PLC 생산 데이터 모니터링', '설비 신호·수량 표시', Icons.memory),
    _IconSpec('체결 토크·각도 결과 관리', '체결 결과·OK/NG', Icons.build),
    _IconSpec('검사장비 측정 데이터 수집', '측정값·판정 저장', Icons.center_focus_strong),
    _IconSpec('생산 수량·작업 실적 관리', '실적 기록·조회', Icons.inventory_2_outlined),
    _IconSpec('설비 상태·오류 이력 관리', '경보·오류 추적', Icons.warning_amber_rounded),
    _IconSpec('CSV·데이터베이스 저장', '파일·DB 저장', Icons.description_outlined),
    _IconSpec('생산 결과 조회 프로그램', '조건별 이력 검색', Icons.history),
    _IconSpec('현장 작업 안내 프로그램', '순서·설정 안내', Icons.list_alt),
    _IconSpec('제조 데이터 서버 전송', '사내 서버 연계', Icons.dns_outlined),
    _IconSpec('MES·ERP 연계 인터페이스', '상위 시스템 확장', Icons.hub_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: '개발 가능 분야',
            title: '적용 가능한 개발 예시',
            subtitle: '실제 납품 실적을 단정하지 않고, 현장 요구에 따라 개발할 수 있는 대표적인 분야를 안내합니다.',
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

  static const groups = [
    _BenefitGroup(
      title: '작업자 측면',
      icon: Icons.engineering,
      color: PromoColors.cyan,
      items: [
        '여러 장비의 상태를 한 화면에서 쉽게 확인',
        '작업 결과와 오류 내용을 빠르게 확인',
        '반복적인 기록과 확인 업무 감소',
        '현장에 맞춘 직관적인 화면 사용',
        '작업 실수와 정보 누락 감소',
      ],
    ),
    _BenefitGroup(
      title: '관리자 측면',
      icon: Icons.manage_accounts_outlined,
      color: PromoColors.electricBlue,
      items: [
        '생산 현황과 설비 상태 확인',
        '작업 결과와 생산 이력 관리',
        '데이터 검색과 보고 자료 확인 편의성 향상',
        '문제 발생 시 관련 이력 추적',
        '현장 데이터의 체계적인 관리',
      ],
    ),
    _BenefitGroup(
      title: '기업 측면',
      icon: Icons.apartment,
      color: PromoColors.success,
      items: [
        '수작업 중심의 관리 방식 개선',
        '생산정보의 디지털화',
        '제조·생산 관리 효율 향상',
        '향후 MES·ERP 연계 기반 마련',
        '업체 상황에 맞춘 단계적 시스템 확장',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      background: const Color(0xFF07101D),
      child: Column(
        children: [
          const _SectionHeading(
            eyebrow: '도입 효과',
            title: '제조업체가 체감할 수 있는 변화',
            subtitle: '과장된 수치 없이, 작업 편의성과 관리 효율을 높이는 실질적인 개선 방향을 중심으로 안내합니다.',
          ),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 980
                  ? 3
                  : constraints.maxWidth > 640
                  ? 2
                  : 1;
              const gap = 16.0;
              final width =
                  (constraints.maxWidth - (columns - 1) * gap) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final group in groups)
                    SizedBox(
                      width: width,
                      child: _BenefitGroupCard(group: group),
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

class _FutureExpansionSection extends StatelessWidget {
  const _FutureExpansionSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      child: _HoverGlowCard(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 34),
        borderColor: PromoColors.cyan.withValues(alpha: 0.35),
        child: Column(
          children: [
            const _SectionHeading(
              eyebrow: '향후 확장',
              title: '현장 데이터 축적 후 확장 가능한 기능',
              subtitle:
                  '설비와 생산 데이터가 충분히 축적되면 고객의 필요에 따라 통계 분석, 품질 경향 분석, 이상 패턴 확인, 보고서 자동화 등 데이터 활용 기능을 단계적으로 검토할 수 있습니다.',
            ),
            const SizedBox(height: 8),
            Text(
              '현재 기본 제공 기능이 아니며, 데이터 축적과 현장 요구에 따라 검토·확장 가능합니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PromoColors.textMutedOnDark.withValues(alpha: 0.9),
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({required this.onInquiry});

  final VoidCallback onInquiry;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    return _SectionShell(
      background: PromoColors.deepNavy,
      child: _HoverGlowCard(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 42 : 22,
          vertical: isWide ? 46 : 32,
        ),
        borderColor: PromoColors.cyan.withValues(alpha: 0.42),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _CtaCircuitPainter())),
            Column(
              children: [
                const _StatusPill(
                  label: '프로젝트 상담 · 문의하기',
                  icon: Icons.mail_outline,
                ),
                const SizedBox(height: 22),
                Text(
                  '현장 맞춤형 산업자동화 소프트웨어가 필요하신가요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: isWide ? 38 : 28,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '문의는 소통총관제로 접수되어 검토·피드백·후속 안내까지 연계됩니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PromoColors.cyan,
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'PLC 연동, 설비 데이터 수집, 모니터링 화면, 이력 관리, MES·ERP 연계 확장까지 상담 메일 한 통으로 시작하세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 15,
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 34),
                _ActionButton(
                  label: '문의하기',
                  icon: Icons.mail_outline,
                  onPressed: onInquiry,
                  large: true,
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
    final isWide = MediaQuery.sizeOf(context).width > 760;

    return Container(
      width: double.infinity,
      color: const Color(0xFF040914),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 32 : 22,
        vertical: isWide ? 38 : 32,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              '소통웨어(SotongWare)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PromoColors.textOnDark,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.1,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '산업자동화 모니터링 시스템',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PromoColors.textMutedOnDark,
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 14),
            Text(
              '문의',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PromoColors.cyan,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 6),
            Text(
              PromoContact.email,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PromoColors.cyan,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 18),
            Text(
              'PLC · 설비 데이터 수집 · 모니터링 · 이력 관리 · MES·ERP 연계 확장',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PromoColors.textMutedOnDark,
                fontSize: 11,
                height: 1.6,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
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
      constraints: BoxConstraints(
        maxWidth: math.max(180, MediaQuery.sizeOf(context).width - 64),
      ),
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
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                color: PromoColors.cyan,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.25,
              ),
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
    final compact = MediaQuery.sizeOf(context).width < 420;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.035 : 1,
        duration: const Duration(milliseconds: 160),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: widget.large ? 21 : 18),
          label: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: PromoColors.electricBlue,
            shadowColor: PromoColors.electricBlue.withValues(alpha: 0.5),
            elevation: _hovered ? 12 : 6,
            minimumSize: Size(
              widget.large ? 168 : (compact ? 108 : 132),
              widget.large ? 54 : 42,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.large ? 24 : (compact ? 12 : 16),
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
    final compact = MediaQuery.sizeOf(context).width < 420;

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
          label: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: PromoColors.textOnDark,
            side: BorderSide(
              color: _hovered ? PromoColors.cyan : PromoColors.blueStroke,
            ),
            minimumSize: Size(
              widget.large ? 168 : (compact ? 108 : 132),
              widget.large ? 54 : 42,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.large ? 24 : (compact ? 12 : 16),
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
              Icon(Icons.computer, color: PromoColors.cyan, size: 22),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  '현장 PC 데이터 흐름',
                  style: TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
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
                child: _ControlStat(label: '연동 대상', value: 'PLC'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ControlStat(label: '수집 위치', value: '현장 PC'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ControlStat(label: '확장', value: 'MES'),
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
      padding: const EdgeInsets.all(22),
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
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            feature.subtitle,
            style: const TextStyle(
              color: PromoColors.textMutedOnDark,
              fontSize: 13,
              height: 1.55,
              fontWeight: FontWeight.w500,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  node.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 11,
                    height: 1.3,
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
  const _SoftwarePreviewCard({required this.preview});

  final SoftwarePreviewSpec preview;

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
              child: SoftwarePreviewScreen(spec: preview),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(preview.icon, color: preview.color, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          preview.title,
                          style: const TextStyle(
                            color: PromoColors.textOnDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: PromoColors.textMutedOnDark,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    preview.subtitle,
                    style: const TextStyle(
                      color: PromoColors.textMutedOnDark,
                      fontSize: 12,
                    ),
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
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: PromoColors.textOnDark,
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 12,
                    height: 1.35,
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
                '개발 적용 예시',
                style: TextStyle(
                  color: PromoColors.cyan,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '자동차 부품 조립라인 모니터링',
                style: TextStyle(
                  color: PromoColors.textOnDark,
                  fontSize: 26,
                  height: 1.25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '체결툴, 바코드, PLC, 검사장비 데이터를 현장 PC에서 수집해 작업 순서, OK/NG, 생산 이력, 경보 상태를 표시·저장·조회하도록 구성할 수 있습니다.',
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

class _BenefitGroupCard extends StatelessWidget {
  const _BenefitGroupCard({required this.group});

  final _BenefitGroup group;

  @override
  Widget build(BuildContext context) {
    return _HoverGlowCard(
      padding: const EdgeInsets.all(22),
      borderColor: group.color.withValues(alpha: 0.28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(group.icon, color: group.color, size: 28),
          const SizedBox(height: 16),
          Text(
            group.title,
            style: const TextStyle(
              color: PromoColors.textOnDark,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          for (final item in group.items) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle, size: 7, color: group.color),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: PromoColors.textMutedOnDark,
                      fontSize: 14,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (item != group.items.last) const SizedBox(height: 10),
          ],
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
              '산업자동화 소프트웨어 준비 중',
              style: TextStyle(
                color: PromoColors.cyan,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
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

class _ArchitectureLayer {
  const _ArchitectureLayer({required this.label, required this.nodes});

  final String label;
  final List<_IconSpec> nodes;
}

class _BenefitGroup {
  const _BenefitGroup({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;
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
