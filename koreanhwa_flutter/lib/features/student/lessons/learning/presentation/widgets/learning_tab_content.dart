import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'learning_sidebar.dart' show LessonItem;
import '../providers/learning_providers.dart';
import 'contents/learning_content_video.dart';
import 'contents/learning_content_vocabulary.dart';
import 'contents/learning_content_listening.dart';
import 'contents/learning_content_grammar.dart';
import 'contents/learning_content_exercise.dart';
import 'contents/learning_content_ai_chat.dart';

class LearningTabContent extends ConsumerWidget {
  const LearningTabContent({
    super.key,
    this.currentLesson,
  });

  final LessonItem? currentLesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeTabProvider);

    if (currentLesson == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: const Center(
          child: Text(
            'Vui lòng chọn bài học',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: _buildTabContent(context, ref, activeTab),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, WidgetRef ref, String activeTab) {
    switch (activeTab) {
      case 'video':
        return LearningContentVideo(lesson: currentLesson!);
      case 'vocabulary':
        return const LearningContentVocabulary();
      case 'listening':
        return const LearningContentListening();
      case 'grammar':
        return const LearningContentGrammar();
      case 'exercise':
        return const LearningContentExercise();
      case 'ai-chat':
        return const LearningContentAiChat();
      default:
        return const SizedBox.shrink();
    }
  }
}

