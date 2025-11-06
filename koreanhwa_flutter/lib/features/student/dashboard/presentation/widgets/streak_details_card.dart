import 'package:flutter/material.dart';

class StreakDetailsCard extends StatefulWidget {
  const StreakDetailsCard({super.key});

  @override
  State<StreakDetailsCard> createState() => _StreakDetailsCardState();
}

class _StreakDetailsCardState extends State<StreakDetailsCard> {
  bool _showDetails = false;

  final _streakData = {
    'currentStreak': 12,
    'longestStreak': 25,
    'totalStudyDays': 89,
    'todayGoal': 30,
    'todayProgress': 25,
    'streakHistory': List.generate(30, (i) => {
      'date': DateTime.now().subtract(Duration(days: 29 - i)).toString().split(' ')[0],
      'studied': i % 3 != 0,
      'minutes': i % 3 != 0 ? [45, 60, 30, 90, 75][i % 5] : 0,
    }),
    'milestones': [
      {'days': 7, 'achieved': true, 'reward': 'Huy hiệu 7 ngày', 'icon': Icons.star},
      {'days': 14, 'achieved': true, 'reward': 'Huy hiệu 2 tuần', 'icon': Icons.emoji_events},
      {'days': 30, 'achieved': false, 'reward': 'Huy hiệu 1 tháng', 'icon': Icons.workspace_premium},
      {'days': 100, 'achieved': false, 'reward': 'Huy hiệu 100 ngày', 'icon': Icons.military_tech},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final todayProgress = (_streakData['todayProgress'] as num).toDouble();
    final todayGoal = (_streakData['todayGoal'] as num).toDouble();
    final progress = todayProgress / todayGoal;
    final remaining = (todayGoal - todayProgress).toInt();
    final milestones = _streakData['milestones'] as List;
    final nextMilestone = milestones.cast<Map>().firstWhere(
      (m) => !(m['achieved'] as bool),
      orElse: () => <String, dynamic>{},
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_fire_department, color: Color(0xFFF97316)),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Streak học tập', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFF97316))),
                      Text('Duy trì động lực học tập', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () => setState(() => _showDetails = !_showDetails),
                icon: Icon(_showDetails ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFF97316)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StreakStatTile(label: 'Ngày hiện tại', value: '${_streakData['currentStreak']}', color: const Color(0xFFF97316))),
              const SizedBox(width: 8),
              Expanded(child: _StreakStatTile(label: 'Kỷ lục', value: '${_streakData['longestStreak']}', color: const Color(0xFFF97316))),
              const SizedBox(width: 8),
              Expanded(child: _StreakStatTile(label: 'Tổng ngày học', value: '${_streakData['totalStudyDays']}', color: const Color(0xFFF97316))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tiến độ hôm nay', style: TextStyle(fontWeight: FontWeight.w700)),
              Text('${_streakData['todayProgress']}/${_streakData['todayGoal']} phút', style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: progress,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF10B981),
            ),
          ),
          const SizedBox(height: 8),
          Text('Còn $remaining phút để hoàn thành mục tiêu', style: const TextStyle(color: Colors.black54)),
          if (_showDetails) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Lịch sử 30 ngày gần nhất:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 10,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1,
              children: (_streakData['streakHistory'] as List).take(30).map((day) {
                final dayMap = day as Map;
                final studied = dayMap['studied'] as bool;
                return Tooltip(
                  message: '${dayMap['date']}: ${studied ? '${dayMap['minutes']} phút học' : 'Không học'}',
                  child: Container(
                    decoration: BoxDecoration(
                      color: studied ? const Color(0xFFF97316) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(studied ? '✓' : '✗', style: TextStyle(color: studied ? Colors.white : Colors.grey.shade600, fontSize: 12)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Cột mốc streak:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.5,
              children: (_streakData['milestones'] as List).map((milestone) {
                final milestoneMap = milestone as Map;
                final achieved = milestoneMap['achieved'] as bool;
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: achieved ? const Color(0xFFF97316).withOpacity(0.2) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(milestoneMap['icon'] as IconData, color: achieved ? const Color(0xFFF97316) : Colors.grey.shade400),
                      const SizedBox(height: 8),
                      Text('${milestoneMap['days']} ngày', style: TextStyle(fontWeight: FontWeight.w700, color: achieved ? Colors.black87 : Colors.black54)),
                      const SizedBox(height: 4),
                      Text(milestoneMap['reward'] as String, style: const TextStyle(fontSize: 10, color: Colors.black54), textAlign: TextAlign.center),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          if (nextMilestone.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),
            Text('Mục tiêu tiếp theo: ${nextMilestone['days']} ngày', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFFF97316))),
          ],
        ],
      ),
    );
  }
}

class _StreakStatTile extends StatelessWidget {
  const _StreakStatTile({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }
}

