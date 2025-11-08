import 'package:flutter/material.dart';

import '../widgets/classroom_header.dart';
import '../widgets/classroom_tab_bar.dart';

class LessonClassroomPage extends StatelessWidget {
  const LessonClassroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Lớp học'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ClassroomHeader(),
              SizedBox(height: 16),
              ClassroomTabBar(),
            ],
          ),
        ),
      ),
    );
  }
}


