class PromoContact {
  PromoContact._();

  static const String email = 'sotongware@naver.com';
  static const String subject = '[소통웨어 산업자동화 소프트웨어 문의]';
  static const String body = '''업체명 :

담당자 :

직책 :

연락처 :

이메일 :

공장 위치 :

문의 분야 :

□ PLC·설비 데이터 연동

□ 현장 모니터링 화면

□ 생산·이력 데이터 관리

□ 작업 편의성 개선

□ MES·ERP 연계 확장

□ 맞춤형 프로그램 개발

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
}
