import 'package:flutter/material.dart';

enum AppBadgeVariant { primary, success, warning, danger, info }
enum AppBadgeSize { sm, md, lg }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeVariant variant;
  final AppBadgeSize size;

  const AppBadge({
    super.key,
    required this.text,
    this.variant = AppBadgeVariant.primary,
    this.size = AppBadgeSize.md,
  });

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (variant) {
      AppBadgeVariant.primary => (Theme.of(context).colorScheme.primary.withOpacity(.15), Colors.black),
      AppBadgeVariant.success => (Colors.green.withOpacity(.15), Colors.green.shade800),
      AppBadgeVariant.warning => (Colors.amber.withOpacity(.2), Colors.orange.shade800),
      AppBadgeVariant.danger => (Colors.red.withOpacity(.15), Colors.red.shade800),
      AppBadgeVariant.info => (Colors.blue.withOpacity(.15), Colors.blue.shade800),
    };

    final EdgeInsets padding = switch (size) {
      AppBadgeSize.sm => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      AppBadgeSize.md => const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      AppBadgeSize.lg => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    };

    final double fontSize = switch (size) {
      AppBadgeSize.sm => 10,
      AppBadgeSize.md => 12,
      AppBadgeSize.lg => 14,
    };

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: fontSize),
      ),
    );
  }
}
