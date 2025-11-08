import 'package:flutter/material.dart';

import '../lesson_dashboard_data.dart';
import 'lesson_course_card.dart';

class LessonCourseSection extends StatelessWidget {
  const LessonCourseSection({super.key, required this.section});

  final LessonCourseSectionData section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                section.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(section.actionLabel),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Grid-like layout giống CourseCard.jsx (270px width, spacing 12)
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              section.courses
                  .map(
                    (course) => SizedBox(
                      width: 270,
                      child: LessonCourseCard(course: course),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
