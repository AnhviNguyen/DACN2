import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/learning_providers.dart';

class LearningTabBar extends ConsumerWidget {
  const LearningTabBar({super.key});

  final List<Map<String, dynamic>> _tabs = const [
    {'id': 'video', 'name': 'Video bài giảng', 'icon': Icons.video_library},
    {'id': 'vocabulary', 'name': 'Từ vựng', 'icon': Icons.bookmark},
    {'id': 'listening', 'name': 'Luyện nghe', 'icon': Icons.headphones},
    {'id': 'grammar', 'name': 'Ngữ pháp', 'icon': Icons.menu_book},
    {'id': 'exercise', 'name': 'Bài tập', 'icon': Icons.edit},
    {'id': 'ai-chat', 'name': 'Chat AI', 'icon': Icons.psychology},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeTabProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _tabs.map((tab) {
          final tabId = tab['id'] as String;
          final isActive = activeTab == tabId;
          return GestureDetector(
            onTap: () {
              ref.read(activeTabProvider.notifier).state = tabId;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? colorScheme.primary : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tab['icon'] as IconData,
                    size: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tab['name'] as String,
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

