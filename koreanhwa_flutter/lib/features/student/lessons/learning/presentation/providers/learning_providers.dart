import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/learning_sidebar.dart' show LessonItem;

// ============================================
// TAB NAVIGATION STATES
// ============================================

/// Active tab trong learning page (video, vocabulary, listening, grammar, exercise, ai-chat)
class ActiveTabNotifier extends Notifier<String> {
  @override
  String build() => 'video';
}

final activeTabProvider = NotifierProvider<ActiveTabNotifier, String>(ActiveTabNotifier.new);

// ============================================
// VIDEO PLAYER STATES
// ============================================

/// Video đang phát hay không
class IsVideoPlayingNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final isVideoPlayingProvider = NotifierProvider<IsVideoPlayingNotifier, bool>(IsVideoPlayingNotifier.new);

/// Video có bị mute không
class IsVideoMutedNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final isVideoMutedProvider = NotifierProvider<IsVideoMutedNotifier, bool>(IsVideoMutedNotifier.new);

/// Video có đang fullscreen không
class IsVideoFullscreenNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final isVideoFullscreenProvider = NotifierProvider<IsVideoFullscreenNotifier, bool>(IsVideoFullscreenNotifier.new);

/// Video progress (0.0 - 1.0)
class VideoProgressNotifier extends Notifier<double> {
  @override
  double build() => 0.0;
}

final videoProgressProvider = NotifierProvider<VideoProgressNotifier, double>(VideoProgressNotifier.new);

// ============================================
// MODAL STATES
// ============================================

/// Hiển thị modal flashcard từ vựng
class ShowVocabularyModalNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final showVocabularyModalProvider = NotifierProvider<ShowVocabularyModalNotifier, bool>(ShowVocabularyModalNotifier.new);

/// Hiển thị modal từ điển
class ShowDictionaryModalNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final showDictionaryModalProvider = NotifierProvider<ShowDictionaryModalNotifier, bool>(ShowDictionaryModalNotifier.new);

// ============================================
// LESSON DATA STATES
// ============================================

/// Lesson hiện tại đang được xem
class CurrentLessonNotifier extends Notifier<LessonItem?> {
  @override
  LessonItem? build() => null;

  void updateLesson(LessonItem? lesson) {
    state = lesson;
  }
}

final currentLessonProvider = NotifierProvider<CurrentLessonNotifier, LessonItem?>(CurrentLessonNotifier.new);

/// Progress tổng thể của lesson (0-100)
class LessonProgressNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

final lessonProgressProvider = NotifierProvider<LessonProgressNotifier, int>(LessonProgressNotifier.new);

/// Progress của từng phần trong lesson
class LessonSectionProgress {
  const LessonSectionProgress({
    this.video = 0,
    this.vocabulary = 0,
    this.exercise = 0,
  });

  final int video; // 0-100
  final int vocabulary; // 0-100
  final int exercise; // 0-100

  LessonSectionProgress copyWith({
    int? video,
    int? vocabulary,
    int? exercise,
  }) {
    return LessonSectionProgress(
      video: video ?? this.video,
      vocabulary: vocabulary ?? this.vocabulary,
      exercise: exercise ?? this.exercise,
    );
  }
}

class LessonSectionProgressNotifier extends Notifier<LessonSectionProgress> {
  @override
  LessonSectionProgress build() => const LessonSectionProgress();
}

final lessonSectionProgressProvider =
    NotifierProvider<LessonSectionProgressNotifier, LessonSectionProgress>(LessonSectionProgressNotifier.new);

// ============================================
// EXERCISE STATES
// ============================================

/// Index của câu hỏi hiện tại trong bài tập
class CurrentExerciseIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

final currentExerciseIndexProvider = NotifierProvider<CurrentExerciseIndexNotifier, int>(CurrentExerciseIndexNotifier.new);

/// Map câu trả lời của user: {exerciseId: answer}
class ExerciseAnswersNotifier extends Notifier<Map<int, dynamic>> {
  @override
  Map<int, dynamic> build() => {};
}

final exerciseAnswersProvider =
    NotifierProvider<ExerciseAnswersNotifier, Map<int, dynamic>>(ExerciseAnswersNotifier.new);

/// Đã nộp bài tập chưa
class IsExerciseSubmittedNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final isExerciseSubmittedProvider = NotifierProvider<IsExerciseSubmittedNotifier, bool>(IsExerciseSubmittedNotifier.new);

/// Kết quả bài tập sau khi nộp: {exerciseId: isCorrect}
class ExerciseResultsNotifier extends Notifier<Map<int, bool>> {
  @override
  Map<int, bool> build() => {};
}

final exerciseResultsProvider =
    NotifierProvider<ExerciseResultsNotifier, Map<int, bool>>(ExerciseResultsNotifier.new);

// ============================================
// LISTENING STATES
// ============================================

/// Map đáp án đã chọn cho listening: {listeningId: selectedAnswerIndex}
class ListeningAnswersNotifier extends Notifier<Map<int, int?>> {
  @override
  Map<int, int?> build() => {};
}

final listeningAnswersProvider =
    NotifierProvider<ListeningAnswersNotifier, Map<int, int?>>(ListeningAnswersNotifier.new);

/// Audio đang phát cho listening exercise nào
class PlayingListeningIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;
}

final playingListeningIdProvider = NotifierProvider<PlayingListeningIdNotifier, int?>(PlayingListeningIdNotifier.new);

// ============================================
// AI CHAT STATES
// ============================================

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });

  final String id;
  final String content;
  final bool isUser; // true = user message, false = AI message
  final DateTime timestamp;
}

/// Danh sách tin nhắn trong AI chat
class AiChatMessagesNotifier extends Notifier<List<ChatMessage>> {
  @override
  List<ChatMessage> build() => [];

  void addMessage(ChatMessage message) {
    state = [...state, message];
  }

  void setMessages(List<ChatMessage> messages) {
    state = messages;
  }
}

final aiChatMessagesProvider =
    NotifierProvider<AiChatMessagesNotifier, List<ChatMessage>>(AiChatMessagesNotifier.new);

/// Input text của user trong AI chat
class AiChatInputNotifier extends Notifier<String> {
  @override
  String build() => '';
}

final aiChatInputProvider = NotifierProvider<AiChatInputNotifier, String>(AiChatInputNotifier.new);

/// AI đang trả lời hay không
class IsAiTypingNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final isAiTypingProvider = NotifierProvider<IsAiTypingNotifier, bool>(IsAiTypingNotifier.new);

// ============================================
// DICTIONARY STATES
// ============================================

/// Từ đang tìm kiếm trong dictionary
class DictionarySearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
}

final dictionarySearchQueryProvider =
    NotifierProvider<DictionarySearchQueryNotifier, String>(DictionarySearchQueryNotifier.new);

/// Level đã chọn (beginner, intermediate, advanced)
class SelectedLevelNotifier extends Notifier<String> {
  @override
  String build() => 'beginner';
}

final selectedLevelProvider = NotifierProvider<SelectedLevelNotifier, String>(SelectedLevelNotifier.new);

// ============================================
// VOCABULARY STATES
// ============================================

/// Index từ vựng hiện tại trong flashcard mode
class CurrentVocabularyIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

final currentVocabularyIndexProvider =
    NotifierProvider<CurrentVocabularyIndexNotifier, int>(CurrentVocabularyIndexNotifier.new);

/// Đang ở chế độ flashcard hay không
class IsFlashcardModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final isFlashcardModeProvider = NotifierProvider<IsFlashcardModeNotifier, bool>(IsFlashcardModeNotifier.new);

/// Đang hiển thị mặt nào của flashcard (true = korean, false = vietnamese)
class FlashcardSideNotifier extends Notifier<bool> {
  @override
  bool build() => true;
}

final flashcardSideProvider = NotifierProvider<FlashcardSideNotifier, bool>(FlashcardSideNotifier.new);
