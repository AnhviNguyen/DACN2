import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/learning_header.dart';
import '../widgets/learning_sidebar.dart';
import '../widgets/learning_tab_bar.dart';
import '../widgets/learning_tab_content.dart';
import '../widgets/learning_right_sidebar.dart';
import '../widgets/learning_sidebar.dart' show LessonItem;
import '../providers/learning_providers.dart';

class LessonLearningPage extends ConsumerStatefulWidget {
  const LessonLearningPage({super.key});

  @override
  ConsumerState<LessonLearningPage> createState() => _LessonLearningPageState();
}

class _LessonLearningPageState extends ConsumerState<LessonLearningPage> {
  // Mock data - sẽ được thay thế bằng data từ API/provider sau
  static const _lessons = [
    LessonItem(
      id: 1,
      title: "Bài 1: Chào hỏi cơ bản",
      duration: "45 phút",
      isStudied: true,
      isCurrent: true,
      isUnlocked: true,
    ),
    LessonItem(
      id: 2,
      title: "Bài 2: Giới thiệu bản thân",
      duration: "45 phút",
      isStudied: true,
      isCurrent: false,
      isUnlocked: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Set lesson đầu tiên làm current lesson mặc định trong provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final defaultLesson = _lessons.firstWhere((lesson) => lesson.isCurrent,
          orElse: () => _lessons.first);
      ref.read(currentLessonProvider.notifier).updateLesson(defaultLesson);
    });
  }

  void _onLessonSelected(LessonItem lesson) {
    // Cập nhật currentLesson trong provider
    ref.read(currentLessonProvider.notifier).updateLesson(lesson);
    // Đóng drawer nếu đang mở
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLesson = ref.watch(currentLessonProvider);

    return Scaffold(
      // Drawer for lesson list (mobile)
      drawer: Drawer(
        child: LearningSidebar(
          currentLesson: currentLesson,
          onLessonSelected: _onLessonSelected,
        ),
      ),
      // Floating action button for right sidebar (mobile)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              builder: (context, scrollController) => Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Right sidebar content
                    Expanded(
                      child: LearningRightSidebar(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          // Top Navigation Header
          LearningHeader(
            currentLesson: currentLesson,
          ),
          
          // Main Content - Mobile First (Single Column)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Tab Bar
                  const LearningTabBar(),
                  
                  // Tab Content - sẽ tự rebuild khi activeTabProvider thay đổi
                  LearningTabContent(
                    currentLesson: currentLesson,
                  ),
                  
                  // Right Sidebar Content (moved to bottom on mobile)
                  // Can be hidden or shown based on preference
                  // const LearningRightSidebar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

