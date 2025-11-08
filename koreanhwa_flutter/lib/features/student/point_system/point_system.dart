import 'package:collection/collection.dart';

/// Domain models and logic for the student point system translated from
/// `pointSystem.js` in the original React codebase.

/// Represents the learner level buckets.
enum StudentLevelType { beginner, intermediate, advanced }

/// Supported content types in the pricing table.
enum ContentType { video, vocabulary, grammar, exercise }

/// Immutable value describing a quiz configuration for a specific level.
class QuizConfig {
  const QuizConfig({
    required this.type,
    required this.questions,
    required this.maxPoints,
  });

  final String type;
  final int questions;
  final int maxPoints;
}

/// Pricing descriptor for a single piece of content.
class ContentAccessItem {
  const ContentAccessItem({
    required this.cost,
    required this.description,
    this.durationMinutes,
  });

  final int cost;
  final String description;
  final int? durationMinutes;
}

/// Points required to access content depending on mode (base vs premium).
class ContentPricing {
  const ContentPricing({required this.base, required this.max});

  final int base;
  final int max;
}

/// Describes a student level including metadata and available content.
class StudentLevel {
  const StudentLevel({
    required this.type,
    required this.name,
    required this.minPoints,
    required this.maxPoints,
    required this.description,
    required this.quizConfig,
    required this.contentAccess,
    required this.learningGoals,
  });

  final StudentLevelType type;
  final String name;
  final int minPoints;
  final int? maxPoints;
  final String description;
  final QuizConfig quizConfig;
  final Map<String, ContentAccessItem> contentAccess;
  final List<String> learningGoals;

  bool get isTerminalLevel => maxPoints == null;
}

/// Reward configuration mapping the same semantics as the JS source.
class RewardSystem {
  const RewardSystem({
    required this.dailyLogin,
    required this.completeLesson,
    required this.passQuiz,
    required this.streakBonus,
    required this.achievementBonus,
  });

  final int dailyLogin;
  final int completeLesson;
  final int passQuiz;
  final Map<int, int> streakBonus;
  final Map<String, int> achievementBonus;
}

/// Result snapshot for point progress toward the next level.
class LevelProgressSnapshot {
  const LevelProgressSnapshot({
    required this.progressPercent,
    required this.currentPointsWithinLevel,
    required this.targetPointsWithinLevel,
    this.isMaxLevel = false,
  });

  final double progressPercent;
  final int currentPointsWithinLevel;
  final int? targetPointsWithinLevel;
  final bool isMaxLevel;
}

/// Central registry mirroring the React point system configuration.
class PointSystem {
  PointSystem._();

  /// Static reference of levels keyed by type for quick lookup.
  static const Map<StudentLevelType, StudentLevel> studentLevels = {
    StudentLevelType.beginner: StudentLevel(
      type: StudentLevelType.beginner,
      name: 'Sơ cấp',
      minPoints: 0,
      maxPoints: 300,
      description: 'Người mới bắt đầu (0-300 điểm)',
      quizConfig: QuizConfig(type: 'TOPIK I', questions: 20, maxPoints: 100),
      contentAccess: {
        'basicExplanation': ContentAccessItem(
          cost: 5,
          description: 'Giải thích câu hỏi cơ bản',
        ),
        'hangeulMaterials': ContentAccessItem(
          cost: 10,
          description: 'Tài liệu Hangeul',
        ),
        'pronunciationVideos': ContentAccessItem(
          cost: 15,
          description: 'Video phát âm',
        ),
      },
      learningGoals: [
        'Học bảng chữ cái Hangeul',
        'Từ vựng cơ bản (500 từ)',
        'Giao tiếp đơn giản',
        'Tích lũy điểm để mở khóa nội dung',
      ],
    ),
    StudentLevelType.intermediate: StudentLevel(
      type: StudentLevelType.intermediate,
      name: 'Trung cấp',
      minPoints: 301,
      maxPoints: 800,
      description: 'Đã có nền tảng (301-800 điểm)',
      quizConfig:
          QuizConfig(type: 'TOPIK I & II', questions: 50, maxPoints: 300),
      contentAccess: {
        'grammarExplanation': ContentAccessItem(
          cost: 8,
          description: 'Giải thích ngữ pháp',
        ),
        'specializedVocabulary': ContentAccessItem(
          cost: 20,
          description: 'Tài liệu từ vựng chuyên ngành',
        ),
        'conversationVideos': ContentAccessItem(
          cost: 25,
          description: 'Video hội thoại',
        ),
        'aiChat': ContentAccessItem(
          cost: 30,
          durationMinutes: 10,
          description: 'Chat với AI (10 phút)',
        ),
      },
      learningGoals: [
        'Thành thạo 1500 từ vựng',
        'Ngữ pháp cơ bản-trung cấp',
        'Luyện nghe nói qua AI',
        'Chuẩn bị thi TOPIK I',
      ],
    ),
    StudentLevelType.advanced: StudentLevel(
      type: StudentLevelType.advanced,
      name: 'Cao cấp',
      minPoints: 801,
      maxPoints: null,
      description: 'Trình độ khá (801+ điểm)',
      quizConfig: QuizConfig(type: 'TOPIK II', questions: 50, maxPoints: 300),
      contentAccess: {
        'grammarExplanation': ContentAccessItem(
          cost: 12,
          description: 'Giải thích ngữ pháp',
        ),
        'specializedVocabulary': ContentAccessItem(
          cost: 35,
          description: 'Tài liệu từ vựng chuyên ngành',
        ),
        'conversationVideos': ContentAccessItem(
          cost: 40,
          description: 'Video hội thoại',
        ),
        'aiChat': ContentAccessItem(
          cost: 50,
          durationMinutes: 10,
          description: 'Chat với AI (10 phút)',
        ),
      },
      learningGoals: [
        'Thành thạo 3000+ từ vựng',
        'Ngữ pháp nâng cao',
        'Đạt TOPIK II cấp 4-6',
        'Giao tiếp lưu loát',
      ],
    ),
  };

  /// Static content pricing configuration (base vs premium).
  static const Map<ContentType, Map<StudentLevelType, ContentPricing>>
      contentPricing = {
    ContentType.video: {
      StudentLevelType.beginner: ContentPricing(base: 15, max: 20),
      StudentLevelType.intermediate: ContentPricing(base: 20, max: 30),
      StudentLevelType.advanced: ContentPricing(base: 25, max: 40),
    },
    ContentType.vocabulary: {
      StudentLevelType.beginner: ContentPricing(base: 10, max: 15),
      StudentLevelType.intermediate: ContentPricing(base: 15, max: 25),
      StudentLevelType.advanced: ContentPricing(base: 20, max: 35),
    },
    ContentType.grammar: {
      StudentLevelType.beginner: ContentPricing(base: 12, max: 18),
      StudentLevelType.intermediate: ContentPricing(base: 18, max: 28),
      StudentLevelType.advanced: ContentPricing(base: 25, max: 40),
    },
    ContentType.exercise: {
      StudentLevelType.beginner: ContentPricing(base: 8, max: 12),
      StudentLevelType.intermediate: ContentPricing(base: 12, max: 20),
      StudentLevelType.advanced: ContentPricing(base: 18, max: 30),
    },
  };

  static const RewardSystem rewardSystem = RewardSystem(
    dailyLogin: 5,
    completeLesson: 10,
    passQuiz: 20,
    streakBonus: {
      3: 5,
      7: 15,
      14: 30,
      30: 50,
    },
    achievementBonus: {
      'firstQuiz': 50,
      'firstLesson': 25,
      'weekStreak': 100,
      'monthStreak': 500,
    },
  );

  /// Determines the level based on total accumulated points.
  static StudentLevel getStudentLevel(int points) {
    return studentLevels.values
            .firstWhereOrNull((level) =>
                points >= level.minPoints &&
                (level.maxPoints == null || points <= level.maxPoints!)) ??
        studentLevels[StudentLevelType.beginner]!;
  }

  /// Checks if the user has sufficient points to access an item.
  static bool canAccessContent({
    required int userPoints,
    required int contentCost,
  }) {
    return userPoints >= contentCost;
  }

  /// Returns the points required to reach the next level, or `null` if max.
  static int? getNextLevelThreshold(int currentPoints) {
    final level = getStudentLevel(currentPoints);
    switch (level.type) {
      case StudentLevelType.beginner:
        return studentLevels[StudentLevelType.intermediate]!.minPoints;
      case StudentLevelType.intermediate:
        return studentLevels[StudentLevelType.advanced]!.minPoints;
      case StudentLevelType.advanced:
        return null;
    }
  }

  /// Calculates the progress toward the next level as a snapshot.
  static LevelProgressSnapshot getProgressToNextLevel(int currentPoints) {
    final level = getStudentLevel(currentPoints);

    if (level.isTerminalLevel) {
      return LevelProgressSnapshot(
        progressPercent: 100,
        currentPointsWithinLevel: currentPoints - level.minPoints,
        targetPointsWithinLevel: null,
        isMaxLevel: true,
      );
    }

    final nextLevelThreshold = getNextLevelThreshold(currentPoints)!;
    final rangeSpan = nextLevelThreshold - level.minPoints;
    final currentWithinLevel = currentPoints - level.minPoints;
    final progressPercent =
        rangeSpan == 0 ? 100 : (currentWithinLevel / rangeSpan) * 100;

    return LevelProgressSnapshot(
      progressPercent: progressPercent.clamp(0, 100).toDouble(),
      currentPointsWithinLevel: currentWithinLevel,
      targetPointsWithinLevel: rangeSpan,
    );
  }

  /// Calculates the content price based on type, user level, and premium flag.
  static int calculateContentPrice({
    required ContentType contentType,
    required StudentLevelType levelType,
    bool isPremium = false,
  }) {
    final pricing = contentPricing[contentType]?[levelType];
    if (pricing == null) {
      return 0;
    }

    return isPremium ? pricing.max : pricing.base;
  }
}

