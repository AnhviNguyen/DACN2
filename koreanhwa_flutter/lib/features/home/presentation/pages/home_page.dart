import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/features_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/header_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/home_colors.dart';
import '../widgets/stats_section.dart';
import '../widgets/testimonials_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeDarkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeaderBar(
                onLoginTap: () => context.go('/login'),
                onSignUpTap: () => context.go('/register'),
              ),
              const SizedBox(height: 24),
              const HomeHeroSection(),
              const SizedBox(height: 24),
              const HomeStatsSection(),
              const SizedBox(height: 24),
              const HomeFeaturesSection(),
              const SizedBox(height: 24),
              const HomeTestimonialsSection(),
              const SizedBox(height: 32),
              const HomeFooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

