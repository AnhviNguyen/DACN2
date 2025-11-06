import 'package:flutter/material.dart';

class CoursesGridSection extends StatelessWidget {
  const CoursesGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(6, (i) => i);
    return _SectionFrame(
      title: 'Các bài đã học',
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 800;
        final crossAxisCount = isNarrow ? 1 : 3;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
          ),
          itemCount: items.length,
          itemBuilder: (_, i) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 6))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Tiêu đề bài học', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
                SizedBox(height: 8),
                Text('Mô tả ngắn...', style: TextStyle(color: Colors.black54)),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: LinearProgressIndicator(value: 0.6, backgroundColor: Color(0xFFF1F5F9), color: Color(0xFF22C55E)),
                ),
              ]),
            );
          },
        );
      }),
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


