import 'package:flutter/material.dart';

class LessonDashboardHeader extends StatelessWidget {
  const LessonDashboardHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 72,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFFACC15),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
