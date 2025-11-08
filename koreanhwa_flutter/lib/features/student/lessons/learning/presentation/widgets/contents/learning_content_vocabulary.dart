import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/learning_providers.dart';

// Model cho vocabulary word
class VocabularyWord {
  const VocabularyWord({
    required this.korean,
    required this.vietnamese,
    required this.pronunciation,
    required this.example,
  });

  final String korean;
  final String vietnamese;
  final String pronunciation;
  final String example;
}

class LearningContentVocabulary extends ConsumerWidget {
  const LearningContentVocabulary({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _vocabulary = [
    VocabularyWord(
      korean: '안녕하세요',
      vietnamese: 'Xin chào',
      pronunciation: 'an-nyeong-ha-se-yo',
      example: '안녕하세요, 저는 마이클입니다.',
    ),
    VocabularyWord(
      korean: '감사합니다',
      vietnamese: 'Cảm ơn',
      pronunciation: 'gam-sa-ham-ni-da',
      example: '감사합니다, 선생님.',
    ),
    VocabularyWord(
      korean: '안녕히 가세요',
      vietnamese: 'Tạm biệt',
      pronunciation: 'an-nyeong-hi ga-se-yo',
      example: '안녕히 가세요, 내일 봐요.',
    ),
    VocabularyWord(
      korean: '네',
      vietnamese: 'Vâng',
      pronunciation: 'ne',
      example: '네, 알겠습니다.',
    ),
    VocabularyWord(
      korean: '아니요',
      vietnamese: 'Không',
      pronunciation: 'a-ni-yo',
      example: '아니요, 모르겠습니다.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header với flashcard button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Từ vựng bài học',
              style: theme.textTheme.headlineSmall,
            ),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(showVocabularyModalProvider.notifier).state = true;
                // TODO: Open flashcard modal
              },
              icon: const Icon(Icons.style, size: 16),
              label: const Text('Học bằng flashcard'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Vocabulary grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _vocabulary.length,
              itemBuilder: (context, index) {
                return _buildVocabularyCard(context, theme, colorScheme, _vocabulary[index]);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildVocabularyCard(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    VocabularyWord word,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  word.korean,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up, size: 16),
                onPressed: () {
                  // TODO: Play pronunciation audio
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          Text(
            word.vietnamese,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              word.pronunciation,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              word.example,
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

