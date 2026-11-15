import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onContact, required this.onWork});

  final VoidCallback onContact;
  final VoidCallback onWork;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.85, -0.7),
          radius: 1.3,
          colors: [
            AppColors.accent.withValues(alpha: 0.16),
            AppColors.bg.withValues(alpha: 0),
          ],
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        mobile ? 20 : 40,
        mobile ? 56 : 120,
        mobile ? 20 : 40,
        mobile ? 64 : 110,
      ),
      child: MaxWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FadeIn(child: _AvailabilityPill()),
            const SizedBox(height: 28),
            FadeIn(
              delayMs: 100,
              child: Text(
                "Hi, I'm ${CvData.name}",
                style: AppText.h3.copyWith(color: AppColors.accent),
              ),
            ),
            const SizedBox(height: 14),
            FadeIn(
              delayMs: 200,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Text(
                  '${CvData.title}.\nI build apps people use every day.',
                  style: mobile ? AppText.displayMobile : AppText.display,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeIn(
              delayMs: 300,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(
                  CvData.tagline,
                  style: mobile ? AppText.body.copyWith(fontSize: 17) : AppText.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const FadeIn(
              delayMs: 350,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined, size: 18, color: AppColors.muted),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      '${CvData.location} · Remote since 2020',
                      style: AppText.small,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            FadeIn(
              delayMs: 400,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: onContact,
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: const Text('Get in touch'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onWork,
                    icon: const Icon(Icons.work_outline_rounded, size: 18),
                    label: const Text('View experience'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => openLink(CvData.linkedIn),
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: const Text('LinkedIn'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Available for new opportunities',
            style: TextStyle(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}
