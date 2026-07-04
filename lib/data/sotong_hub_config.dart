import 'package:flutter/material.dart';
import '../theme/promo_theme.dart';

/// 소통총관제 연동 흐름 및 문의·피드백 구조 (홍보사이트 UI / 실제 API 미연동)
class SotongHubConfig {
  SotongHubConfig._();

  static const String hubName = '소통총관제';
  static const String hubSubtitle = 'Sotong Central Command Hub';

  static const flowSteps = [
    HubFlowStep(
      step: 1,
      title: '온라인 문의 접수',
      description: '홍보사이트·이메일을 통해 상담·데모·기술 문의가 접수됩니다.',
      icon: Icons.edit_note_outlined,
      color: PromoColors.electricBlue,
    ),
    HubFlowStep(
      step: 2,
      title: '소통총관제 배정',
      description: '총관제에서 문의 유형을 분류하고 담당 채널로 배정합니다.',
      icon: Icons.hub_outlined,
      color: PromoColors.cyan,
    ),
    HubFlowStep(
      step: 3,
      title: '피드백 · 상담 회신',
      description: '검토 결과, 제안 내용, 추가 질문에 대한 피드백을 전달합니다.',
      icon: Icons.forum_outlined,
      color: PromoColors.success,
    ),
    HubFlowStep(
      step: 4,
      title: '총관제 지시 반영',
      description: '후속 일정, 자료 요청, 데모·견적 등 총관제 지시에 따라 진행합니다.',
      icon: Icons.assignment_turned_in_outlined,
      color: PromoColors.warning,
    ),
  ];

  /// 샘플 문의 현황 (실제 고객명 없음)
  static const sampleTickets = [
    HubTicket(
      id: 'REQ-2407-001',
      type: '상담 문의',
      status: HubTicketStatus.received,
      summary: '조립라인 모니터링 시스템 도입 검토',
    ),
    HubTicket(
      id: 'REQ-2407-002',
      type: '데모 요청',
      status: HubTicketStatus.inReview,
      summary: 'PLC·바코드 연동 데모 일정 문의',
    ),
    HubTicket(
      id: 'REQ-2407-003',
      type: '기술 문의',
      status: HubTicketStatus.feedback,
      summary: 'MES 연동 구조 및 이력 조회 방식',
    ),
    HubTicket(
      id: 'REQ-2407-004',
      type: '포트폴리오',
      status: HubTicketStatus.instruction,
      summary: '체결 데이터 모니터링 사례 자료 요청',
    ),
  ];
}

class HubFlowStep {
  const HubFlowStep({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final int step;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

enum HubTicketStatus {
  received('접수', PromoColors.electricBlue),
  inReview('검토중', PromoColors.warning),
  feedback('피드백', PromoColors.success),
  instruction('지시반영', PromoColors.cyan);

  const HubTicketStatus(this.label, this.color);
  final String label;
  final Color color;
}

class HubTicket {
  const HubTicket({
    required this.id,
    required this.type,
    required this.status,
    required this.summary,
  });

  final String id;
  final String type;
  final HubTicketStatus status;
  final String summary;
}
