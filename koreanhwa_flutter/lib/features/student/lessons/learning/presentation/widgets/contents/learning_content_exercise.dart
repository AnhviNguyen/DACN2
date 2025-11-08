import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/learning_providers.dart';

// Model cho exercise
class ExerciseItem {
  const ExerciseItem({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.correctAnswer,
  });

  final int id;
  final String type; // 'multiple_choice' or 'fill_blank'
  final String question;
  final List<String>? options; // For multiple_choice
  final dynamic correctAnswer; // For multiple_choice: int index, for fill_blank: String
}

class LearningContentExercise extends ConsumerWidget {
  const LearningContentExercise({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _exercises = [
    ExerciseItem(
      id: 1,
      type: 'multiple_choice',
      question: 'Cách chào hỏi lịch sự trong tiếng Hàn là gì?',
      options: ['안녕', '안녕하세요', '안녕히 가세요', '감사합니다'],
      correctAnswer: 1,
    ),
    ExerciseItem(
      id: 2,
      type: 'fill_blank',
      question: 'Điền từ thích hợp: "안녕하세요, 저는 마이클___입니다."',
      correctAnswer: '입니다',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSubmitted = ref.watch(isExerciseSubmittedProvider);
    final answers = ref.watch(exerciseAnswersProvider);
    final results = ref.watch(exerciseResultsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bài tập kiểm tra',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        ..._exercises.asMap().entries.map((entry) {
          final index = entry.key;
          final exercise = entry.value;
          return _buildExerciseCard(
            context,
            theme,
            colorScheme,
            ref,
            exercise,
            index + 1,
            isSubmitted,
            answers[exercise.id],
            results[exercise.id],
          );
        }),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: isSubmitted
                ? null
                : () {
                    // Calculate results
                    final newResults = <int, bool>{};
                    for (final exercise in _exercises) {
                      final userAnswer = answers[exercise.id];
                      if (exercise.type == 'multiple_choice') {
                        newResults[exercise.id] = userAnswer == exercise.correctAnswer;
                      } else if (exercise.type == 'fill_blank') {
                        newResults[exercise.id] =
                            (userAnswer as String?)?.toLowerCase().trim() ==
                                (exercise.correctAnswer as String).toLowerCase().trim();
                      }
                    }
                    ref.read(exerciseResultsProvider.notifier).state = newResults;
                    ref.read(isExerciseSubmittedProvider.notifier).state = true;
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Nộp bài'),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    WidgetRef ref,
    ExerciseItem exercise,
    int questionNumber,
    bool isSubmitted,
    dynamic userAnswer,
    bool? isCorrect,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Câu $questionNumber: ${exercise.question}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (exercise.type == 'multiple_choice' && exercise.options != null)
            ...exercise.options!.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = userAnswer == index;
              final showResult = isSubmitted && isCorrect != null;

              return RadioListTile<int>(
                value: index,
                groupValue: userAnswer as int?,
                onChanged: isSubmitted
                    ? null
                    : (value) {
                        final currentAnswers = ref.read(exerciseAnswersProvider);
                        ref.read(exerciseAnswersProvider.notifier).state = {
                          ...currentAnswers,
                          exercise.id: value,
                        };
                      },
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        option,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    if (showResult && isSelected)
                      Icon(
                        isCorrect! ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                        size: 16,
                      ),
                  ],
                ),
                activeColor: colorScheme.primary,
                contentPadding: EdgeInsets.zero,
              );
            }),
          if (exercise.type == 'fill_blank')
            TextField(
              enabled: !isSubmitted,
              decoration: InputDecoration(
                hintText: 'Nhập đáp án...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
              ),
              onChanged: (value) {
                final currentAnswers = ref.read(exerciseAnswersProvider);
                ref.read(exerciseAnswersProvider.notifier).state = {
                  ...currentAnswers,
                  exercise.id: value,
                };
              },
            ),
        ],
      ),
    );
  }
}

