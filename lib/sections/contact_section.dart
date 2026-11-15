import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/nav_bar.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 20 : 40,
        vertical: mobile ? 56 : 88,
      ),
      child: MaxWidth(
        child: Container(
          padding: EdgeInsets.all(mobile ? 28 : 56),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accentDeep.withValues(alpha: 0.35),
                AppColors.surface,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CONTACT', style: AppText.eyebrow),
              const SizedBox(height: 12),
              Text(
                "Let's build your next app.",
                style: mobile ? AppText.h2Mobile : AppText.h2,
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: const Text(
                  'I am open to remote roles and on-site opportunities. '
                  'The fastest way to reach me is email or LinkedIn.',
                  style: AppText.bodyLarge,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () => openLink('mailto:${CvData.email}'),
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: const Text(CvData.email),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => openLink(CvData.linkedIn),
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: const Text(CvData.linkedInLabel),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined, size: 18, color: AppColors.muted),
                  SizedBox(width: 6),
                  Text(CvData.location, style: AppText.small),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);
    final year = DateTime.now().year;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 40, vertical: 28),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: MaxWidth(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LogoBadge(size: 28),
                const SizedBox(width: 10),
                Text('© $year ${CvData.name}', style: AppText.small),
              ],
            ),
            const Text('Built with Flutter Web', style: AppText.small),
          ],
        ),
      ),
    );
  }
}
