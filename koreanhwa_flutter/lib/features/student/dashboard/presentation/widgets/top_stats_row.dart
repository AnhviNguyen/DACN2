import 'package:flutter/material.dart';

class TopStatsRow extends StatelessWidget {
  const TopStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final isNarrow = constraints.maxWidth < 800;
        final children = const [
          _GradientStatCard(
            title: 'Cấp độ hiện tại',
            primary: '450',
            secondary: 'điểm',
            gradient: LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF7C3AED)]),
            icon: Icons.school,
          ),
          _GradientProgressCard(
            title: 'Tiến độ cấp độ',
            percent: 0.30,
            gradient: LinearGradient(colors: [Color(0xFF10B981), Color(0xFF06B6D4)]),
          ),
          _GradientStatCard(
            title: 'Streak hiện tại',
            primary: '12',
            secondary: 'ngày',
            gradient: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFEF4444)]),
            icon: Icons.local_fire_department,
          ),
        ];
        /*if (isNarrow) {
          return Column(
            children: const [
              _StatCard(title: 'Cấp độ hiện tại', primary: '450', secondary: 'điểm'),
              SizedBox(height: 12),
              _ProgressCard(title: 'Tiến độ cấp độ', percent: 0.68),
              SizedBox(height: 12),
              _StatCard(title: 'Streak hiện tại', primary: '12', secondary: 'ngày'),
            ],
          );
        }*/
        return Row(
          children: [
            const Expanded(child: _GradientStatCard(title: 'Cấp độ hiện tại', primary: '450', secondary: 'điểm', gradient: LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF7C3AED)]), icon: Icons.school)),
            const SizedBox(width: 12),
            const Expanded(child: _GradientProgressCard(title: 'Tiến độ cấp độ', percent: 0.30, gradient: LinearGradient(colors: [Color(0xFF10B981), Color(0xFF06B6D4)]))),
            const SizedBox(width: 12),
            const Expanded(child: _GradientStatCard(title: 'Streak hiện tại', primary: '12', secondary: 'ngày', gradient: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFEF4444)]), icon: Icons.local_fire_department)),
          ],
        );
      },
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8)),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: child,
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.primary, required this.secondary});
  final String title;
  final String primary;
  final String secondary;
  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(primary, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(width: 6),
                  Text(secondary, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
          const Icon(Icons.trending_up, color: Colors.white),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.title, required this.percent});
  final String title;
  final double percent;
  @override
  Widget build(BuildContext context) {
    final pct = (percent.clamp(0, 1) * 100).round();
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percent,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text('$pct%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}

class _GradientStatCard extends StatelessWidget {
  const _GradientStatCard({required this.title, required this.primary, required this.secondary, required this.gradient, required this.icon});
  final String title;
  final String primary;
  final String secondary;
  final LinearGradient gradient;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(primary, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(width: 6),
                  Text(secondary, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
          Icon(icon, color: Colors.white),
        ],
      ),
    );
  }
}

class _GradientProgressCard extends StatelessWidget {
  const _GradientProgressCard({required this.title, required this.percent, required this.gradient});
  final String title;
  final double percent;
  final LinearGradient gradient;
  @override
  Widget build(BuildContext context) {
    final pct = (percent.clamp(0, 1) * 100).round();
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percent,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text('$pct%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}


