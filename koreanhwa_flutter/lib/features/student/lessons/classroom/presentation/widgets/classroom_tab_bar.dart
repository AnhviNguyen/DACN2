import 'package:flutter/material.dart';
import 'package:koreanhwa_flutter/features/student/lessons/shared/widgets/content_tab.dart';

import 'tab_reviews_section.dart';
import 'tab_students_section.dart';

class ClassroomTabBar extends StatefulWidget {
  const ClassroomTabBar({super.key});

  @override
  State<ClassroomTabBar> createState() => _ClassroomTabBarState();
}

class _ClassroomTabBarState extends State<ClassroomTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<GlobalKey> _tabKeys = List.generate(3, (_) => GlobalKey());
  double? _maxTabHeight;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging && mounted) {
          _measureTabs();
          setState(() {});
        }
      });
    // Đo chiều cao sau khi build lần đầu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureTabs();
    });
  }

  void _measureTabs() {
    double maxHeight = 0;
    for (final key in _tabKeys) {
      final context = key.currentContext;
      if (context != null) {
        final height = context.size?.height ?? 0;
        if (height > maxHeight) {
          maxHeight = height;
        }
      }
    }
    if (maxHeight > 0 &&
        (_maxTabHeight == null || _maxTabHeight! < maxHeight)) {
      setState(() {
        _maxTabHeight = maxHeight;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: const Color(0xFF6B7280),
            indicatorColor: Colors.transparent,
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'Nội dung khóa học'),
              Tab(text: 'Đánh giá khóa học'),
              Tab(text: 'Danh sách học viên'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            return Stack(
              children: [
                // Render tất cả tabs ẩn để đo chiều cao
                Positioned(
                  left: -9999,
                  top: -9999,
                  child: Opacity(
                    opacity: 0,
                    child: SizedBox(
                      width: availableWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MeasurableTab(
                            key: _tabKeys[0],
                            child: const ContentTab(),
                          ),
                          _MeasurableTab(
                            key: _tabKeys[1],
                            child: const TabReviewsSection(),
                          ),
                          _MeasurableTab(
                            key: _tabKeys[2],
                            child: const TabStudentsSection(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // TabBarView hiển thị
                SizedBox(
                  height: _maxTabHeight ?? 600, // Fallback height
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ContentTab(),
                      TabReviewsSection(),
                      TabStudentsSection(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// Helper widget để đo chiều cao tab
class _MeasurableTab extends StatelessWidget {
  const _MeasurableTab({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

