import 'package:flutter/material.dart';

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Trần Thị B', 2840, 15),
      ('Lê Văn C', 2650, 12),
      ('Phạm Thị D', 2480, 8),
      ('Hoàng Văn E', 2320, 5),
      ('Nguyễn Văn A', 450, 12),
    ];
    return _SectionFrame(
      title: 'Bảng xếp hạng',
      child: Column(children: items.asMap().entries.map((entry) {
        final i = entry.key + 1;
        final e = entry.value;
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
            CircleAvatar(backgroundColor: const Color(0xFFE5E7EB), child: Text('$i', style: const TextStyle(color: Colors.black87))),
            const SizedBox(width: 12),
            Expanded(child: Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87))),
            const SizedBox(width: 12),
            Text('${e.$2} điểm', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            const Text('Streak: ', style: TextStyle(color: Colors.black54)),
            Text('${e.$3} ngày', style: const TextStyle(color: Colors.black87)),
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


