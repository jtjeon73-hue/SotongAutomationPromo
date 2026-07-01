import 'package:flutter/material.dart';
import '../data/sample_automation_data.dart';
import '../theme/promo_theme.dart';
import '../widgets/contact_cta_section.dart';
import '../widgets/feature_card.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/problem_solution_section.dart';
import '../widgets/process_step_card.dart';
import '../widgets/project_case_card.dart';
import '../widgets/system_architecture_section.dart';
import '../widgets/tech_stack_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _featuresKey = GlobalKey();
  final _applicationsKey = GlobalKey();
  final _processKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: PromoColors.deepNavy,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: PromoColors.tealAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '소통웨어 산업자동화',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: PromoColors.textOnDark,
                  ),
                ),
              ],
            ),
            actions: [
              if (MediaQuery.sizeOf(context).width > 768) ...[
                TextButton(
                  onPressed: () => _scrollTo(_featuresKey),
                  child: const Text(
                    '핵심 기능',
                    style: TextStyle(color: PromoColors.textMutedOnDark),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollTo(_applicationsKey),
                  child: const Text(
                    '적용 분야',
                    style: TextStyle(color: PromoColors.textMutedOnDark),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollTo(_processKey),
                  child: const Text(
                    '개발 프로세스',
                    style: TextStyle(color: PromoColors.textMutedOnDark),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
          SliverToBoxAdapter(
            child: HeroSection(
              onScrollToFeatures: () => _scrollTo(_featuresKey),
              onScrollToApplications: () => _scrollTo(_applicationsKey),
              onScrollToProcess: () => _scrollTo(_processKey),
            ),
          ),
          SliverToBoxAdapter(
            child: ProblemSolutionSection(
              problems: SampleAutomationData.problems,
              solutions: SampleAutomationData.solutions,
            ),
          ),
          SliverToBoxAdapter(
            child: KeyedSubtree(
              key: _featuresKey,
              child: FeaturesSection(features: SampleAutomationData.features),
            ),
          ),
          SliverToBoxAdapter(
            child: SystemArchitectureSection(
              nodes: SampleAutomationData.architectureLayers,
            ),
          ),
          SliverToBoxAdapter(
            child: KeyedSubtree(
              key: _applicationsKey,
              child: ApplicationAreasSection(
                areas: SampleAutomationData.applicationAreas,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: PortfolioSection(cases: SampleAutomationData.projectCases),
          ),
          SliverToBoxAdapter(
            child: KeyedSubtree(
              key: _processKey,
              child: ProcessSection(steps: SampleAutomationData.processSteps),
            ),
          ),
          SliverToBoxAdapter(
            child: TechStackSection(items: SampleAutomationData.techStack),
          ),
          SliverToBoxAdapter(
            child: BenefitsSection(benefits: SampleAutomationData.benefits),
          ),
          const SliverToBoxAdapter(child: ContactCtaSection()),
          const SliverToBoxAdapter(child: FooterSection()),
        ],
      ),
    );
  }
}
