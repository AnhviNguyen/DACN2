import 'package:flutter/material.dart';

class MyScoreCard extends StatelessWidget {
  const MyScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    const int totalScore = 132;

    Widget buildItem({
      required IconData icon,
      required String title,
      required int points,
      required bool highlight,
    }) {
      final Color bgColor = highlight ? const Color(0xFFD1FAE5) : Colors.white;
      final BoxBorder? border = highlight ? null : Border.all(color: Colors.grey.shade200);
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: border,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade700, size: 24),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87))),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(999)),
              child: Text(
                '$points point',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF92400E)),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          // Header - nền cam, bo 2 góc trên
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const Text('My score', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                const Spacer(),
                Text('$totalScore point', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black)),
              ],
            ),
          ),
          // Body - nền trắng, bo 2 góc dưới, chứa 3 mục
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                buildItem(icon: Icons.menu_book, title: 'Learn new words', points: 60, highlight: false),
                buildItem(icon: Icons.headphones, title: 'Listen to new words', points: 60, highlight: true),
                buildItem(icon: Icons.grid_view, title: 'Using new words', points: 60, highlight: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

