import 'dart:async';
import 'package:flutter/material.dart';

class LessonInfoBuyCard extends StatefulWidget {
  const LessonInfoBuyCard({super.key});

  @override
  State<LessonInfoBuyCard> createState() => _LessonInfoBuyCardState();
}

class _LessonInfoBuyCardState extends State<LessonInfoBuyCard> {
  // Mock data (tham chiếu Sidebar React)
  final int originalPrice = 1900000; // 1,900,000 đ
  final int currentPrice = 1430000; // 1,430,000 đ
  final int discountPercent = 25; // -25%

  late DateTime _endTime; // thời điểm kết thúc khuyến mãi
  late Timer _timer;
  Duration _remaining = Duration.zero;
  bool _isWishlisted = false;

  @override
  void initState() {
    super.initState();
    // Countdown 3 ngày từ bây giờ (mock)
    _endTime = DateTime.now().add(
      const Duration(days: 3, hours: 5, minutes: 12, seconds: 34),
    );
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final now = DateTime.now();
    setState(() {
      _remaining =
          _endTime.isAfter(now) ? _endTime.difference(now) : Duration.zero;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCurrency(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final reverseIndex = s.length - i - 1;
      buffer.write(s[i]);
      final posFromEnd = s.length - i - 1;
      if (reverseIndex > 0 && posFromEnd % 3 == 0) buffer.write('.');
    }
    return '${buffer.toString()} đ';
  }

  (String days, String hours, String minutes, String seconds) _parts(
    Duration d,
  ) {
    final totalSeconds = d.inSeconds;
    final days = totalSeconds ~/ (24 * 3600);
    final hours = (totalSeconds % (24 * 3600)) ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return (
      days.toString().padLeft(2, '0'),
      hours.toString().padLeft(2, '0'),
      minutes.toString().padLeft(2, '0'),
      seconds.toString().padLeft(2, '0'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (d, h, m, s) = _parts(_remaining);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Giá và giảm giá
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatCurrency(currentPrice),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          _formatCurrency(originalPrice),
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '-$discountPercent%',
                            style: const TextStyle(
                              color: Color(0xFFB45309),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _isWishlisted = !_isWishlisted),
                icon: Icon(
                  _isWishlisted
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color:
                      _isWishlisted ? const Color(0xFFE11D48) : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Countdown
          Column(
            spacing: 12,
            children: [
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.star_rate_rounded,
                          color: Color(0xFFFACC15),
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '5.0',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '- 2 đánh giá',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Giảng viên: Ninh Thị Thúy',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            '45 bài giảng',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            '90 ngày',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.group_add_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      '3,463 học viên',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thời gian ưu đãi còn lại',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _timeBox(label: 'Ngày', value: d),
                    _timeBox(label: 'Giờ', value: h),
                    _timeBox(label: 'Phút', value: m),
                    _timeBox(label: 'Giây', value: s),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Actions
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFACC15),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.w800),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child:  Column(
              spacing: 4,
              children: [
                const Text('ĐĂNG KÝ KHÓA HỌC'),
                Text('(Đi Đến Phòng Học)',
                style: theme.textTheme.labelMedium,)
              ],
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => setState(() => _isWishlisted = !_isWishlisted),
            icon: Icon(
              _isWishlisted
                  ? Icons.check_rounded
                  : Icons.bookmark_border_rounded,
              size: 18,
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(color: Color(0xFFE5E7EB)),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
            label: Text(_isWishlisted ? 'ĐÃ LƯU KHÓA HỌC' : 'LƯU KHÓA HỌC'),
          ),
        ],
      ),
    );
  }

  Widget _timeBox({required String label, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF27272A)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFFFACC15),
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
