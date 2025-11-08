import 'package:flutter/material.dart';

// Model cho grammar item
class GrammarItem {
  const GrammarItem({
    required this.title,
    required this.explanation,
    required this.examples,
  });

  final String title;
  final String explanation;
  final List<String> examples;
}

class LearningContentGrammar extends StatelessWidget {
  const LearningContentGrammar({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _grammar = [
    GrammarItem(
      title: 'Cấu trúc chào hỏi',
      explanation: '안녕하세요 được sử dụng để chào hỏi một cách lịch sự',
      examples: [
        '안녕하세요, 저는 [이름]입니다. (Xin chào, tôi là [tên])',
        '안녕하세요, 만나서 반갑습니다. (Xin chào, rất vui được gặp bạn)',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ngữ pháp',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        ..._grammar.map((grammar) => _buildGrammarCard(context, theme, colorScheme, grammar)),
      ],
    );
  }

  Widget _buildGrammarCard(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    GrammarItem grammar,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              grammar.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            grammar.explanation,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'Ví dụ:',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...grammar.examples.map((example) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  example,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

