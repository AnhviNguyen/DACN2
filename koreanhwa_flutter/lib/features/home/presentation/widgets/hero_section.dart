import 'package:flutter/material.dart';

import 'home_colors.dart';

class HomeHeroSection extends StatefulWidget {
  const HomeHeroSection({super.key});

  @override
  State<HomeHeroSection> createState() => _HomeHeroSectionState();
}

class _HomeHeroSectionState extends State<HomeHeroSection> {
  static const List<DropdownMenuItem<String>> _languageItems = [
    DropdownMenuItem(value: 'en', child: Text('English')),
    DropdownMenuItem(value: 'vn', child: Text('Tiếng Việt')),
    DropdownMenuItem(value: 'es', child: Text('Español')),
  ];

  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: homeHeroBackground,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Học một ngoại ngữ để sử dụng trong đời thực',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Những mẫu câu hữu ích trong cuộc sống hàng ngày. Được dạy với những clip của người bản ngữ.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black.withOpacity(0.72),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 4,
              width: 80,
              decoration: BoxDecoration(
                color: homeBrandYellow,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              items: _languageItems,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: homeBrandYellow, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: homeBrandYellow, width: 2),
                ),
                hintText: 'Chọn ngôn ngữ của bạn',
              ),
              dropdownColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _selectedLanguage == null
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Bạn đã chọn ngôn ngữ: ${_selectedLanguage!.toUpperCase()}',
                          ),
                        ),
                      );
                    },
              style: FilledButton.styleFrom(
                backgroundColor: homeBrandYellow,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: const StadiumBorder(),
                textStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Bắt đầu'),
            ),
            const SizedBox(height: 28),
            Center(
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 22,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'images/home/1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

