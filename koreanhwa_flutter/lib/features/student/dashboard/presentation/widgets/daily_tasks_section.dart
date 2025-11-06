import 'package:flutter/material.dart';

class DailyTasksSection extends StatelessWidget {
  const DailyTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = const [
      ('Học 20 từ vựng mới', true, '+50'),
      ('Luyện nghe 30 phút', true, '+30'),
      ('Làm bài tập ngữ pháp', false, '+40'),
      ('Viết 1 đoạn văn ngắn', false, '+60'),
      ('Luyện phát âm với AI', false, '+25'),
    ];
    return _SectionFrame(
      title: 'Nhiệm vụ hôm nay',
      child: Column(
        children: tasks.map((t) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: t.$2 ? const Color(0xFFF0FDF4) : Colors.white,
              border: Border.all(color: t.$2 ? const Color(0xFFBBF7D0) : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(children: [
              Icon(t.$2 ? Icons.check_circle : Icons.schedule, color: t.$2 ? const Color(0xFF10B981) : Colors.grey),
              const SizedBox(width: 12),
              Expanded(child: Text(t.$1, style: TextStyle(fontWeight: t.$2 ? FontWeight.w700 : FontWeight.w500, color: Colors.black87))),
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(999)), child: Text(t.$3, style: const TextStyle(color: Color(0xFF0369A1)))),
              if (!t.$2) ...[
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () {}, child: const Text('Bắt đầu')),
              ],
            ]),
          );
        }).toList(),
      ),
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


