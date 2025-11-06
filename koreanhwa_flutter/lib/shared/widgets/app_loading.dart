import 'package:flutter/material.dart';

enum AppLoadingVariant { spinner, dots }
enum AppLoadingSize { sm, md, lg }

class AppLoading extends StatelessWidget {
  final AppLoadingVariant variant;
  final AppLoadingSize size;
  final String? text;

  const AppLoading({
    super.key,
    this.variant = AppLoadingVariant.spinner,
    this.size = AppLoadingSize.md,
    this.text,
  });

  double get _dimension => switch (size) {
        AppLoadingSize.sm => 16,
        AppLoadingSize.md => 24,
        AppLoadingSize.lg => 36,
      };

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    Widget loader;
    switch (variant) {
      case AppLoadingVariant.spinner:
        loader = SizedBox(
          width: _dimension,
          height: _dimension,
          child: CircularProgressIndicator(strokeWidth: 2.5, color: color),
        );
        break;
      case AppLoadingVariant.dots:
        loader = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(color),
            const SizedBox(width: 4),
            _dot(color.withOpacity(.8)),
            const SizedBox(width: 4),
            _dot(color.withOpacity(.6)),
          ],
        );
        break;
    }

    if (text == null) return loader;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        loader,
        const SizedBox(width: 8),
        Text(text!, style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }

  Widget _dot(Color color) => Container(
        width: _dimension / 3,
        height: _dimension / 3,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
