import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/my_roadmap_header.dart';
import '../widgets/my_roadmap_hero_card.dart';
import '../widgets/my_roadmap_overview_card.dart';

class MyRoadmapPage extends ConsumerWidget {
  const MyRoadmapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      body: Stack(
        children: <Widget>[
          const _RoadmapBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  MyRoadmapHeader(),
                  SizedBox(height: 24),
                  MyRoadmapHeroCard(),
                  SizedBox(height: 24),
                  MyRoadmapOverviewCard(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    theme.colorScheme.surface.withValues(alpha: 0.24),
                foregroundColor: theme.colorScheme.onSurface,
              ),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapBackground extends StatelessWidget {
  const _RoadmapBackground();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            const Color(0xFF111827),
            const Color(0xFF0B1220),
            colorScheme.primary.withValues(alpha: 0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 120,
            right: -30,
            child: _BlurredCircle(
              diameter: 140,
              color: colorScheme.primary.withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            bottom: 80,
            left: -20,
            child: _BlurredCircle(
              diameter: 110,
              color: colorScheme.secondary.withValues(alpha: 0.2),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'images/home/1.jpg',
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  const _BlurredCircle({
    required this.diameter,
    required this.color,
  });

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color,
            blurRadius: 80,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}

