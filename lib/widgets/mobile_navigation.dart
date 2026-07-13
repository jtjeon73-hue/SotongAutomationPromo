import 'package:flutter/material.dart';

import '../theme/promo_theme.dart';
import 'sotong_brand_logo.dart';

enum MobileNavTab { intro, features, integration, contact }

class MobileBottomNavBar extends StatelessWidget {
  const MobileBottomNavBar({
    super.key,
    required this.active,
    required this.onSelect,
  });

  final MobileNavTab active;
  final ValueChanged<MobileNavTab> onSelect;

  static const _items = [
    (MobileNavTab.intro, '소개', Icons.info_outline),
    (MobileNavTab.features, '핵심기능', Icons.dashboard_customize_outlined),
    (MobileNavTab.integration, '연동대상', Icons.device_hub_outlined),
    (MobileNavTab.contact, '문의하기', Icons.mail_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0B1730),
      elevation: 12,
      shadowColor: Colors.black54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                for (final item in _items)
                  Expanded(
                    child: _BottomNavItem(
                      label: item.$2,
                      icon: item.$3,
                      selected: active == item.$1,
                      onTap: () => onSelect(item.$1),
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

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? PromoColors.electricBlue
        : PromoColors.textMutedOnDark;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Tooltip(
          message: label,
          child: SizedBox(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 22, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
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

class MobileFullMenuSheet extends StatelessWidget {
  const MobileFullMenuSheet({
    super.key,
    required this.activeLabel,
    required this.onSelect,
  });

  final String? activeLabel;
  final ValueChanged<String> onSelect;

  static const items = [
    '시스템 소개',
    '핵심 기능',
    '작업자 중심 화면',
    '연동 대상',
    '통신 방식',
    '시스템 구성도',
    '도입 효과',
    '적용 분야',
    '문의하기',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SotongBrandLogo(
                  variant: SotongLogoVariant.symbol,
                  height: 32,
                  onLightPlate: true,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '전체메뉴',
                    style: TextStyle(
                      color: PromoColors.textOnDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: '닫기',
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close, color: PromoColors.textOnDark),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                itemBuilder: (context, index) {
                  final label = items[index];
                  final selected = activeLabel == label;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    minVerticalPadding: 14,
                    title: Text(
                      label,
                      style: TextStyle(
                        color: selected
                            ? PromoColors.electricBlue
                            : PromoColors.textOnDark,
                        fontSize: 16,
                        fontWeight: selected
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(
                            Icons.check_circle,
                            color: PromoColors.electricBlue,
                            size: 20,
                          )
                        : Icon(
                            Icons.chevron_right,
                            color: PromoColors.textMutedOnDark.withValues(
                              alpha: 0.7,
                            ),
                          ),
                    onTap: () {
                      Navigator.of(context).maybePop();
                      onSelect(label);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    super.key,
    required this.visible,
    required this.onPressed,
    this.bottomOffset = 88,
  });

  final bool visible;
  final VoidCallback onPressed;
  final double bottomOffset;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      right: 16,
      bottom: visible ? bottomOffset : bottomOffset - 12,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: visible ? 1 : 0,
        child: IgnorePointer(
          ignoring: !visible,
          child: Semantics(
            button: true,
            label: '맨 위로',
            child: FloatingActionButton.small(
              heroTag: 'scroll-to-top',
              tooltip: '맨 위로',
              backgroundColor: PromoColors.electricBlue,
              foregroundColor: Colors.white,
              onPressed: onPressed,
              child: const Icon(Icons.keyboard_arrow_up, size: 26),
            ),
          ),
        ),
      ),
    );
  }
}
