import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'About',
      title: 'Six years of shipping Flutter to real users',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: const Text(CvData.summary, style: AppText.bodyLarge),
          ),
          const SizedBox(height: 40),
          ResponsiveGrid(
            minItemWidth: 220,
            children: [for (final s in CvData.stats) _StatTile(s)],
          ),
          const SizedBox(height: 20),
          ResponsiveGrid(
            minItemWidth: 300,
            maxColumns: 3,
            children: [for (final f in CvData.focusAreas) _FocusCard(f)],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile(this.stat);

  final Stat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent.withValues(alpha: 0.10),
            AppColors.surface,
          ],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 6),
          Text(stat.label, style: AppText.small),
        ],
      ),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard(this.area);

  final FocusArea area;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(area.icon, color: AppColors.accent, size: 28),
          const SizedBox(height: 16),
          Text(area.title, style: AppText.h3),
          const SizedBox(height: 8),
          Text(area.description, style: AppText.small),
        ],
      ),
    );
  }
}
