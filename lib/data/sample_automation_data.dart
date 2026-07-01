import '../models/process_step.dart';
import '../models/project_case.dart';
import '../models/solution_feature.dart';

class SampleAutomationData {
  static const List<String> heroKeywords = [
    '생산라인 모니터링',
    '작업순서 관리',
    '바코드 연동',
    'PLC 연동',
    'MES 연동',
    'Tool 데이터 수집',
    'CSV / Graph',
    'OK / NG 판정',
  ];

  static const List<ProblemItem> problems = [
    ProblemItem(
      label: 'A',
      title: '작업순서 누락',
      description: '작업자가 정해진 순서대로 작업했는지 확인하기 어렵습니다.',
    ),
    ProblemItem(
      label: 'B',
      title: '수기 기록 의존',
      description: '작업 결과를 수기로 관리하면 누락, 오기입, 추적 문제가 발생합니다.',
    ),
    ProblemItem(
      label: 'C',
      title: '설비 데이터 분산',
      description: 'PLC, 바코드, Tool, MES 데이터가 각각 따로 관리되어 전체 흐름을 보기 어렵습니다.',
    ),
    ProblemItem(
      label: 'D',
      title: '불량 원인 추적 어려움',
      description: 'OK/NG 결과와 작업 조건, 작업자, 설비 상태를 함께 확인하기 어렵습니다.',
    ),
    ProblemItem(
      label: 'E',
      title: '라인별 PC 상태 파악 어려움',
      description: '여러 공정 PC의 진행 상태와 이상 여부를 한눈에 확인하기 어렵습니다.',
    ),
    ProblemItem(
      label: 'F',
      title: '데이터 활용 부족',
      description: 'CSV 파일이나 로그는 존재하지만 그래프, 통계, 리포트로 활용되지 못하는 경우가 많습니다.',
    ),
  ];

  static const List<SolutionItem> solutions = [
    SolutionItem(title: '작업자 작업리스트 관리', iconName: 'checklist'),
    SolutionItem(title: '작업순서 및 공정 흐름 관리', iconName: 'account_tree'),
    SolutionItem(title: '바코드 스캔 연동', iconName: 'qr_code_scanner'),
    SolutionItem(title: 'PLC 상태 연동', iconName: 'memory'),
    SolutionItem(title: 'MES 데이터 연동', iconName: 'hub'),
    SolutionItem(title: '작업자 Tool 연동', iconName: 'build'),
    SolutionItem(title: 'CSV / 로그 파일 관리', iconName: 'description'),
    SolutionItem(title: 'Torque / Angle 그래프', iconName: 'show_chart'),
    SolutionItem(title: 'OK / NG 결과 관리', iconName: 'verified'),
    SolutionItem(title: '라인별 PC 상태 모니터링', iconName: 'desktop_windows'),
    SolutionItem(title: '비전 검사 데이터 상태 모니터링', iconName: 'visibility'),
    SolutionItem(title: '생산 이력 조회', iconName: 'history'),
  ];

  static const List<SolutionFeature> features = [
    SolutionFeature(
      title: '작업순서 관리',
      description: '공정별 작업 흐름을 체계적으로 관리합니다.',
      iconName: 'format_list_numbered',
      bullets: ['공정별 작업 항목 표시', '순서 누락 방지', '작업 완료 여부 표시', 'OK/NG 상태 반영'],
    ),
    SolutionFeature(
      title: '바코드 연동',
      description: '제품 및 작업지시를 바코드로 자동 연계합니다.',
      iconName: 'qr_code_2',
      bullets: ['제품/부품/작업지시 바코드 인식', '작업 대상 자동 조회', '중복 작업 방지', '이력 추적'],
    ),
    SolutionFeature(
      title: 'PLC 연동',
      description: '설비 신호를 실시간으로 수집하고 공정에 반영합니다.',
      iconName: 'settings_input_component',
      bullets: ['설비 상태 수집', '공정 시작/완료 신호 처리', '알람 상태 확인', '생산 흐름 연계'],
    ),
    SolutionFeature(
      title: 'MES 연동',
      description: '상위 생산관리 시스템과 양방향 데이터를 연계합니다.',
      iconName: 'device_hub',
      bullets: ['작업지시 수신', '생산 결과 전송', 'LOT/Serial 정보 관리', '상위 시스템 연계 구조'],
    ),
    SolutionFeature(
      title: '작업자 Tool 연동',
      description: '전동공구 및 체결툴 데이터를 자동 수집합니다.',
      iconName: 'construction',
      bullets: [
        '전동공구/체결툴 데이터 수집',
        'Torque / Angle 데이터 처리',
        'OK/NG 판정',
        'Event Counter 기반 데이터 관리',
      ],
    ),
    SolutionFeature(
      title: 'CSV / 데이터 관리',
      description: '작업 결과를 체계적으로 저장하고 조회합니다.',
      iconName: 'table_chart',
      bullets: ['작업 결과 저장', '일자별/공정별 파일 관리', '검색/조회 기능', '데이터 백업 구조'],
    ),
    SolutionFeature(
      title: '그래프 모니터링',
      description: '체결 데이터를 시각적으로 분석합니다.',
      iconName: 'monitoring',
      bullets: ['Torque 그래프', 'Angle 그래프', '실시간 데이터 표시', '범위 이탈 확인'],
    ),
    SolutionFeature(
      title: '라인 관제',
      description: '공정 PC 상태를 통합 모니터링합니다.',
      iconName: 'dashboard',
      bullets: ['공정 PC별 상태 확인', '작업 진행 현황 표시', '이상 상태 빠른 파악', '관리자용 통합 모니터링'],
    ),
  ];

  static const List<ArchitectureNode> architectureLayers = [
    ArchitectureNode(
      title: 'Operator UI',
      subtitle: '작업자 화면',
      iconName: 'person',
    ),
    ArchitectureNode(
      title: 'Barcode Scanner',
      subtitle: '바코드 스캐너',
      iconName: 'qr_code_scanner',
    ),
    ArchitectureNode(title: 'PLC', subtitle: '설비 제어', iconName: 'memory'),
    ArchitectureNode(
      title: 'Tool Controller',
      subtitle: '체결툴',
      iconName: 'build',
    ),
    ArchitectureNode(
      title: 'Local PC',
      subtitle: '공정 PC 모니터링',
      iconName: 'computer',
    ),
    ArchitectureNode(
      title: 'CSV / Log',
      subtitle: '데이터 저장',
      iconName: 'storage',
    ),
    ArchitectureNode(
      title: 'Graph Viewer',
      subtitle: '그래프 분석',
      iconName: 'show_chart',
    ),
    ArchitectureNode(title: 'MES', subtitle: '생산관리 연동', iconName: 'hub'),
    ArchitectureNode(
      title: 'Admin Monitoring',
      subtitle: '관리자 관제',
      iconName: 'admin_panel_settings',
    ),
  ];

  static const List<ApplicationArea> applicationAreas = [
    ApplicationArea(
      title: '자동차 부품 조립라인',
      description: '체결, 조립, 검사, OK/NG 이력 관리',
      iconName: 'directions_car',
    ),
    ApplicationArea(
      title: '배터리/전장 부품 공정',
      description: '공정 순서, 검사 결과, 설비 상태 관리',
      iconName: 'battery_charging_full',
    ),
    ApplicationArea(
      title: '일반 제조 조립라인',
      description: '작업자 진행 상황, 바코드, 설비 데이터 통합',
      iconName: 'factory',
    ),
    ApplicationArea(
      title: '검사 장비 데이터 관리',
      description: '비전 검사 결과, 검사 PC 상태, 데이터 관리',
      iconName: 'center_focus_strong',
    ),
    ApplicationArea(
      title: '공정별 모니터링 PC',
      description: '각 공정 PC의 작업 현황과 이상 상태 확인',
      iconName: 'desktop_windows',
    ),
    ApplicationArea(
      title: '생산 이력 관리 시스템',
      description: 'LOT, Serial, 작업 결과, 검사 결과 추적',
      iconName: 'inventory_2',
    ),
  ];

  static const List<ProjectCase> projectCases = [
    ProjectCase(
      title: '체결 데이터 모니터링 시스템',
      purpose: '조립 공정의 체결 데이터를 수집하고 품질을 관리합니다.',
      features: [
        'Torque / Angle 수집',
        'OK/NG 결과 관리',
        'CSV 저장',
        '그래프 표시',
        '작업 이력 조회',
      ],
      expectedEffect: '체결 품질 데이터의 누락을 방지하고 불량 원인 분석이 용이해집니다.',
      iconName: 'speed',
    ),
    ProjectCase(
      title: '생산 공정 작업순서 관리 시스템',
      purpose: '작업자가 정해진 순서대로 공정을 진행하도록 지원합니다.',
      features: ['작업리스트 표시', '순서 제어', '바코드 연동', '공정별 진행 상태 표시'],
      expectedEffect: '작업 누락과 순서 오류를 줄이고 공정 표준화를 강화합니다.',
      iconName: 'list_alt',
    ),
    ProjectCase(
      title: 'MES 연동 생산 결과 관리',
      purpose: '상위 생산관리 시스템과 생산 데이터를 연계합니다.',
      features: ['작업지시 수신', '결과 데이터 전송', 'LOT / Serial 관리', '생산 이력 추적'],
      expectedEffect: '생산 데이터의 일관성을 확보하고 이력 추적 체계를 구축합니다.',
      iconName: 'sync_alt',
    ),
    ProjectCase(
      title: '검사라인 통합 모니터링',
      purpose: '검사 공정의 PC 상태와 결과를 통합 관리합니다.',
      features: ['검사 PC 상태 확인', '검사 결과 데이터 관리', '라인별 진행 상황 표시', '관리자 화면 구성'],
      expectedEffect: '검사 공정의 가시성을 높이고 이상 대응 속도를 개선합니다.',
      iconName: 'fact_check',
    ),
    ProjectCase(
      title: 'CSV 데이터 조회/그래프 시스템',
      purpose: '축적된 생산 데이터를 조회하고 분석합니다.',
      features: [
        '일자별 데이터 조회',
        'Torque / Angle 그래프',
        '검색 및 정렬',
        '리포트 기초 데이터 관리',
      ],
      expectedEffect: '데이터 활용도를 높이고 품질 분석의 기반을 마련합니다.',
      iconName: 'analytics',
    ),
  ];

  static const List<ProcessStep> processSteps = [
    ProcessStep(
      stepNumber: 1,
      title: '현장 업무 흐름 파악',
      description: '작업순서, 설비 신호, 데이터 흐름, 작업자 화면 요구사항을 정리합니다.',
    ),
    ProcessStep(
      stepNumber: 2,
      title: '기능 정의 및 화면 설계',
      description: '작업자 화면, 관리자 화면, 데이터 저장 구조, 연동 대상을 설계합니다.',
    ),
    ProcessStep(
      stepNumber: 3,
      title: '연동 구조 개발',
      description: '바코드, PLC, MES, Tool, CSV, 그래프 등 필요한 연동 기능을 구현합니다.',
    ),
    ProcessStep(
      stepNumber: 4,
      title: '현장 테스트',
      description: '실제 작업 흐름에 맞춰 데이터 누락, 순서 오류, 통신 문제를 점검합니다.',
    ),
    ProcessStep(
      stepNumber: 5,
      title: '안정화 및 개선',
      description: '예외 처리, 로그, 데이터 조회, 사용자 편의 기능을 보완합니다.',
    ),
    ProcessStep(
      stepNumber: 6,
      title: '유지보수 및 기능 확장',
      description: '신규 공정, 추가 설비, 관리자 요구사항을 반영합니다.',
    ),
  ];

  static const List<TechStackItem> techStack = [
    TechStackItem(title: 'Windows PC 프로그램', iconName: 'computer'),
    TechStackItem(title: 'MFC / C++ 기반 현장 프로그램', iconName: 'code'),
    TechStackItem(title: 'Flutter 기반 관리/홍보 화면 확장 가능', iconName: 'flutter_dash'),
    TechStackItem(title: 'Serial / Modbus RTU', iconName: 'cable'),
    TechStackItem(title: 'Modbus TCP', iconName: 'lan'),
    TechStackItem(title: 'PLC 연동', iconName: 'settings_input_component'),
    TechStackItem(title: 'MES 연동', iconName: 'device_hub'),
    TechStackItem(title: 'Barcode Scanner', iconName: 'qr_code_scanner'),
    TechStackItem(title: 'CSV / TXT 로그', iconName: 'description'),
    TechStackItem(title: 'Graph Visualization', iconName: 'show_chart'),
    TechStackItem(title: 'Data Monitoring', iconName: 'monitoring'),
    TechStackItem(title: 'Production Traceability', iconName: 'track_changes'),
  ];

  static const List<BenefitItem> benefits = [
    BenefitItem(
      title: '작업 누락 감소',
      description: '작업순서 관리로 공정 누락을 방지합니다.',
      iconName: 'task_alt',
    ),
    BenefitItem(
      title: '불량 원인 추적 개선',
      description: 'OK/NG 데이터와 작업 조건을 함께 확인합니다.',
      iconName: 'search',
    ),
    BenefitItem(
      title: '생산 데이터 가시화',
      description: 'CSV와 그래프로 데이터를 시각화합니다.',
      iconName: 'bar_chart',
    ),
    BenefitItem(
      title: '작업자 실수 방지',
      description: '바코드와 순서 제어로 실수를 줄입니다.',
      iconName: 'shield',
    ),
    BenefitItem(
      title: '관리자 모니터링 강화',
      description: '라인별 PC 상태를 통합 관제합니다.',
      iconName: 'dashboard',
    ),
    BenefitItem(
      title: '이력 데이터 확보',
      description: '생산 이력을 체계적으로 축적합니다.',
      iconName: 'history',
    ),
    BenefitItem(
      title: '현장 대응 속도 향상',
      description: '이상 상태를 빠르게 파악하고 대응합니다.',
      iconName: 'bolt',
    ),
    BenefitItem(
      title: 'MES 연계 기반 마련',
      description: '상위 시스템 연동 구조를 구축합니다.',
      iconName: 'hub',
    ),
  ];
}
