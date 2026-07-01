import 'package:flutter/material.dart';
import '../theme/promo_theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.light = false,
    this.center = true,
  });

  final String title;
  final String? subtitle;
  final bool light;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final titleColor = light ? PromoColors.textOnDark : PromoColors.textPrimary;
    final subtitleColor = light
        ? PromoColors.textMutedOnDark
        : PromoColors.textSecondary;

    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: titleColor,
            fontSize: MediaQuery.sizeOf(context).width > 640 ? 32 : 26,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: subtitleColor),
            ),
          ),
        ],
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.id,
    this.backgroundColor,
    this.dark = false,
  });

  final Widget child;
  final String? id;
  final Color? backgroundColor;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: id != null ? Key(id!) : null,
      width: double.infinity,
      color:
          backgroundColor ??
          (dark ? PromoColors.deepNavy : PromoColors.surface),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: PromoLayout.maxContentWidth,
          ),
          child: Padding(
            padding: PromoLayout.sectionPaddingOf(context),
            child: child,
          ),
        ),
      ),
    );
  }
}

IconData promoIcon(String name) {
  const iconMap = <String, IconData>{
    'checklist': Icons.checklist,
    'account_tree': Icons.account_tree,
    'qr_code_scanner': Icons.qr_code_scanner,
    'memory': Icons.memory,
    'hub': Icons.hub,
    'build': Icons.build,
    'description': Icons.description,
    'show_chart': Icons.show_chart,
    'verified': Icons.verified,
    'desktop_windows': Icons.desktop_windows,
    'visibility': Icons.visibility,
    'history': Icons.history,
    'format_list_numbered': Icons.format_list_numbered,
    'qr_code_2': Icons.qr_code_2,
    'settings_input_component': Icons.settings_input_component,
    'device_hub': Icons.device_hub,
    'construction': Icons.construction,
    'table_chart': Icons.table_chart,
    'monitoring': Icons.monitor_heart_outlined,
    'dashboard': Icons.dashboard,
    'person': Icons.person,
    'computer': Icons.computer,
    'storage': Icons.storage,
    'admin_panel_settings': Icons.admin_panel_settings,
    'directions_car': Icons.directions_car,
    'battery_charging_full': Icons.battery_charging_full,
    'factory': Icons.factory,
    'center_focus_strong': Icons.center_focus_strong,
    'inventory_2': Icons.inventory_2,
    'speed': Icons.speed,
    'list_alt': Icons.list_alt,
    'sync_alt': Icons.sync,
    'fact_check': Icons.fact_check,
    'analytics': Icons.analytics,
    'code': Icons.code,
    'flutter_dash': Icons.flutter_dash,
    'cable': Icons.cable,
    'lan': Icons.lan,
    'track_changes': Icons.track_changes,
    'task_alt': Icons.task_alt,
    'search': Icons.search,
    'bar_chart': Icons.bar_chart,
    'shield': Icons.shield,
    'bolt': Icons.bolt,
  };
  return iconMap[name] ?? Icons.circle;
}
