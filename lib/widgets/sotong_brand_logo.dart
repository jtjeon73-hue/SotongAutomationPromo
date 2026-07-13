import 'package:flutter/material.dart';

import '../theme/promo_theme.dart';

/// 소통웨어 브랜드 로고 에셋 경로
class SotongBrandAssets {
  SotongBrandAssets._();

  static const String fullLogo = 'assets/images/sotongware_logo_full.png';
  static const String symbol = 'assets/images/sotongware_symbol.png';
}

enum SotongLogoVariant { full, symbol }

/// 소통웨어 공식 로고 표시 위젯
class SotongBrandLogo extends StatelessWidget {
  const SotongBrandLogo({
    super.key,
    this.variant = SotongLogoVariant.full,
    this.height = 72,
    this.maxWidth,
    this.onLightPlate = false,
    this.semanticLabel = '소통웨어',
  });

  final SotongLogoVariant variant;
  final double height;
  final double? maxWidth;
  final bool onLightPlate;
  final String semanticLabel;

  String get _asset => variant == SotongLogoVariant.full
      ? SotongBrandAssets.fullLogo
      : SotongBrandAssets.symbol;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      _asset,
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      semanticLabel: semanticLabel,
    );

    final constrained = maxWidth == null
        ? image
        : ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth!),
            child: image,
          );

    if (!onLightPlate) {
      return constrained;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: variant == SotongLogoVariant.full ? 14 : 10,
        vertical: variant == SotongLogoVariant.full ? 12 : 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: PromoColors.electricBlue.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: constrained,
    );
  }
}
