class PromoContact {
  PromoContact._();

  static const String email = 'sotongware@naver.com';
  static const String subject = '[소통웨어 산업자동화 모니터링 시스템 상담문의]';
  static const String body = '''업체명 :

담당자 :

직책 :

연락처 :

이메일 :

공장 위치 :

문의 분야 :

□ PLC 연동

□ 산업자동화 모니터링

□ 설비 데이터 수집

□ 생산 모니터링

□ MES 연동

□ SCADA

□ AI 예지보전

□ 스마트팩토리 구축

□ 기타

문의 내용 :''';

  static Uri mailtoUri() {
    return Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: const {'subject': subject, 'body': body},
    );
  }

  static const String hubSubjectPrefix = '[소통총관제 접수]';

  static Uri hubInquiryUri() {
    return Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': '$hubSubjectPrefix 산업자동화 상담 문의',
        'body': '''[소통총관제 연동 문의]
접수 채널: 홍보사이트 온라인 문의

업체명 :

담당자 :

연락처 :

문의 유형 : □ 상담  □ 기술  □ 견적  □ 기타

문의 내용 :

---
※ 본 메일은 소통총관제 접수 흐름으로 처리됩니다.''',
      },
    );
  }

  static Uri hubDemoUri() {
    return Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': '$hubSubjectPrefix 데모 요청',
        'body': '''[소통총관제 연동 — 데모 요청]
접수 채널: 홍보사이트

업체명 :

담당자 :

연락처 :

희망 데모 내용 (PLC/바코드/MES/모니터링 등) :

희망 일정 :

---
※ 소통총관제에서 일정·자료를 안내드립니다.''',
      },
    );
  }
}
