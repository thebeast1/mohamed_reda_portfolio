import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import 'ds.dart';

/// Template "Portfolio / 13" card: cover image, title, description, tags, link.
class ProjectCard extends StatelessWidget {
  const ProjectCard(this.project, {super.key, this.scheme = Scheme.white});

  final Project project;
  final Scheme scheme;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final cover = project.coverUrl;
    return DsCard(
      scheme: scheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 405.33 / 228,
            child: cover != null
                ? NetImage(cover, alignment: const Alignment(0, -0.6))
                : Container(
                    color: DsColors.dark,
                    alignment: Alignment.center,
                    child: Icon(project.icon, color: DsColors.white, size: 56),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.category, style: DsText.tagline(scheme.muted)),
                const SizedBox(height: 8),
                Text(project.name, style: DsText.h5(mobile, scheme.text)),
                const SizedBox(height: 8),
                Text(project.description, style: DsText.regular(mobile, scheme.text)),
                if (project.metric != null) ...[
                  const SizedBox(height: 8),
                  Text(project.metric!, style: DsText.regularSemi(mobile, scheme.text)),
                ],
                const SizedBox(height: 16),
                DsTags(project.tags, scheme: scheme),
                const SizedBox(height: 24),
                if (project.liveUrl != null)
                  DsButton.link(
                    label: 'View live',
                    scheme: scheme,
                    onTap: () => openLink(project.liveUrl!),
                  )
                else
                  DsButton.link(
                    label: 'More projects',
                    scheme: scheme,
                    onTap: () => context.go('/projects'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
