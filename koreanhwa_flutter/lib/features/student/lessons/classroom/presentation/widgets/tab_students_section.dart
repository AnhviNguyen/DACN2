import 'package:flutter/material.dart';

class StudentItem {
  const StudentItem({
    required this.id,
    required this.name,
    required this.avatar,
    required this.joinDate,
    required this.progress,
  });

  final int id;
  final String name;
  final String avatar;
  final String joinDate;
  final int progress; // 0-100
}

class TabStudentsSection extends StatefulWidget {
  const TabStudentsSection({super.key});

  @override
  State<TabStudentsSection> createState() => _TabStudentsSectionState();
}

class _TabStudentsSectionState extends State<TabStudentsSection> {
  final TextEditingController _searchController = TextEditingController();

  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _allStudents = [
    StudentItem(
      id: 1,
      name: "Nguyễn Văn A",
      avatar: "A",
      joinDate: "2025-01-15",
      progress: 85,
    ),
    StudentItem(
      id: 2,
      name: "Trần Thị B",
      avatar: "B",
      joinDate: "2025-01-14",
      progress: 92,
    ),
    StudentItem(
      id: 3,
      name: "Lê Minh C",
      avatar: "C",
      joinDate: "2025-01-13",
      progress: 78,
    ),
    StudentItem(
      id: 4,
      name: "Phạm Thị D",
      avatar: "D",
      joinDate: "2025-01-12",
      progress: 95,
    ),
    StudentItem(
      id: 5,
      name: "Hoàng Văn E",
      avatar: "E",
      joinDate: "2025-01-11",
      progress: 67,
    ),
    StudentItem(
      id: 6,
      name: "Ngô Thị F",
      avatar: "F",
      joinDate: "2025-01-10",
      progress: 88,
    ),
    StudentItem(
      id: 7,
      name: "Vũ Minh G",
      avatar: "G",
      joinDate: "2025-01-09",
      progress: 73,
    ),
    StudentItem(
      id: 8,
      name: "Đặng Thị H",
      avatar: "H",
      joinDate: "2025-01-08",
      progress: 91,
    ),
  ];

  List<StudentItem> get _filteredStudents {
    if (_searchController.text.isEmpty) {
      return _allStudents;
    }
    final query = _searchController.text.toLowerCase();
    return _allStudents
        .where((student) => student.name.toLowerCase().contains(query))
        .toList();
  }

  int get _goodProgressCount =>
      _allStudents.where((s) => s.progress >= 80).length;

  int get _averageProgress {
    if (_allStudents.isEmpty) return 0;
    final total = _allStudents.fold<int>(
        0, (sum, student) => sum + student.progress);
    return (total / _allStudents.length).round();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        // Search Bar
        _buildSearchBar(context, theme),
        const SizedBox(height: 16),
        // Stats
        _buildStats(context, theme),
        const SizedBox(height: 16),
        // Students List
        _buildStudentsList(context, theme),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Tìm kiếm học viên...',
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.amber.shade500, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.amber.shade500, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.amber.shade500, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            theme,
            value: '${_allStudents.length}',
            label: 'Tổng học viên',
            color: Colors.black,
          ),
          _buildStatItem(
            context,
            theme,
            value: '$_goodProgressCount',
            label: 'Tiến độ tốt (≥80%)',
            color: Colors.green.shade600,
          ),
          _buildStatItem(
            context,
            theme,
            value: '$_averageProgress%',
            label: 'Tiến độ trung bình',
            color: Colors.blue.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    ThemeData theme, {
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStudentsList(BuildContext context, ThemeData theme) {
    final students = _filteredStudents;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Text(
              'Danh sách học viên (${students.length})',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // List
          ...students.map((student) => _buildStudentItem(context, theme, student)),
        ],
      ),
    );
  }

  Widget _buildStudentItem(
      BuildContext context, ThemeData theme, StudentItem student) {
    // Xác định màu theo progress
    Color progressColor;
    if (student.progress >= 80) {
      progressColor = Colors.green.shade600;
    } else if (student.progress >= 50) {
      progressColor = Colors.blue.shade600;
    } else {
      progressColor = Colors.orange.shade600;
    }

    Color progressBarColor;
    if (student.progress >= 80) {
      progressBarColor = Colors.green.shade500;
    } else if (student.progress >= 50) {
      progressBarColor = Colors.blue.shade500;
    } else {
      progressBarColor = Colors.orange.shade500;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          // Avatar và thông tin
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      student.avatar,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tham gia: ${student.joinDate}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Progress
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${student.progress}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: progressColor,
                    ),
                  ),
                  Text(
                    'Tiến độ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 80,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: student.progress / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressBarColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


