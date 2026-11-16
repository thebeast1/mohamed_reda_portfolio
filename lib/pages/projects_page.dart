import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/ds.dart';
import '../widgets/hero_images.dart';
import '../widgets/project_card.dart';
import '../widgets/screenshot_strip.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final _gridKey = GlobalKey();

  void _scrollToGrid() {
    final ctx = _gridKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(onExplore: _scrollToGrid),
        const _Domains(),
        KeyedSubtree(key: _gridKey, child: const _AllProjects()),
        const _LiveAppsSection(),
      ],
    );
  }
}

/// Template "Header / 126".
class _Header extends StatelessWidget {
  const _Header({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.darkest;
    final ops = LiveApps.all[1];
    final safe = LiveApps.all[3];
    return Section(
      scheme: scheme,
      child: SplitRow(
        gap: 64,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Projects that ship and get used', style: DsText.h1(mobile, scheme.text)),
            const SizedBox(height: 24),
            Text(
              'Consumer apps, operations tools, web dashboards and campaign games, built in Flutter for Android, iOS and the web.',
              style: DsText.medium(mobile, scheme.text),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                DsButton.primary(label: 'Explore', scheme: scheme, onTap: onExplore),
                DsButton(
                  label: 'Contact',
                  scheme: scheme,
                  onTap: () => context.go('/contact'),
                ),
              ],
            ),
          ],
        ),
        right: HeroImages(large: ops.shots[0].full, small: safe.shots[0].full),
      ),
    );
  }
}

/// Template "Layout / 32": icon list beside a tall image.
class _Domains extends StatelessWidget {
  const _Domains();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.white;
    final infinity = LiveApps.all[2];
    return Section(
      scheme: scheme,
      child: SplitRow(
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final d in CvData.domains)
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(d.icon, size: 48, color: scheme.text),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.title, style: DsText.h5(mobile, scheme.text)),
                          const SizedBox(height: 16),
                          Text(d.description, style: DsText.regular(mobile, scheme.text)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DsButton(
                  label: 'About me',
                  scheme: scheme,
                  onTap: () => context.go('/about'),
                ),
                DsButton.link(
                  label: 'Apps on the stores',
                  scheme: scheme,
                  onTap: () => openLink(LiveApps.all[0].links[0].url),
                ),
              ],
            ),
          ],
        ),
        right: AspectRatio(
          aspectRatio: 600 / 640,
          child: NetImage(
            infinity.shots[4].full,
            radius: DsSpace.radius,
            alignment: const Alignment(0, -0.6),
          ),
        ),
      ),
    );
  }
}

/// Template "Portfolio / 13" with every project.
class _AllProjects extends StatelessWidget {
  const _AllProjects();

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
            tagline: 'Work',
            heading: 'All projects',
            description:
                'Eight products across automotive, edtech, healthcare, safety, oil and gas, transport and sports.',
          ),
          SizedBox(height: mobile ? 48 : 80),
          DsGrid(
            columns: 3,
            children: [for (final p in CvData.projects) ProjectCard(p)],
          ),
        ],
      ),
    );
  }
}

/// Template "Content / 17": heading on the left, long-form content on the right.
class _LiveAppsSection extends StatelessWidget {
  const _LiveAppsSection();

  @override
  Widget build(BuildContext context) {
    const scheme = Scheme.darkest;
    final apps = LiveApps.all;
    return Section(
      scheme: scheme,
      child: SplitRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        leftFlex: 5,
        rightFlex: 7,
        left: const SectionTitle(
          scheme: scheme,
          tagline: 'Live apps',
          heading: 'Apps you can download today',
          description:
              'Published listings with screenshots straight from Google Play and the App Store.',
        ),
        right: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < apps.length; i++) ...[
              _LiveAppBlock(apps[i]),
              if (i < apps.length - 1) ...[
                const SizedBox(height: 48),
                const Divider(height: 1, thickness: 1, color: DsColors.white20),
                const SizedBox(height: 48),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _LiveAppBlock extends StatelessWidget {
  const _LiveAppBlock(this.app);

  final LiveApp app;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.darkest;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: NetImage(app.iconUrl, radius: 10, fallbackIcon: app.fallbackIcon),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(app.name, style: DsText.h5(mobile, scheme.text)),
                  Text(app.company, style: DsText.small(scheme.muted)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(app.description, style: DsText.regular(mobile, scheme.text)),
        if (app.metric != null) ...[
          const SizedBox(height: 8),
          Text(app.metric!, style: DsText.regularSemi(mobile, scheme.text)),
        ],
        if (app.note != null) ...[
          const SizedBox(height: 8),
          Text(app.note!, style: DsText.tiny(scheme.muted)),
        ],
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final l in app.links)
              DsButton(
                label: l.text,
                scheme: scheme,
                icon: switch (l.kind) {
                  StoreKind.googlePlay => Icons.shop_outlined,
                  StoreKind.appStore => Icons.apple,
                  StoreKind.more => Icons.apps_rounded,
                },
                onTap: () => openLink(l.url),
              ),
          ],
        ),
        if (app.shots.isNotEmpty) ...[
          const SizedBox(height: 32),
          ScreenshotStrip(app.shots, height: mobile ? 340 : 420, scheme: scheme),
        ],
      ],
    );
  }
}
