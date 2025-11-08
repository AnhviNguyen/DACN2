import 'package:flutter/material.dart';

import 'package:koreanhwa_flutter/shared/widgets/widgets.dart';

class WidgetsShowcasePage extends StatefulWidget {
  const WidgetsShowcasePage({super.key});

  @override
  State<WidgetsShowcasePage> createState() => _WidgetsShowcasePageState();
}

class _WidgetsShowcasePageState extends State<WidgetsShowcasePage> {
  final _controller = TextEditingController();
  final _passwordController = TextEditingController();
  double _progress = .65;

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget sectionTitle(String text) => Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(text, style: theme.textTheme.headlineSmall),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Widgets Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Theme Colors', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ColorSwatch(label: 'Primary', color: colorScheme.primary),
              _ColorSwatch(label: 'Secondary', color: colorScheme.secondary),
              _ColorSwatch(label: 'Tertiary', color: colorScheme.tertiary),
              _ColorSwatch(
                label: 'Surface',
                color: colorScheme.surface,
                foreground: theme.colorScheme.onSurface,
              ),
              _ColorSwatch(
                label: 'Background',
                color: theme.scaffoldBackgroundColor,
                foreground: Colors.black87,
              ),
            ],
          ),

          sectionTitle('Typography (App Theme)'),
          _TypographyPreview(textTheme: theme.textTheme),

          sectionTitle('Buttons'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              AppButton(label: 'Primary'),
              AppButton(
                label: 'Secondary',
                variant: AppButtonVariant.secondary,
              ),
              AppButton(label: 'Outline', variant: AppButtonVariant.outline),
              AppButton(label: 'Ghost', variant: AppButtonVariant.ghost),
              AppButton(label: 'Success', variant: AppButtonVariant.success),
              AppButton(label: 'Danger', variant: AppButtonVariant.danger),
            ],
          ),

          sectionTitle('Custom Buttons'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              CustomButton(
                label: 'Leading Icon',
                leadingIcon: Icons.star_rounded,
                onPressed: () {},
              ),
              CustomButton(
                label: 'Trailing Icon',
                trailingIcon: Icons.arrow_forward_rounded,
                variant: AppButtonVariant.secondary,
                onPressed: () {},
              ),
              CustomButton(label: 'Loading', isLoading: true),
            ],
          ),

          sectionTitle('Inputs'),
          AppInput(
            label: 'Email',
            hintText: 'you@example.com',
            controller: _controller,
            prefix: const Icon(Icons.email_outlined),
          ),

          sectionTitle('Custom Text Fields'),
          CustomTextField(
            label: 'Password',
            hintText: '••••••••',
            controller: _passwordController,
            obscureText: true,
            suffixIcon: const Icon(Icons.visibility_off_rounded),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Search',
            hintText: 'Tìm kiếm khóa học...',
            prefixIcon: const Icon(Icons.search_rounded),
            errorText: 'Từ khoá quá ngắn',
          ),

          sectionTitle('Cards'),
          const AppCard(child: Text('This is an AppCard with default padding')),

          sectionTitle('Badges'),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              AppBadge(text: 'Primary'),
              AppBadge(text: 'Success', variant: AppBadgeVariant.success),
              AppBadge(text: 'Warning', variant: AppBadgeVariant.warning),
              AppBadge(text: 'Danger', variant: AppBadgeVariant.danger),
              AppBadge(text: 'Info', variant: AppBadgeVariant.info),
            ],
          ),

          sectionTitle('Loading'),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppLoading(),
              AppLoading(variant: AppLoadingVariant.dots, text: 'Loading...'),
              AppLoading(size: AppLoadingSize.lg),
            ],
          ),

          sectionTitle('Progress Bar'),
          AppProgressBar(value: _progress, showLabel: true),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Adjust: '),
              Expanded(
                child: Slider(
                  value: _progress,
                  onChanged: (v) => setState(() => _progress = v),
                ),
              ),
            ],
          ),

          sectionTitle('Avatar'),
          Wrap(
            spacing: 16,
            children: const [
              AppAvatar(initials: 'KA'),
              AppAvatar(
                imageUrl: 'https://i.pravatar.cc/150?img=12',
                statusColor: Colors.green,
              ),
              AppAvatar(
                imageUrl: 'https://i.pravatar.cc/150?img=22',
                statusColor: Colors.orange,
                size: 64,
              ),
            ],
          ),

          sectionTitle('Modal'),
          AppButton(
            label: 'Open Modal',
            onPressed: () {
              showAppModal(
                context: context,
                title: 'Confirm',
                content: const Text('Do you want to continue?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.label,
    required this.color,
    this.foreground,
  });

  final String label;
  final Color color;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final textColor = foreground ?? _bestForeground(color);
    return Container(
      width: 132,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
      ),
    );
  }

  Color _bestForeground(Color background) {
    final luminance = background.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class _TypographyPreview extends StatelessWidget {
  const _TypographyPreview({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final entries = <_TypographyEntry>[
      _TypographyEntry('Display Large', textTheme.displayLarge),
      _TypographyEntry('Display Medium', textTheme.displayMedium),
      _TypographyEntry('Display Small', textTheme.displaySmall),
      _TypographyEntry('Headline Large', textTheme.headlineLarge),
      _TypographyEntry('Headline Medium', textTheme.headlineMedium),
      _TypographyEntry('Headline Small', textTheme.headlineSmall),
      _TypographyEntry('Title Large', textTheme.titleLarge),
      _TypographyEntry('Title Medium', textTheme.titleMedium),
      _TypographyEntry('Title Small', textTheme.titleSmall),
      _TypographyEntry('Body Large', textTheme.bodyLarge),
      _TypographyEntry('Body Medium', textTheme.bodyMedium),
      _TypographyEntry('Body Small', textTheme.bodySmall),
      _TypographyEntry('Label Large', textTheme.labelLarge),
      _TypographyEntry('Label Medium', textTheme.labelMedium),
      _TypographyEntry('Label Small', textTheme.labelSmall),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            entries
                .map(
                  (entry) =>
                      _TypographyRow(label: entry.label, style: entry.style),
                )
                .toList(),
      ),
    );
  }
}

class _TypographyEntry {
  const _TypographyEntry(this.label, this.style);

  final String label;
  final TextStyle? style;
}

class _TypographyRow extends StatelessWidget {
  const _TypographyRow({required this.label, required this.style});

  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text('Sphinx of black quartz, judge my vow 12345', style: style),
        ],
      ),
    );
  }
}
