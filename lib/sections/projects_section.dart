import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Projects',
      title: 'Selected work',
      child: ResponsiveGrid(
        minItemWidth: 320,
        maxColumns: 3,
        children: [for (final p in CvData.projects) _ProjectCard(p)],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: SizedBox(
        height: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(project.icon, color: AppColors.accent),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    project.category.toUpperCase(),
                    style: AppText.eyebrow.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.4,
                      color: AppColors.muted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(project.name, style: AppText.h3),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                project.description,
                style: AppText.small,
                overflow: TextOverflow.fade,
              ),
            ),
            if (project.metric != null) ...[
              Text(
                project.metric!,
                style: AppText.small.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
            ],
            TagWrap(project.tags),
          ],
        ),
      ),
    );
  }
}
