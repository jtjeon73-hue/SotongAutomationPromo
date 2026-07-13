import '../models/process_step.dart';
import '../models/project_case.dart';
import '../models/solution_feature.dart';

class SampleAutomationData {
  static const List<String> heroKeywords = [
    'PLC·장비 연동',
    '작업자 중심 화면',
    '작업 순서 안내',
    '설비 상태 확인',
    '생산 결과 확인',
    '생산 데이터 저장',
    '이력 조회',
    '맞춤형 소프트웨어',
    'MES·ERP 연계 확장',
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
      description: 'PLC, 바코드, Tool, 검사장비 데이터가 각각 따로 관리되어 전체 흐름을 보기 어렵습니다.',
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
      description: 'CSV 파일이나 로그는 존재하지만 조회·보고서 형태로 활용되지 못하는 경우가 많습니다.',
    ),
  ];

  static const List<SolutionItem> solutions = [
    SolutionItem(title: '작업자 작업리스트 관리', iconName: 'checklist'),
    SolutionItem(title: '작업순서 및 공정 흐름 관리', iconName: 'account_tree'),
    SolutionItem(title: '바코드 스캔 연동', iconName: 'qr_code_scanner'),
    SolutionItem(title: 'PLC 상태 연동', iconName: 'memory'),
    SolutionItem(title: 'MES 연계 확장', iconName: 'hub'),
    SolutionItem(title: '작업자 Tool 연동', iconName: 'build'),
    SolutionItem(title: 'CSV / 로그 파일 관리', iconName: 'description'),
    SolutionItem(title: 'Torque / Angle 그래프', iconName: 'show_chart'),
    SolutionItem(title: 'OK / NG 결과 관리', iconName: 'verified'),
    SolutionItem(title: '라인별 PC 상태 모니터링', iconName: 'desktop_windows'),
    SolutionItem(title: '검사 데이터 상태 모니터링', iconName: 'visibility'),
    SolutionItem(title: '생산 이력 조회', iconName: 'history'),
  ];

  static const List<SolutionFeature> features = [
    SolutionFeature(
      title: 'PLC·설비 데이터 연동',
      description: 'PLC, 센서, 계측기, 체결기, 검사장비 등에서 발생하는 데이터를 통신을 통해 수집합니다.',
      iconName: 'settings_input_component',
      bullets: [
        'PLC 신호 수집',
        '센서·계측 데이터 연동',
        '체결·검사장비 통신',
        'Modbus / Serial / Ethernet',
      ],
    ),
    SolutionFeature(
      title: '현장 모니터링 화면',
      description: '설비 상태, 생산 수량, 측정값, 작업 결과, 경보 상태를 작업자가 보기 쉬운 화면으로 제공합니다.',
      iconName: 'monitor',
      bullets: ['설비 상태 표시', '생산 수량 확인', '측정값·작업 결과', '경보·오류 표시'],
    ),
    SolutionFeature(
      title: '데이터 저장 및 이력 조회',
      description: '수집된 생산정보와 설비 데이터를 저장하고 날짜, 설비, 제품, 작업 조건 등에 따라 조회합니다.',
      iconName: 'storage',
      bullets: ['생산정보 저장', '설비 데이터 축적', '조건별 이력 조회', 'CSV·DB 저장'],
    ),
    SolutionFeature(
      title: '작업 편의성 개선',
      description:
          '작업 순서 안내, 설정값 관리, 오류 메시지, 작업 결과 확인 등 현장 작업자가 쉽게 사용할 수 있는 기능을 구성합니다.',
      iconName: 'touch_app',
      bullets: ['작업 순서 안내', '설정값 관리', '오류 메시지 표시', '작업 결과 확인'],
    ),
    SolutionFeature(
      title: '생산·설비 관리 효율 향상',
      description: '관리자가 생산 현황과 설비 정보를 빠르게 확인하고, 누적된 이력을 관리할 수 있도록 지원합니다.',
      iconName: 'dashboard',
      bullets: ['생산 현황 확인', '설비 정보 관리', '이력 데이터 정리', '검색·조회 편의'],
    ),
    SolutionFeature(
      title: '맞춤형 시스템 개발',
      description: '업체별 설비 구성, 통신 방식, 생산 공정, 관리 항목에 맞추어 필요한 기능을 맞춤 개발합니다.',
      iconName: 'handyman',
      bullets: ['설비 구성 맞춤', '통신 방식 대응', '공정별 화면 설계', '관리 항목 반영'],
    ),
    SolutionFeature(
      title: '상위 시스템 연계 확장',
      description:
          '현장 PC에 수집된 데이터를 기반으로 향후 MES, ERP, 사내 서버, 데이터베이스 등과 연계할 수 있도록 확장 가능한 구조를 적용합니다.',
      iconName: 'device_hub',
      bullets: ['MES 연계 확장', 'ERP 연계 검토', '사내 서버 전송', 'DB 인터페이스'],
    ),
  ];

  static const List<ArchitectureNode> architectureLayers = [
    ArchitectureNode(
      title: '생산설비·센서',
      subtitle: '현장 장비',
      iconName: 'precision_manufacturing',
    ),
    ArchitectureNode(title: 'PLC·컨트롤러', subtitle: '제어·통신', iconName: 'memory'),
    ArchitectureNode(
      title: '현장 PC 프로그램',
      subtitle: '수집·표시·저장',
      iconName: 'computer',
    ),
    ArchitectureNode(title: '데이터 관리', subtitle: '조회·이력', iconName: 'storage'),
    ArchitectureNode(title: 'MES·ERP 확장', subtitle: '필요 시 연계', iconName: 'hub'),
  ];

  static const List<ApplicationArea> applicationAreas = [
    ApplicationArea(
      title: 'PLC 생산 데이터 모니터링',
      description: '설비 신호와 생산 수량을 현장 PC에서 확인',
      iconName: 'memory',
    ),
    ApplicationArea(
      title: '체결 토크·각도 결과 관리',
      description: '체결 결과와 OK/NG 판정 데이터 저장',
      iconName: 'build',
    ),
    ApplicationArea(
      title: '검사장비 측정 데이터 수집',
      description: '측정값·판정 결과를 수집하고 조회',
      iconName: 'center_focus_strong',
    ),
    ApplicationArea(
      title: '생산 수량 및 작업 실적 관리',
      description: '작업 실적과 생산 수량을 체계적으로 기록',
      iconName: 'inventory_2',
    ),
    ApplicationArea(
      title: '설비 상태 및 오류 이력 관리',
      description: '경보·오류 내용을 이력으로 남겨 추적',
      iconName: 'warning_amber',
    ),
    ApplicationArea(
      title: 'CSV·데이터베이스 저장',
      description: '현장 데이터를 파일 또는 DB로 저장',
      iconName: 'description',
    ),
  ];

  static const List<ProjectCase> projectCases = [
    ProjectCase(
      title: 'PLC 생산 데이터 모니터링',
      purpose: 'PLC와 생산설비 데이터를 현장 PC에서 수집·표시합니다.',
      features: ['설비 상태 표시', '생산 수량 확인', '경보 상태 표시', '이력 저장'],
      expectedEffect: '작업자가 여러 설비 상태를 한 화면에서 확인하기 쉬워집니다.',
      iconName: 'memory',
    ),
    ProjectCase(
      title: '체결 토크·각도 결과 관리',
      purpose: '체결기에서 수집한 토크·각도 결과를 저장하고 조회합니다.',
      features: ['Torque / Angle 수집', 'OK/NG 결과 관리', 'CSV 저장', '그래프 표시'],
      expectedEffect: '체결 결과 누락을 줄이고 이력 추적이 쉬워집니다.',
      iconName: 'speed',
    ),
    ProjectCase(
      title: '생산 결과 조회 프로그램',
      purpose: '날짜·설비·제품 조건으로 생산 이력을 조회합니다.',
      features: ['조건별 검색', '작업 실적 조회', '오류 이력 확인', '보고서용 데이터 정리'],
      expectedEffect: '관리자가 생산정보를 체계적으로 확인할 수 있습니다.',
      iconName: 'history',
    ),
    ProjectCase(
      title: '현장 작업 안내 프로그램',
      purpose: '작업 순서와 설정값을 화면에 안내해 작업 실수를 줄입니다.',
      features: ['작업리스트 표시', '순서 안내', '설정값 관리', '오류 메시지 표시'],
      expectedEffect: '반복 기록과 확인 업무를 줄이고 작업 편의성을 높입니다.',
      iconName: 'list_alt',
    ),
    ProjectCase(
      title: 'MES·ERP 연계용 데이터 인터페이스',
      purpose: '필요에 따라 상위 시스템으로 데이터를 전송할 수 있는 구조를 준비합니다.',
      features: ['데이터 전송 구조', 'LOT / Serial 관리', '서버·DB 연계', '단계적 확장'],
      expectedEffect: '향후 상위 시스템 연계를 위한 기반을 마련할 수 있습니다.',
      iconName: 'sync_alt',
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
      description: 'PLC, 바코드, Tool, CSV, 이력 조회 등 필요한 연동 기능을 구현합니다.',
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
      description: '신규 공정, 추가 설비, 상위 시스템 연계 요구를 반영합니다.',
    ),
  ];

  static const List<TechStackItem> techStack = [
    TechStackItem(title: 'Windows PC 프로그램', iconName: 'computer'),
    TechStackItem(title: 'MFC / C++ 기반 현장 프로그램', iconName: 'code'),
    TechStackItem(title: 'Flutter 기반 관리/홍보 화면 확장 가능', iconName: 'flutter_dash'),
    TechStackItem(title: 'Serial / Modbus RTU', iconName: 'cable'),
    TechStackItem(title: 'Modbus TCP', iconName: 'lan'),
    TechStackItem(title: 'PLC 연동', iconName: 'settings_input_component'),
    TechStackItem(title: 'MES·ERP 연계 확장', iconName: 'device_hub'),
    TechStackItem(title: 'Barcode Scanner', iconName: 'qr_code_scanner'),
    TechStackItem(title: 'CSV / TXT 로그', iconName: 'description'),
    TechStackItem(title: 'Graph Visualization', iconName: 'show_chart'),
    TechStackItem(title: 'Data Monitoring', iconName: 'monitoring'),
    TechStackItem(title: 'Production Traceability', iconName: 'track_changes'),
  ];

  static const List<BenefitItem> benefits = [
    BenefitItem(
      title: '한 화면에서 상태 확인',
      description: '여러 장비의 상태를 현장 PC 한 화면에서 쉽게 확인합니다.',
      iconName: 'desktop_windows',
    ),
    BenefitItem(
      title: '작업 결과·오류 빠른 확인',
      description: '작업 결과와 오류 내용을 바로 확인합니다.',
      iconName: 'fact_check',
    ),
    BenefitItem(
      title: '수작업 기록 감소',
      description: '반복적인 기록과 확인 업무를 줄입니다.',
      iconName: 'edit_off',
    ),
    BenefitItem(
      title: '생산·이력 체계 관리',
      description: '생산 현황과 설비 이력을 체계적으로 관리합니다.',
      iconName: 'folder_open',
    ),
    BenefitItem(
      title: '문제 이력 추적',
      description: '문제 발생 시 관련 이력을 빠르게 추적합니다.',
      iconName: 'search',
    ),
    BenefitItem(
      title: '디지털 관리 기반',
      description: '수작업 중심 관리를 디지털화하고 MES·ERP 연계 기반을 마련합니다.',
      iconName: 'hub',
    ),
  ];
}
