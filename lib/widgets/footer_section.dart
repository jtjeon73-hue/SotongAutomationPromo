import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/promo_contact.dart';
import '../theme/promo_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _openEmail() async {
    final uri = PromoContact.mailtoUri();
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      width: double.infinity,
      color: PromoColors.deepNavy,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: PromoLayout.maxContentWidth,
          ),
          child: Padding(
            padding: PromoLayout.sectionPaddingOf(context),
            child: Column(
              children: [
                const Divider(color: PromoColors.charcoal, height: 1),
                const SizedBox(height: 32),
                Text(
                  '소통웨어(SotongWare)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: PromoColors.textOnDark,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '산업자동화 모니터링 시스템',
                  style: TextStyle(
                    color: PromoColors.tealAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Production Line Monitoring / PLC / MES / SCADA / AI',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: PromoColors.textMutedOnDark,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '문의',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: PromoColors.tealAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _openEmail,
                  child: Text(
                    PromoContact.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: PromoColors.tealAccent,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                      decorationColor: PromoColors.tealAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '© $year Sotong Software. All rights reserved.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: PromoColors.lightGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
