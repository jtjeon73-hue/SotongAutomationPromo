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
}
