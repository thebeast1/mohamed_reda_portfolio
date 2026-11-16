import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import 'ds.dart';
import 'nav_bar.dart';

/// Template "Footer / 1".
class Footer extends StatelessWidget {
  const Footer({super.key});

  static const _scheme = Scheme.darkest;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final stacked = isTablet(context);

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Logo(),
        const SizedBox(height: 24),
        Text(
          'Open to remote Flutter roles and selected freelance projects.',
          style: DsText.regular(mobile, _scheme.text),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: DsColors.white20)),
                ),
                child: Text(
                  CvData.email,
                  style: DsText.regular(mobile, DsColors.white60),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 16),
            DsButton(
              label: 'Email me',
              scheme: _scheme,
              onTap: () => openLink('mailto:${CvData.email}'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Based in ${CvData.location}. Working remotely since 2020.',
          style: DsText.tiny(_scheme.text),
        ),
      ],
    );

    final columns = [
      _LinkColumn(
        title: 'Navigation',
        links: [
          for (final item in navItems)
            _FooterLink(item.label, () => context.go(item.path)),
        ],
      ),
      _LinkColumn(
        title: 'Apps',
        links: [
          for (final app in LiveApps.all)
            _FooterLink(app.name, () => openLink(app.links.first.url)),
        ],
      ),
      _LinkColumn(
        title: 'Connect',
        links: [
          _FooterLink('LinkedIn', () => openLink(CvData.linkedIn), icon: Icons.work_outline_rounded),
          _FooterLink('Email', () => openLink('mailto:${CvData.email}'), icon: Icons.mail_outline_rounded),
          _FooterLink('Google Play apps', () => openLink(LiveApps.all[0].links[0].url), icon: Icons.shop_outlined),
          _FooterLink('App Store apps', () => openLink(LiveApps.all[0].links[1].url), icon: Icons.apple),
        ],
      ),
    ];

    final links = mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final c in columns) ...[c, const SizedBox(height: 40)],
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < columns.length; i++) ...[
                Expanded(child: columns[i]),
                if (i < columns.length - 1) const SizedBox(width: 40),
              ],
            ],
          );

    final credits = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1, thickness: 1, color: DsColors.white20),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 16,
          spacing: 24,
          children: [
            Text(
              '© ${DateTime.now().year} ${CvData.name}. All rights reserved.',
              style: DsText.small(_scheme.text),
            ),
            Wrap(
              spacing: 24,
              children: [
                Text('Built with Flutter Web', style: DsText.small(_scheme.text)),
                DsLink('LinkedIn', scheme: _scheme, onTap: () => openLink(CvData.linkedIn)),
              ],
            ),
          ],
        ),
      ],
    );

    return Section(
      scheme: _scheme,
      medium: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (stacked) ...[
            intro,
            const SizedBox(height: 64),
            links,
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 500, child: intro),
                const SizedBox(width: 128),
                Expanded(child: links),
              ],
            ),
          SizedBox(height: mobile ? 24 : 80),
          credits,
        ],
      ),
    );
  }
}

class _FooterLink {
  const _FooterLink(this.label, this.onTap, {this.icon});
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
}

class _LinkColumn extends StatelessWidget {
  const _LinkColumn({required this.title, required this.links});

  final String title;
  final List<_FooterLink> links;

  @override
  Widget build(BuildContext context) {
    const scheme = Scheme.darkest;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DsText.regularSemi(false, scheme.text)),
        const SizedBox(height: 16),
        for (final l in links)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (l.icon != null) ...[
                  Icon(l.icon, size: 24, color: scheme.text),
                  const SizedBox(width: 12),
                ],
                Flexible(child: DsLink(l.label, scheme: scheme, onTap: l.onTap)),
              ],
            ),
          ),
      ],
    );
  }
}
