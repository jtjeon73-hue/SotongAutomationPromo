import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/promo_contact.dart';
import '../theme/promo_theme.dart';
import 'section_title.dart';

class ContactCtaSection extends StatelessWidget {
  const ContactCtaSection({super.key});

  Future<void> _openEmail(String subject) async {
    final uri = PromoContact.mailtoUri(subject: subject);
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
            title: '현장에 맞는 모니터링 시스템이 필요하신가요?',
            subtitle:
                '생산라인의 작업순서, 설비 데이터, 검사 결과, CSV 이력, 그래프 관리가 필요하다면 '
                '현장 상황에 맞춰 PC 기반 모니터링 시스템을 기획하고 개발할 수 있습니다.',
            light: true,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _openEmail('산업자동화 모니터링 시스템 상담 문의'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PromoColors.teal,
                  minimumSize: const Size(200, 48),
                ),
                child: const Text('이메일 상담'),
              ),
              OutlinedButton(
                onPressed: () => _openEmail('포트폴리오 문의'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PromoColors.textOnDark,
                  side: const BorderSide(color: PromoColors.tealAccent),
                  minimumSize: const Size(200, 48),
                ),
                child: const Text('포트폴리오 문의'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => _openEmail('산업자동화 모니터링 시스템 문의'),
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
