import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final top3 = const [
      (1, 'Trần Thị B', 2840, 15, 'https://i.pravatar.cc/150?img=11'),
      (2, 'Lê Văn C', 2650, 12, 'https://i.pravatar.cc/150?img=12'),
      (3, 'Phạm Thị D', 2480, 8, 'https://i.pravatar.cc/150?img=13'),
    ];
    final others = const [
      (4, 'Hoàng Văn E', 2320, 5, 'https://i.pravatar.cc/150?img=14'),
      (5, 'Nguyễn Văn A', 450, 12, 'https://i.pravatar.cc/150?img=15'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Bảng xếp hạng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        Row(
          children: top3.map((u) => Expanded(child: _TopUserTile(rank: u.$1, name: u.$2, points: u.$3, streak: u.$4, avatarUrl: u.$5))).toList(),
        ),
        const SizedBox(height: 16),
        ...others.map((u) => _OtherUserTile(rank: u.$1, name: u.$2, points: u.$3, streak: u.$4, avatarUrl: u.$5)),
      ]),
    );
  }
}

class _TopUserTile extends StatelessWidget {
  const _TopUserTile({required this.rank, required this.name, required this.points, required this.streak, required this.avatarUrl});
  final int rank;
  final String name;
  final int points;
  final int streak;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double avatarSize = size.width < 380 ? 56 : 64;
    final Color badgeColor = rank == 1 ? const Color(0xFFF59E0B) : rank == 2 ? const Color(0xFF9CA3AF) : const Color(0xFFB45309);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(radius: avatarSize / 2, backgroundImage: NetworkImage(avatarUrl)),
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6)]),
                alignment: Alignment.center,
                child: Text('$rank', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
        const SizedBox(height: 4),
        Text('$points điểm • Streak: $streak', style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ]),
    );
  }
}

class _OtherUserTile extends StatelessWidget {
  const _OtherUserTile({required this.rank, required this.name, required this.points, required this.streak, required this.avatarUrl});
  final int rank;
  final String name;
  final int points;
  final int streak;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
            Positioned(
              bottom: -6,
              right: -6,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: const Color(0xFFF59E0B), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text('$rank', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
          const SizedBox(height: 2),
          Text('Streak: $streak ngày', style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ])),
        const SizedBox(width: 12),
        Text('$points điểm', style: const TextStyle(fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

