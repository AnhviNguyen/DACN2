import 'package:flutter/material.dart';

class QuestionOverviewBottomSheet extends StatelessWidget {
  final int totalQuestions;
  final int firstQuestionId;
  final Set<int> answeredQuestionIds;
  final void Function(int index) onJumpToQuestion; // 0-based index
  final VoidCallback onSubmit;

  const QuestionOverviewBottomSheet({
    super.key,
    required this.totalQuestions,
    required this.firstQuestionId,
    required this.answeredQuestionIds,
    required this.onJumpToQuestion,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questionNumbers =
        List<int>.generate(totalQuestions, (i) => firstQuestionId + i);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tổng quan câu hỏi',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Chạm vào số để chuyển nhanh',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.2,
              ),
              itemCount: questionNumbers.length,
              itemBuilder: (context, idx) {
                final number = questionNumbers[idx];
                final answered = answeredQuestionIds.contains(number);
                return ElevatedButton(
                  onPressed: () => onJumpToQuestion(idx),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor:
                        answered ? Colors.green : Colors.amber.shade400,
                    foregroundColor: answered ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '$number',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: answered ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Đóng'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: const Text('Nộp bài'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


