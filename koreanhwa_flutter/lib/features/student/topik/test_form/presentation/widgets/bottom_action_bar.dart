import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koreanhwa_flutter/features/student/topik/test_form/presentation/providers/test_form_providers.dart';

class BottomActionBar extends ConsumerWidget {
  final VoidCallback onBack;
  final VoidCallback onOverviewSubmit;
  final VoidCallback onNext;
  final int totalPages;

  const BottomActionBar({
    super.key,
    required this.onBack,
    required this.onOverviewSubmit,
    required this.onNext,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final canGoBack = currentPage > 0;
    final canGoNext = currentPage < totalPages - 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Back Button
          _roundedRectangleButton(
            icon: Icons.arrow_back_sharp,
            enabled: canGoBack,
            onPressed: onBack,
          ),
          // Overview & Submit Button
          ElevatedButton.icon(
            onPressed: onOverviewSubmit,
            icon: const Icon(Icons.grid_view_outlined, size: 20),
            label: const Text(
              'Tổng quan & Nộp bài',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: const Color(0xFF5A7FFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
          _roundedRectangleButton(
            icon: Icons.arrow_forward_sharp,
            enabled: canGoNext,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }

  Widget _roundedRectangleButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool enabled,
  }) {
    return IconButton(
      onPressed: enabled ? onPressed : null,
      icon: Icon(
        icon,
        size: 21,
        color: enabled ? const Color(0xFF5A7FFF) : Colors.grey.shade400,
      ),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
    );
  }
}
