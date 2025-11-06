import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Hoàn thành 50 bài học', 'Đã hoàn thành 50 bài học đầu tiên', '+100 điểm'),
      ('Streak 10 ngày', 'Duy trì học tập 10 ngày liên tiếp', '+50 điểm'),
      ('Thành thạo 100 từ vựng', 'Học thuộc 100 từ vựng cơ bản', '+75 điểm'),
    ];
    return _SectionFrame(
      title: 'Thành tích gần đây',
      child: Column(children: items.map((e) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 6))],
          ),
          child: Row(children: [
            const Icon(Icons.emoji_events, color: Color(0xFFF59E0B)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
              const SizedBox(height: 4),
              Text(e.$2, style: const TextStyle(color: Colors.black54)),
            ])),
            const SizedBox(width: 8),
            Text(e.$3, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
          ]),
        );
      }).toList()),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87)),
        const SizedBox(height: 12),
        child,
      ]),
    );
  }
}


