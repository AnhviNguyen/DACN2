import 'package:flutter/material.dart';

import 'home_colors.dart';

class HomeFeaturesSection extends StatelessWidget {
  const HomeFeaturesSection({super.key});

  static const List<_FeatureData> _features = [
    _FeatureData(
      title: 'Interactive Lessons',
      description:
          'Learn Korean through interactive lessons with images, audio, and video.',
      imageUrl:
          'images/home/2.jpg',
    ),
    _FeatureData(
      title: 'Achievement System',
      description:
          'Earn badges and scores when completing lessons and challenges.',
      imageUrl:
          'images/home/2.jpg',
    ),
    _FeatureData(
      title: 'Learning Community',
      description: 'Connect with other learners and share experiences.',
      imageUrl:
          'images/home/2.jpg',
    ),
    _FeatureData(
      title: 'Effective Methods',
      description:
          'Apply scientific learning methods for long-term retention.',
      imageUrl:
          'images/home/2.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose KoreanHwa?',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We provide the best features to help you learn Korean effectively.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.78),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          ..._features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black.withOpacity(0.04)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 18,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Image.asset(
                        feature.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feature.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  const _FeatureData({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String imageUrl;
}

