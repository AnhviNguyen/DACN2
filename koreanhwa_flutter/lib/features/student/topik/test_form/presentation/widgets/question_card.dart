import 'package:flutter/material.dart';

class QuestionOption {
  final String value;
  final String text;
  const QuestionOption({required this.value, required this.text});
}

class QuestionCard extends StatelessWidget {
  final int questionId;
  final String questionText;
  final List<QuestionOption> options;
  final String? selectedValue;
  final ValueChanged<String> onChanged;

  const QuestionCard({
    super.key,
    required this.questionId,
    required this.questionText,
    required this.options,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$questionId',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  questionText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: options
                .map(
                  (opt) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: selectedValue == opt.value
                          ? Colors.amber.shade100
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedValue == opt.value
                            ? Colors.amber.shade400
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: RadioListTile<String>(
                      value: opt.value,
                      groupValue: selectedValue,
                      onChanged: (val) {
                        if (val != null) onChanged(val);
                      },
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      title: Row(
                        children: [
                          Text(
                            '${opt.value}.',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              opt.text,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}


