import 'package:flutter/material.dart';
import 'package:koreanhwa_flutter/shared/widgets/widgets.dart';

class WidgetsShowcasePage extends StatefulWidget {
  const WidgetsShowcasePage({super.key});

  @override
  State<WidgetsShowcasePage> createState() => _WidgetsShowcasePageState();
}

class _WidgetsShowcasePageState extends State<WidgetsShowcasePage> {
  final _controller = TextEditingController();
  double _progress = .65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Buttons', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              AppButton(label: 'Primary'),
              AppButton(label: 'Secondary', variant: AppButtonVariant.secondary),
              AppButton(label: 'Outline', variant: AppButtonVariant.outline),
              AppButton(label: 'Ghost', variant: AppButtonVariant.ghost),
              AppButton(label: 'Success', variant: AppButtonVariant.success),
              AppButton(label: 'Danger', variant: AppButtonVariant.danger),
            ],
          ),

          const SizedBox(height: 24),
          Text('Inputs', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          AppInput(
            label: 'Email',
            hintText: 'you@example.com',
            controller: _controller,
            prefix: const Icon(Icons.email_outlined),
          ),

          const SizedBox(height: 24),
          Text('Cards', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const AppCard(
            child: Text('This is an AppCard with default padding'),
          ),

          const SizedBox(height: 24),
          Text('Badges', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
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

          const SizedBox(height: 24),
          Text('Loading', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Row(
            children: [
              AppLoading(),
              SizedBox(width: 12),
              AppLoading(variant: AppLoadingVariant.dots, text: 'Loading...'),
            ],
          ),

          const SizedBox(height: 24),
          Text('Progress Bar', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
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

          const SizedBox(height: 24),
          Text('Avatar', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
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

          const SizedBox(height: 24),
          Text('Modal', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          AppButton(
            label: 'Open Modal',
            onPressed: () {
              showAppModal(
                context: context,
                title: 'Confirm',
                content: const Text('Do you want to continue?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  FilledButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
