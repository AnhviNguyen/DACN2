import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/widgets/question_card.dart';

class TestQuestion {
  final int id;
  final String text;
  final List<QuestionOption> options;
  const TestQuestion({
    required this.id,
    required this.text,
    required this.options,
  });
}

final testQuestionsProvider = Provider<List<TestQuestion>>((ref) {
  // TODO: Thay bằng API sau
  return const [
    TestQuestion(
      id: 101,
      text:
          "한국어에서 '안녕하세요'의 의미는 무엇입니까? 다음 중 올바른 답을 선택하세요.",
      options: [
        QuestionOption(value: 'A', text: '좋은 아침입니다'),
        QuestionOption(value: 'B', text: '안녕히 가세요'),
        QuestionOption(value: 'C', text: '반갑습니다'),
        QuestionOption(value: 'D', text: '감사합니다'),
      ],
    ),
    TestQuestion(
      id: 102,
      text:
          "다음 문장에서 빈칸에 들어갈 가장 적절한 단어를 고르세요: '저는 한국 음식을 _____ 좋아해요.'",
      options: [
        QuestionOption(value: 'A', text: '매우'),
        QuestionOption(value: 'B', text: '조금'),
        QuestionOption(value: 'C', text: '전혀'),
        QuestionOption(value: 'D', text: '가끔'),
      ],
    ),
    TestQuestion(
      id: 103,
      text: "한국의 전통 의상인 '한복'에 대한 설명으로 올바른 것은 무엇입니까?",
      options: [
        QuestionOption(value: 'A', text: '일상복으로만 사용됩니다'),
        QuestionOption(value: 'B', text: '특별한 날에 입는 전통 의상입니다'),
        QuestionOption(value: 'C', text: '현대적인 디자인만 있습니다'),
        QuestionOption(value: 'D', text: '외국에서 만들어집니다'),
      ],
    ),
    TestQuestion(
      id: 104,
      text: "다음 중 한국의 수도는 어디입니까?",
      options: [
        QuestionOption(value: 'A', text: '부산'),
        QuestionOption(value: 'B', text: '인천'),
        QuestionOption(value: 'C', text: '서울'),
        QuestionOption(value: 'D', text: '대구'),
      ],
    ),
    TestQuestion(
      id: 105,
      text: "다음 문장의 뜻과 가장 가까운 것을 고르세요: '천천히 가요.'",
      options: [
        QuestionOption(value: 'A', text: '빨리 가요'),
        QuestionOption(value: 'B', text: '조심히 가요'),
        QuestionOption(value: 'C', text: '잠깐 쉬어요'),
        QuestionOption(value: 'D', text: '서둘러요'),
      ],
    ),
  ];
});

class SelectedAnswersNotifier extends Notifier<Map<int, String>> {
  @override
  Map<int, String> build() => {};

  void setAnswer(int questionId, String value) {
    state = {
      ...state,
      questionId: value,
    };
  }

  void clearAll() {
    state = {};
  }
}

final selectedAnswersProvider =
    NotifierProvider<SelectedAnswersNotifier, Map<int, String>>(
        SelectedAnswersNotifier.new);

class TestTimerNotifier extends Notifier<int> {
  Timer? _timer;
  static const int defaultSeconds = 14 * 60;

  @override
  int build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return defaultSeconds;
  }

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final current = state;
      if (current > 0) {
        state = current - 1;
      } else {
        t.cancel();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void reset({int seconds = defaultSeconds}) {
    _timer?.cancel();
    state = seconds;
  }
}

final testTimerProvider =
    NotifierProvider<TestTimerNotifier, int>(TestTimerNotifier.new);

class CurrentPageNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void goToPage(int page) {
    state = page;
  }

  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      state = state + 1;
    }
  }

  void previousPage() {
    if (state > 0) {
      state = state - 1;
    }
  }
}

final currentPageProvider =
    NotifierProvider<CurrentPageNotifier, int>(CurrentPageNotifier.new);

