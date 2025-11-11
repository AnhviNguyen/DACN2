import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/widgets/bottom_action_bar.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/widgets/question_card.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/widgets/question_overview_bottom_sheet.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/providers/test_form_providers.dart';

class TestFormPage extends ConsumerStatefulWidget {
  const TestFormPage({super.key});

  @override
  ConsumerState<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends ConsumerState<TestFormPage> {
  static const int _batchSize = 3;

  late final PageController _pageController;

  int get _totalPages {
    final questions = ref.read(testQuestionsProvider);
    return (questions.length / _batchSize).ceil();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Khởi động timer qua provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(testTimerProvider.notifier).start();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  void _onSelectAnswer(int questionId, String value) {
    ref.read(selectedAnswersProvider.notifier).setAnswer(questionId, value);
  }

  void _goToPreviousPage() {
    final currentPage = ref.read(currentPageProvider);
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      // Provider sẽ được cập nhật tự động trong onPageChanged
    }
  }

  void _goToNextPage() {
    final totalPages = _totalPages;
    final currentPage = ref.read(currentPageProvider);
    if (currentPage < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      // Provider sẽ được cập nhật tự động trong onPageChanged
    }
  }

  void _openOverview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final questions = ref.read(testQuestionsProvider);
        final answered = ref.read(selectedAnswersProvider).keys.toSet();
        return QuestionOverviewBottomSheet(
          totalQuestions: questions.length,
          firstQuestionId: questions.first.id,
          answeredQuestionIds: answered,
          onJumpToQuestion: (int index) {
            // index là 0-based theo toàn bộ câu hỏi
            final targetPage = index ~/ _batchSize;
            Navigator.of(context).pop();
            ref.read(currentPageProvider.notifier).goToPage(targetPage);
            _pageController.animateToPage(
              targetPage,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          },
          onSubmit: () {
            // TODO: Submit logic
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeLeft = ref.watch(testTimerProvider);
    final questions = ref.watch(testQuestionsProvider);
    final selectedAnswers = ref.watch(selectedAnswersProvider);
    return Scaffold(
      backgroundColor: const Color(0x00fffffc),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: double.infinity,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Thời gian làm bài:',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time_filled, size: 18, color: Colors.red),
                            const SizedBox(width: 6),
                            Text(
                              _formatTime(timeLeft),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.red.shade600,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    ref.read(currentPageProvider.notifier).goToPage(index);
                  },
                  itemCount: _totalPages,
                  itemBuilder: (context, pageIndex) {
                    final start = pageIndex * _batchSize;
                    final end = (questions.length < start + _batchSize)
                        ? questions.length
                        : start + _batchSize;
                    final batch = questions.sublist(start, end);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final q in batch) ...[
                            QuestionCard(
                              questionId: q.id,
                              questionText: q.text,
                              options: q.options,
                              selectedValue: selectedAnswers[q.id],
                              onChanged: (val) =>
                                  _onSelectAnswer(q.id, val),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        onBack: _goToPreviousPage,
        onOverviewSubmit: _openOverview,
        onNext: _goToNextPage,
        totalPages: _totalPages,
      ),
    );
  }
}