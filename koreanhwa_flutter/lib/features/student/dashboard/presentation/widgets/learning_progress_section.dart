import 'package:flutter/material.dart';

class LearningProgressSection extends StatelessWidget {
  const LearningProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Nghe', 0.75),
      ('Nói', 0.60),
      ('Đọc', 0.85),
      ('Viết', 0.45),
    ];
    return _SectionFrame(
      title: 'Tiến độ học tập',
      child: Column(
        children: items.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(children: [
              SizedBox(width: 80, child: Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87))),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: e.$2,
                    minHeight: 10,
                    backgroundColor: Color(0xFFF1F5F9),
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(width: 40, child: Text('${(e.$2*100).round()}%', textAlign: TextAlign.right)),
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


