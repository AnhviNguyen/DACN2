import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.isFree,
    required this.price,
    required this.originalPrice,
    required this.pointsRequired,
    required this.lessons,
    this.accentColor,
  });

  final String title;
  final String description;
  final int progress; // 0..100
  final bool isFree;
  final int price;
  final int originalPrice;
  final int pointsRequired;
  final List<Map<String, dynamic>> lessons; // {title, progress, completedDate, pointsEarned}
  final Color? accentColor;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.accentColor ?? Colors.blue;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 6, height: 44, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999))),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
              const SizedBox(height: 4),
              Text(widget.description, style: const TextStyle(color: Colors.black87)),
            ]),
          ),
        ]),
        const SizedBox(height: 12),
        // Pricing / Points
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          if (widget.isFree)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(999)),
              child: const Text('Miễn phí', style: TextStyle(color: Color(0xFF065F46), fontWeight: FontWeight.w700)),
            )
          else
            Row(children: [
              Text('${widget.price} điểm', style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(width: 6),
              if (widget.originalPrice > widget.price)
                Text('${widget.originalPrice} điểm', style: const TextStyle(color: Colors.black54, decoration: TextDecoration.lineThrough)),
            ]),
          Text('Cần ${widget.pointsRequired} điểm', style: const TextStyle(color: Colors.black54)),
        ]),
        const SizedBox(height: 12),
        // Progress
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Progress', style: TextStyle(fontWeight: FontWeight.w700)),
          Text('${widget.progress}%', style: const TextStyle(fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: widget.progress / 100,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => setState(() => _isExpanded = !_isExpanded),
            child: Text(_isExpanded ? 'Ẩn Chi tiết' : 'Chi tiết'),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          Column(
            children: widget.lessons.map((lesson) {
              final int lp = (lesson['progress'] as int);
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(lesson['title'] as String, style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text('Tiến trình', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Text('$lp%', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                      ]),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: lp / 100,
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade200,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(children: [
                        Text('Hoàn thành: ${lesson['completedDate'] ?? 'Chưa hoàn thành'}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        const SizedBox(width: 8),
                        if ((lesson['pointsEarned'] as int) > 0)
                          Text('+${lesson['pointsEarned']} điểm', style: const TextStyle(fontSize: 12, color: Color(0xFF16A34A), fontWeight: FontWeight.w700)),
                      ]),
                    ]),
                  ),
                  const SizedBox(width: 8),
                  Text(lp == 100 ? '✔' : '✘', style: TextStyle(color: lp == 100 ? color : const Color(0xFFEF4444), fontWeight: FontWeight.w800)),
                ]),
              );
            }).toList(),
          ),
        ],
      ]),
    );
  }
}

