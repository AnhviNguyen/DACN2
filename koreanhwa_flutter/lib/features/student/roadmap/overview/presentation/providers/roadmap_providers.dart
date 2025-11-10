import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoadmapLevel {
  const RoadmapLevel({
    required this.id,
    required this.name,
    required this.color,
    required this.duration,
    required this.questionCount,
  });

  final String id;
  final String name;
  final Color color;
  final String duration;
  final String questionCount;
}

final roadmapLevelsProvider = Provider<List<RoadmapLevel>>((ref) {
  return const <RoadmapLevel>[
    RoadmapLevel(
      id: 'level1',
      name: 'Cấp độ 1',
      color: Color(0xFF34D399),
      duration: '8 phút',
      questionCount: '8 câu',
    ),
    RoadmapLevel(
      id: 'level2',
      name: 'Cấp độ 2',
      color: Color(0xFFFACC15),
      duration: '10 phút',
      questionCount: '10 câu',
    ),
    RoadmapLevel(
      id: 'level3',
      name: 'Cấp độ 3',
      color: Color(0xFFF97316),
      duration: '12 phút',
      questionCount: '12 câu',
    ),
    RoadmapLevel(
      id: 'level4',
      name: 'Cấp độ 4',
      color: Color(0xFFEF4444),
      duration: '15 phút',
      questionCount: '15 câu',
    ),
  ];
});

class SelectedRoadmapLevelNotifier extends Notifier<String> {
  @override
  String build() => 'level1';

  void selectLevel(String levelId) {
    state = levelId;
  }
}

final selectedRoadmapLevelProvider =
    NotifierProvider<SelectedRoadmapLevelNotifier, String>(
  SelectedRoadmapLevelNotifier.new,
);

