import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import 'ds.dart';

/// Template "CTA / 57": centred H1, description and two buttons on the darkest scheme.
class CtaSection extends StatelessWidget {
  const CtaSection({
    super.key,
    this.heading = 'Ready to build\nyour next app?',
    this.description =
        "Let's talk about the role or the product you have in mind, and how six years of shipping Flutter apps can help.",
  });

  final String heading;
  final String description;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.darkest;
    return Section(
      scheme: scheme,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: DsSpace.maxWidth),
          child: Column(
            children: [
              Text(
                heading,
                textAlign: TextAlign.center,
                style: DsText.h1(mobile, scheme.text),
              ),
              const SizedBox(height: 24),
              Text(
                description,
                textAlign: TextAlign.center,
                style: DsText.medium(mobile, scheme.text),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  DsButton.primary(
                    label: 'Get in touch',
                    scheme: scheme,
                    onTap: () => context.go('/contact'),
                  ),
                  DsButton(
                    label: 'LinkedIn',
                    scheme: scheme,
                    onTap: () => openLink(CvData.linkedIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
