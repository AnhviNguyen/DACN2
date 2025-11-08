import 'package:flutter/material.dart';

import '../../../shared/widgets/content_tab.dart';
import 'tabs/gifts_tab.dart';
import 'tabs/instructor_tab.dart';
import 'tabs/intro_tab.dart';
import 'tabs/reviews_tab.dart';

class LessonInfoTabSection extends StatefulWidget {
  const LessonInfoTabSection({super.key});

  @override
  State<LessonInfoTabSection> createState() => _LessonInfoTabSectionState();
}

class _LessonInfoTabSectionState extends State<LessonInfoTabSection>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<GlobalKey> _tabKeys = List.generate(5, (_) => GlobalKey());
  double? _maxTabHeight;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging && mounted) {
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
    if (maxHeight > 0 && (_maxTabHeight == null || _maxTabHeight! < maxHeight)) {
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

  // Helper method để tạo Container wrapper chung cho các tab
  Widget _buildTabWrapper(Widget child) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFDE68A), // border-yellow-200
          width: 1,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Colors.transparent,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: const Color(0xFF6B7280),
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              tabs: const [
                Tab(icon: Icon(Icons.info_outline_rounded), text: 'Giới thiệu'),
                Tab(icon: Icon(Icons.list_alt_rounded), text: 'Nội dung'),
                Tab(
                  icon: Icon(Icons.person_outline_rounded),
                  text: 'Giảng viên',
                ),
                Tab(icon: Icon(Icons.card_giftcard_rounded), text: 'Quà tặng'),
                Tab(icon: Icon(Icons.rate_review_rounded), text: 'Đánh giá'),
              ],
            ),
          ),
          const SizedBox(height: 14),
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
                              child: _buildTabWrapper(const IntroTab()),
                            ),
                            _MeasurableTab(
                              key: _tabKeys[1],
                              child: const ContentTab(),
                            ),
                            _MeasurableTab(
                              key: _tabKeys[2],
                              child: _buildTabWrapper(const InstructorTab()),
                            ),
                            _MeasurableTab(
                              key: _tabKeys[3],
                              child: _buildTabWrapper(const GiftsTab()),
                            ),
                            _MeasurableTab(
                              key: _tabKeys[4],
                              child: _buildTabWrapper(const ReviewsTab()),
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
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildTabWrapper(const IntroTab()),
                        const ContentTab(),
                        _buildTabWrapper(const InstructorTab()),
                        _buildTabWrapper(const GiftsTab()),
                        _buildTabWrapper(const ReviewsTab()),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
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
