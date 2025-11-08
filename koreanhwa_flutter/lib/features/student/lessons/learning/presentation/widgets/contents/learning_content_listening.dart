import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/learning_providers.dart';

// Model cho listening exercise
class ListeningExercise {
  const ListeningExercise({
    required this.id,
    required this.title,
    required this.audioText,
    required this.options,
    this.correctAnswerIndex,
  });

  final int id;
  final String title;
  final String audioText;
  final List<String> options;
  final int? correctAnswerIndex;
}

class LearningContentListening extends ConsumerWidget {
  const LearningContentListening({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _exercises = [
    ListeningExercise(
      id: 1,
      title: 'Bài tập 1: Nghe và chọn đáp án đúng',
      audioText: '안녕하세요, 저는 마이클입니다.',
      options: [
        'A. Xin chào, tôi là Michael',
        'B. Tạm biệt, tôi là Michael',
        'C. Cảm ơn, tôi là Michael',
      ],
      correctAnswerIndex: 0,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Luyện nghe',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        ..._exercises.map((exercise) => _buildListeningExercise(
              context,
              theme,
              colorScheme,
              ref,
              exercise,
            )),
      ],
    );
  }

  Widget _buildListeningExercise(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    WidgetRef ref,
    ListeningExercise exercise,
  ) {
    final selectedAnswer = ref.watch(listeningAnswersProvider)[exercise.id];
    final isPlaying = ref.watch(playingListeningIdProvider) == exercise.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nghe câu sau và chọn nghĩa đúng:',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (isPlaying) {
                    ref.read(playingListeningIdProvider.notifier).state = null;
                  } else {
                    ref.read(playingListeningIdProvider.notifier).state = exercise.id;
                    // TODO: Play audio
                  }
                },
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  exercise.audioText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...exercise.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = selectedAnswer == index;

            return RadioListTile<int>(
              value: index,
              groupValue: selectedAnswer,
              onChanged: (value) {
                final currentAnswers = ref.read(listeningAnswersProvider);
                ref.read(listeningAnswersProvider.notifier).state = {
                  ...currentAnswers,
                  exercise.id: value,
                };
              },
              title: Text(
                option,
                style: theme.textTheme.bodySmall,
              ),
              activeColor: colorScheme.primary,
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }
}

