import 'package:flutter/material.dart';

import '../widgets/lesson_info_buy_card.dart';
import '../widgets/lesson_info_header.dart';
import '../widgets/lesson_info_stats.dart';
import '../widgets/lesson_info_tab_section.dart';

class LessonInfoPage extends StatelessWidget {
  const LessonInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Chi tiết khóa học'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              LessonInfoHeader(),
              SizedBox(height: 16),
              LessonInfoBuyCard(),
              SizedBox(height: 16),
              LessonInfoTabSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}


