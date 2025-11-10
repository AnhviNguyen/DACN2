import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/roadmap_providers.dart';

class MyRoadmapOverviewCard extends ConsumerWidget {
  const MyRoadmapOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final levels = ref.watch(roadmapLevelsProvider);
    final selectedLevelId = ref.watch(selectedRoadmapLevelProvider);

    final selectedLevel = levels.firstWhere(
      (level) => level.id == selectedLevelId,
      orElse: () => levels.first,
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 36,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cấu trúc Lộ trình',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Lộ trình được chia nhỏ thành ',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: 'từng dạng bài',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' đang có trong đề thi TOPIK hiện hành.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Mỗi dạng bài sẽ có ',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
                TextSpan(
                  text: '1 mục tiêu điểm ',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'được các giáo viên đặt ra. Để đạt điểm TOPIK, bạn nên chinh phục những mốc này.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _RoadmapStats(level: selectedLevel),
          const SizedBox(height: 24),
          _LevelDropdown(
            levels: levels,
            selectedLevelId: selectedLevelId,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                textStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Đi tới bài kiểm tra cấp độ ${selectedLevel.name} (đang phát triển)',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_fill_rounded),
              label: const Text('Bắt đầu ngay'),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapStats extends StatelessWidget {
  const _RoadmapStats({required this.level});

  final RoadmapLevel level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _StatItem(
            value: level.duration,
            label: 'Thời gian',
            color: level.color,
          ),
          Container(
            width: 1,
            height: 48,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
          ),
          _StatItem(
            value: level.questionCount,
            label: 'Số câu',
            color: level.color,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _LevelDropdown extends ConsumerWidget {
  const _LevelDropdown({
    required this.levels,
    required this.selectedLevelId,
  });

  final List<RoadmapLevel> levels;
  final String selectedLevelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Chọn cấp độ để bắt đầu',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedLevelId,
          icon: Icon(
            Icons.expand_more_rounded,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest
                .withValues(alpha: 0.6),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
                width: 1.4,
              ),
            ),
          ),
          dropdownColor: theme.colorScheme.surface,
          items: levels
              .map(
                (level) => DropdownMenuItem<String>(
                  value: level.id,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: level.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        level.name,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            ref.read(selectedRoadmapLevelProvider.notifier).selectLevel(value);
          },
        ),
      ],
    );
  }
}

