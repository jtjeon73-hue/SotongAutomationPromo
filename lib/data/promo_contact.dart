class PromoContact {
  PromoContact._();

  static const String email = 'sotongware@naver.com';

  static Uri mailtoUri({required String subject}) {
    return Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent(subject)}',
    );
  }
}
