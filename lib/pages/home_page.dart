import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/cta_section.dart';
import '../widgets/ds.dart';
import '../widgets/hero_images.dart';
import '../widgets/project_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Hero(),
        _Stats(),
        _FeaturedWork(),
        _Expertise(),
        _Highlight(),
        CtaSection(),
      ],
    );
  }
}

/// Template "Header / 126".
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.darkest;
    final mismar = LiveApps.all[0];
    final infinity = LiveApps.all[2];

    return Section(
      scheme: scheme,
      child: SplitRow(
        gap: 64,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Senior Flutter developer building apps people use every day',
              style: DsText.h1(mobile, scheme.text),
            ),
            const SizedBox(height: 24),
            Text(CvData.tagline, style: DsText.medium(mobile, scheme.text)),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                DsButton.primary(
                  label: 'Projects',
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
        right: HeroImages(
          large: mismar.shots[0].full,
          small: infinity.shots[0].full,
        ),
      ),
    );
  }
}

/// Template "Stats / 13".
class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.dark;

    Widget stat(Stat s) => Container(
          padding: const EdgeInsets.only(left: 32),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: DsColors.white20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.value, style: DsText.stat(mobile, scheme.text)),
              const SizedBox(height: 8),
              Text(s.label, style: DsText.h6(mobile, scheme.text)),
            ],
          ),
        );

    final stats = CvData.stats;
    final grid = mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                stat(stats[i]),
                if (i < stats.length - 1) const SizedBox(height: 32),
              ],
            ],
          )
        : Column(
            children: [
              for (var r = 0; r < stats.length; r += 2) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: stat(stats[r])),
                    const SizedBox(width: 32),
                    Expanded(
                      child: r + 1 < stats.length ? stat(stats[r + 1]) : const SizedBox(),
                    ),
                  ],
                ),
                if (r + 2 < stats.length) const SizedBox(height: 48),
              ],
            ],
          );

    return Section(
      scheme: scheme,
      child: SplitRow(
        leftFlex: 616,
        rightFlex: 584,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              scheme: scheme,
              tagline: 'Proven',
              heading: 'Six years of shipping, in real numbers',
              description:
                  'Production apps for automotive services, healthcare, edtech, transport and safety, on Android, iOS and the web.',
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DsButton(
                  label: 'About',
                  scheme: scheme,
                  onTap: () => context.go('/about'),
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
        right: grid,
      ),
    );
  }
}

/// Template "Portfolio / 13".
class _FeaturedWork extends StatelessWidget {
  const _FeaturedWork();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    return Section(
      scheme: scheme,
      child: Column(
        children: [
          const SectionTitle(
            scheme: scheme,
            centered: true,
            tagline: 'Featured',
            heading: 'Work that speaks',
            description:
                'Each project is a production app with real users, real payments and real release pressure.',
          ),
          SizedBox(height: mobile ? 48 : 80),
          DsGrid(
            columns: 3,
            children: [
              for (final p in CvData.projects.take(3)) ProjectCard(p),
            ],
          ),
          SizedBox(height: mobile ? 48 : 64),
          DsButton(
            label: 'All projects',
            scheme: scheme,
            onTap: () => context.go('/projects'),
          ),
        ],
      ),
    );
  }
}

/// Template "Layout / 371": one wide card with an image plus two icon cards.
class _Expertise extends StatelessWidget {
  const _Expertise();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final stacked = isTablet(context);
    const scheme = Scheme.white;
    final areas = CvData.focusAreas;
    final mismar = LiveApps.all[0];

    Widget content(FocusArea a, {Widget? leading}) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading, const SizedBox(height: 16)],
              Text(a.title, style: DsText.h5(mobile, scheme.text)),
              const SizedBox(height: 8),
              Text(a.description, style: DsText.regular(mobile, scheme.text)),
              const SizedBox(height: 24),
              DsButton.link(
                label: 'See projects',
                scheme: scheme,
                onTap: () => context.go('/projects'),
              ),
            ],
          ),
        );

    final wide = DsCard(
      scheme: scheme,
      child: stacked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                content(areas[0], leading: Text('Mismar', style: DsText.tagline(scheme.text))),
                SizedBox(
                  height: 260,
                  child: NetImage(mismar.shots[1].thumb, alignment: const Alignment(0, -0.7)),
                ),
              ],
            )
          : SizedBox(
              height: 360,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: content(areas[0], leading: Text('Mismar', style: DsText.tagline(scheme.text))),
                  ),
                  Expanded(
                    child: NetImage(mismar.shots[1].thumb, alignment: const Alignment(0, -0.7)),
                  ),
                ],
              ),
            ),
    );

    Widget small(FocusArea a) => DsCard(
          scheme: scheme,
          child: content(a, leading: Icon(a.icon, size: 48, color: scheme.text)),
        );

    final cards = stacked
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              wide,
              const SizedBox(height: 32),
              small(areas[1]),
              const SizedBox(height: 32),
              small(areas[2]),
            ],
          )
        : IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 640, child: wide),
                const SizedBox(width: 32),
                Expanded(child: small(areas[1])),
                const SizedBox(width: 32),
                Expanded(child: small(areas[2])),
              ],
            ),
          );

    return Section(
      scheme: scheme,
      child: Column(
        children: [
          const SectionTitle(
            scheme: scheme,
            centered: true,
            tagline: 'Expertise',
            heading: 'What I build',
            description:
                'Payments, native integrations and release engineering: the parts of a Flutter app that are hardest to get right.',
          ),
          SizedBox(height: mobile ? 48 : 80),
          cards,
        ],
      ),
    );
  }
}

/// Template "Testimonial / 14", filled with the Mismar store numbers.
class _Highlight extends StatelessWidget {
  const _Highlight();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.light;
    final app = LiveApps.all[0];
    final storeUrl = app.links[1].url;

    final image = AspectRatio(
      aspectRatio: 600 / 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DsSpace.radius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetImage(app.shots[2].full, alignment: const Alignment(0, -0.8)),
            Container(color: Colors.black.withValues(alpha: 0.4)),
            Center(
              child: Material(
                color: DsColors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => openLink(storeUrl),
                  child: const SizedBox(
                    width: 64,
                    height: 64,
                    child: Icon(Icons.apple, color: DsColors.darkest, size: 32),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < 4; i++)
              const Icon(Icons.star_rounded, size: 24, color: DsColors.darkest),
            const Icon(Icons.star_half_rounded, size: 24, color: DsColors.darkest),
            const SizedBox(width: 8),
            Text('4.1 on the App Store', style: DsText.small(scheme.text)),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          '"Over 100K Google Play downloads and 16K App Store ratings for the car-services app I have built on since 2023."',
          style: DsText.h5(mobile, scheme.text),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app.name, style: DsText.regularSemi(mobile, scheme.text)),
                Text('Customer app · Saudi Arabia', style: DsText.regular(mobile, scheme.text)),
              ],
            ),
            const SizedBox(width: 20),
            Container(width: 1, height: 61, color: DsColors.darkest15),
            const SizedBox(width: 20),
            SizedBox(
              width: 48,
              height: 48,
              child: NetImage(app.iconUrl, radius: 10, fallbackIcon: app.fallbackIcon),
            ),
          ],
        ),
      ],
    );

    return Section(
      scheme: scheme,
      child: SplitRow(left: image, right: content),
    );
  }
}
