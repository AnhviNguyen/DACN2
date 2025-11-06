import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger, success }
enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final EdgeInsets padding = switch (size) {
      AppButtonSize.sm => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      AppButtonSize.md => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      AppButtonSize.lg => const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    };

    final TextStyle textStyle = switch (size) {
      AppButtonSize.sm => Theme.of(context).textTheme.labelMedium!,
      AppButtonSize.md => Theme.of(context).textTheme.labelLarge!,
      AppButtonSize.lg => Theme.of(context).textTheme.titleSmall!,
    };

    Color bg;
    Color fg;
    OutlinedBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    BorderSide? side;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = scheme.primary;
        fg = Colors.black;
        break;
      case AppButtonVariant.secondary:
        bg = scheme.secondaryContainer;
        fg = scheme.onSecondaryContainer;
        break;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = scheme.primary;
        side = BorderSide(color: scheme.primary, width: 1.5);
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = scheme.onSurface;
        break;
      case AppButtonVariant.danger:
        bg = Colors.red.shade600;
        fg = Colors.white;
        break;
      case AppButtonVariant.success:
        bg = Colors.green.shade600;
        fg = Colors.white;
        break;
    }

    final child = isLoading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 18, color: fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: textStyle.copyWith(color: fg, fontWeight: FontWeight.w600)),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(trailingIcon, size: 18, color: fg),
              ]
            ],
          );

    return Material(
      color: bg,
      shape: shape,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        customBorder: shape,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: side != null ? Border.fromBorderSide(side) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
