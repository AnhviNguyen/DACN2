import 'package:flutter/material.dart';

class RecentAchievementItem extends StatelessWidget {
  const RecentAchievementItem({super.key, required this.icon, required this.title, required this.description, required this.points, required this.date, required this.color});

  final IconData icon;
  final String title;
  final String description;
  final int points;
  final String date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.9), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87)),
              const SizedBox(height: 4),
              Text(description, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 8),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(999)),
                  child: Text('+$points điểm', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.black87)),
                ),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              ]),
            ]),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.emoji_events, color: Color(0xFFF59E0B), size: 20),
        ],
      ),
    );
  }
}

