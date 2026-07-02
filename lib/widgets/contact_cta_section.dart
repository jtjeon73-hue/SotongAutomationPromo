import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/promo_contact.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class ContactCtaSection extends StatelessWidget {
  const ContactCtaSection({super.key});

  Future<void> _openEmail() async {
    final uri = PromoContact.mailtoUri();
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'contact',
      dark: true,
      backgroundColor: PromoColors.navy,
      child: Column(
        children: [
          const SectionTitle(
            title: '공장 자동화 및 모니터링 시스템 구축이 필요하신가요?',
            subtitle: '귀사의 생산 환경에 맞는 맞춤형 시스템을 제안드립니다.',
            light: true,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _openEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PromoColors.teal,
                  minimumSize: const Size(200, 48),
                ),
                child: const Text('상담 문의하기'),
              ),
              OutlinedButton(
                onPressed: _openEmail,
                style: OutlinedButton.styleFrom(
                  foregroundColor: PromoColors.textOnDark,
                  side: const BorderSide(color: PromoColors.tealAccent),
                  minimumSize: const Size(200, 48),
                ),
                child: const Text('데모 요청하기'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: _openEmail,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.email_outlined,
                    size: 18,
                    color: PromoColors.tealAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    PromoContact.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: PromoColors.tealAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: PromoColors.tealAccent,
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
