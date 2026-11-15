import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    const edu = CvData.education;
    return SectionShell(
      eyebrow: 'Education',
      title: 'Background',
      child: ResponsiveGrid(
        minItemWidth: 320,
        maxColumns: 3,
        children: [
          _InfoCard(
            icon: Icons.school_outlined,
            title: 'Degree',
            children: [
              Text(edu.degree, style: AppText.h3.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Text(edu.school, style: AppText.small),
              const SizedBox(height: 6),
              Text(edu.period, style: AppText.small.copyWith(color: AppColors.accent)),
            ],
          ),
          _InfoCard(
            icon: Icons.history_edu_outlined,
            title: 'Teaching & internships',
            children: [
              for (final r in CvData.earlyRoles)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.title,
                        style: AppText.body.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                      Text('${r.org} · ${r.period}', style: AppText.small),
                    ],
                  ),
                ),
            ],
          ),
          _InfoCard(
            icon: Icons.translate_rounded,
            title: 'Languages',
            children: [
              for (final l in CvData.languages)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(l, style: AppText.body.copyWith(color: AppColors.text)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.children});

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent, size: 22),
                const SizedBox(width: 10),
                Text(title.toUpperCase(), style: AppText.eyebrow.copyWith(fontSize: 11.5)),
              ],
            ),
            const SizedBox(height: 18),
            ...children,
          ],
        ),
      ),
    );
  }
}
