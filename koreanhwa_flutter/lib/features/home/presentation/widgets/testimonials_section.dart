import 'package:flutter/material.dart';

import 'home_colors.dart';

class HomeTestimonialsSection extends StatelessWidget {
  const HomeTestimonialsSection({super.key});

  static const List<_ReviewData> _reviews = [
    _ReviewData(
      name: 'Tra My',
      avatarUrl:
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      content:
          'Beginner Korean Course (Online)\nI had never studied Korean before, but after taking this beginner course, I was able to learn the alphabet and basic sentence patterns. The teacher explains things very clearly and is always ready to help.',
      stars: 5,
    ),
    _ReviewData(
      name: 'Jin Woo',
      avatarUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=80',
      content:
          'Speaking Class (Hybrid)\nThe lessons feel immersive and practical. I feel more confident holding conversations with native speakers after a few weeks.',
      stars: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.22),
              blurRadius: 32,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: homeBrandYellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'What Our Students Say',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'High-quality Korean courses with easy-to-understand content, suitable for every level.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ..._reviews.map(
              (review) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        child: Image.network(
                          review.avatarUrl,
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
                              review.content,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black87,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  review.name,
                                  style:
                                      theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                for (int i = 0; i < review.stars; i++)
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 18,
                                    color: homeBrandYellow,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: const StadiumBorder(),
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Read more'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewData {
  const _ReviewData({
    required this.name,
    required this.avatarUrl,
    required this.content,
    required this.stars,
  });

  final String name;
  final String avatarUrl;
  final String content;
  final int stars;
}

