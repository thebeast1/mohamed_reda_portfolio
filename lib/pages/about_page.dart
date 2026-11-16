import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/cta_section.dart';
import '../widgets/ds.dart';
import '../widgets/screenshot_strip.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(),
        _Story(),
        _Timeline(),
        _Skills(),
        _Background(),
        CtaSection(),
      ],
    );
  }
}

/// Template "Header / 47".
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.darkest;
    return Section(
      scheme: scheme,
      child: SplitRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flutter developer', style: DsText.tagline(scheme.text)),
            const SizedBox(height: 16),
            Text('Builder of apps people rely on', style: DsText.h1(mobile, scheme.text)),
          ],
        ),
        right: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(CvData.summary, style: DsText.medium(mobile, scheme.text)),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                DsButton.primary(
                  label: 'View projects',
                  scheme: scheme,
                  onTap: () => context.go('/projects'),
                ),
                DsButton(
                  label: 'Get in touch',
                  scheme: scheme,
                  onTap: () => context.go('/contact'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Template "Layout / 149": centred story block over a wide image band.
class _Story extends StatelessWidget {
  const _Story();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    final shots = [for (final app in LiveApps.all) ...app.shots];
    return Section(
      scheme: scheme,
      child: Column(
        children: [
          const SectionTitle(
            scheme: scheme,
            centered: true,
            tagline: 'Story',
            heading: 'How I got here',
            description:
                'I started with Android internships in 2018, taught Android at SCCI, and moved to Flutter in 2020 with a permit-to-work system built from scratch. '
                'Since then I have shipped apps for online learning, telehealth, community safety and, for the past three years, car services in Saudi Arabia.',
          ),
          SizedBox(height: mobile ? 48 : 80),
          ScreenshotStrip(shots, height: mobile ? 360 : 520, scheme: scheme),
        ],
      ),
    );
  }
}

/// Template "Timeline / 8": a vertical line with a card per role.
class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    final items = CvData.experience;

    return Section(
      scheme: scheme,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: DsSpace.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                scheme: scheme,
                tagline: 'Experience',
                heading: 'Where I have worked',
                description:
                    'Five companies in six years, from a full-stack permit system to a car-services app with 100K+ downloads.',
              ),
              SizedBox(height: mobile ? 48 : 80),
              for (var i = 0; i < items.length; i++)
                _TimelineRow(
                  experience: items[i],
                  first: i == 0,
                  last: i == items.length - 1,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.experience,
    required this.first,
    required this.last,
  });

  final Experience experience;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(width: 3, height: first ? 24 : 42, color: scheme.text),
                const SizedBox(height: 8),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(color: scheme.text, shape: BoxShape.circle),
                ),
                const SizedBox(height: 8),
                Expanded(child: Container(width: 3, color: last ? Colors.transparent : scheme.text)),
              ],
            ),
          ),
          SizedBox(width: mobile ? 24 : 48),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: first ? 16 : 24, bottom: last ? 0 : 24),
              child: _ExperienceCard(experience),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard(this.experience);

  final Experience experience;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    final e = widget.experience;
    return DsCard(
      scheme: scheme,
      padding: EdgeInsets.all(mobile ? 24 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.period, style: DsText.h3(mobile, scheme.text)),
          const SizedBox(height: 16),
          Text('${e.role} · ${e.company}', style: DsText.h4(mobile, scheme.text)),
          const SizedBox(height: 8),
          Text('${e.location} · ${e.type}', style: DsText.small(scheme.muted)),
          const SizedBox(height: 32),
          Text(e.summary, style: DsText.medium(mobile, scheme.text)),
          const SizedBox(height: 24),
          DsTags(e.tags, scheme: scheme),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final h in e.highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 11),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(color: scheme.text, shape: BoxShape.circle),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(child: Text(h, style: DsText.regular(mobile, scheme.text))),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DsButton(
                label: _expanded ? 'Hide details' : 'Details',
                scheme: scheme,
                onTap: () => setState(() => _expanded = !_expanded),
              ),
              DsButton.link(
                label: 'Projects',
                scheme: scheme,
                onTap: () => context.go('/projects'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Template "Layout / 357": a grid of cards, one per skill group.
class _Skills extends StatelessWidget {
  const _Skills();

  static const _icons = <IconData>[
    Icons.flutter_dash,
    Icons.account_tree_outlined,
    Icons.storage_outlined,
    Icons.payments_outlined,
    Icons.map_outlined,
    Icons.integration_instructions_outlined,
    Icons.rocket_launch_outlined,
    Icons.insights_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.light;
    final groups = CvData.skills;
    return Section(
      scheme: scheme,
      child: Column(
        children: [
          const SectionTitle(
            scheme: scheme,
            centered: true,
            tagline: 'Stack',
            heading: 'Tools I work with every day',
            description:
                'The frameworks, services and release tooling behind the apps on this site.',
          ),
          SizedBox(height: mobile ? 48 : 80),
          DsGrid(
            columns: 4,
            tabletColumns: 2,
            children: [
              for (var i = 0; i < groups.length; i++)
                DsCard(
                  scheme: scheme,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(_icons[i % _icons.length], size: 48, color: scheme.text),
                      const SizedBox(height: 16),
                      Text(groups[i].title, style: DsText.h5(mobile, scheme.text)),
                      const SizedBox(height: 16),
                      DsTags(groups[i].items, scheme: scheme),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Template "Layout / 348": label on the left, detail on the right, per row.
class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    final edu = CvData.education;

    Widget row(String label, Widget body) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: SplitRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            leftFlex: 1,
            rightFlex: 2,
            mobileGap: 16,
            left: Text(label, style: DsText.h4(mobile, scheme.text)),
            right: body,
          ),
        );

    Widget entry(String title, String sub, String period) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: DsText.regularSemi(mobile, scheme.text)),
              Text(sub, style: DsText.regular(mobile, scheme.text)),
              Text(period, style: DsText.small(scheme.muted)),
            ],
          ),
        );

    const divider = Divider(height: 1, thickness: 1, color: DsColors.darkest15);

    return Section(
      scheme: scheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            scheme: scheme,
            tagline: 'Background',
            heading: 'Education and early roles',
          ),
          SizedBox(height: mobile ? 32 : 48),
          divider,
          row('Education', entry(edu.degree, edu.school, edu.period)),
          divider,
          row(
            'Early roles',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (final r in CvData.earlyRoles) entry(r.title, r.org, r.period)],
            ),
          ),
          divider,
          row(
            'Languages',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final l in CvData.languages)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(l, style: DsText.regular(mobile, scheme.text)),
                  ),
              ],
            ),
          ),
          divider,
        ],
      ),
    );
  }
}
