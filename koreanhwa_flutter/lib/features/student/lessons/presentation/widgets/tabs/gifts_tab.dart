import 'package:flutter/material.dart';

class GiftBonusItem {
  const GiftBonusItem({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

class GiftsTab extends StatelessWidget {
  const GiftsTab({super.key});

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _giftItems = [
    GiftBonusItem(
      title: 'Tài liệu PDF độc quyền',
      description: 'Bộ tài liệu tổng hợp ngữ pháp TOPIK II đầy đủ nhất',
      icon: Icons.picture_as_pdf_outlined,
    ),
    GiftBonusItem(
      title: 'Đề thi thử độc quyền',
      description: '10 đề thi thử TOPIK II với đáp án chi tiết',
      icon: Icons.fact_check_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            'Quà tặng đặc biệt',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoColumns = constraints.maxWidth >= 600;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _giftItems.map((gift) {
                  final cardWidth = isTwoColumns
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth;
                  return SizedBox(
                    width: cardWidth,
                    child: _GiftCard(gift: gift),
                  );
                }).toList(),
              );
            },
          ),
      ],
    );
  }
}

class _GiftCard extends StatelessWidget {
  const _GiftCard({required this.gift});

  final GiftBonusItem gift;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7C2), // gần với bg-yellow-100
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.amber.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              gift.icon,
              size: 24,
              color: const Color(0xFF854D0E),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            gift.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            gift.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}



