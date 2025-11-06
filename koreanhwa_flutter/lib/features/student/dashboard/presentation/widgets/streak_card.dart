import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

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
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          _StreakTile(label: 'Ngày hiện tại', value: '12', color: Color(0xFFF97316)),
          _StreakTile(label: 'Kỷ lục', value: '25', color: Color(0xFF10B981)),
          _StreakTile(label: 'Tổng ngày học', value: '89', color: Color(0xFF3B82F6)),
        ]),
        const SizedBox(height: 16),
        const Text('Tiến độ hôm nay', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const LinearProgressIndicator(minHeight: 10, value: 25/30, color: Color(0xFFF97316), backgroundColor: Color(0xFFFFEDD5)),
        ),
        const SizedBox(height: 8),
        const Text('Còn 5 phút để hoàn thành mục tiêu', style: TextStyle(color: Colors.black54)),
      ]),
    );
  }
}

class _StreakTile extends StatelessWidget {
  const _StreakTile({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(color: Colors.black54)),
    ]);
  }
}


