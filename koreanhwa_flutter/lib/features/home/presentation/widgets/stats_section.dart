import 'package:flutter/material.dart';

import 'home_colors.dart';

class HomeStatsSection extends StatelessWidget {
  const HomeStatsSection({super.key});

  static const List<Map<String, String>> _stats = [
    {'value': '10,000+', 'label': 'Students'},
    {'value': '500+', 'label': 'Lessons'},
    {'value': '50+', 'label': 'Courses'},
    {'value': '95%', 'label': 'Satisfaction'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Wrap(
          spacing: 24,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: _stats
              .map(
                (stat) => SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        stat['value']!,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: homeBrandYellow,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        stat['label']!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

