import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface.withValues(alpha: 0.35),
      child: SectionShell(
        eyebrow: 'Skills',
        title: 'Tools I use to ship',
        child: ResponsiveGrid(
          minItemWidth: 320,
          maxColumns: 2,
          children: [for (final g in CvData.skills) _SkillCard(g)],
        ),
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard(this.group);

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.title, style: AppText.h3.copyWith(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in group.items)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    s,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
