import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

Future<void> openLink(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(
    uri,
    webOnlyWindowName: url.startsWith('mailto:') ? '_self' : '_blank',
  );
}

/// A full-width page section: scheme background, page padding, 1280 container.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.scheme,
    required this.child,
    this.medium = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final Scheme scheme;
  final Widget child;

  /// Use the template's medium section padding (80 / 48) instead of large.
  final bool medium;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final vertical = medium
        ? (mobile ? DsSpace.sectionMediumMobile : DsSpace.sectionMediumDesktop)
        : (mobile ? DsSpace.sectionLargeMobile : DsSpace.sectionLargeDesktop);
    return Container(
      color: scheme.background,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? DsSpace.pagePaddingMobile : DsSpace.pagePaddingDesktop,
        vertical: vertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: DsSpace.container),
          child: child,
        ),
      ),
    );
  }
}

/// Tagline + heading + description block used at the top of most sections.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.scheme,
    this.tagline,
    required this.heading,
    this.description,
    this.centered = false,
    this.maxWidth = DsSpace.maxWidth,
    this.level = 2,
  });

  final Scheme scheme;
  final String? tagline;
  final String heading;
  final String? description;
  final bool centered;
  final double maxWidth;

  /// 1 = H1, 2 = H2 (default).
  final int level;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final align = centered ? TextAlign.center : TextAlign.start;
    final headingStyle = level == 1
        ? DsText.h1(mobile, scheme.text)
        : DsText.h2(mobile, scheme.text);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (tagline != null) ...[
            Text(tagline!, style: DsText.tagline(scheme.text), textAlign: align),
            const SizedBox(height: 16),
          ],
          Text(heading, style: headingStyle, textAlign: align),
          if (description != null) ...[
            const SizedBox(height: 24),
            Text(
              description!,
              style: DsText.medium(mobile, scheme.text),
              textAlign: align,
            ),
          ],
        ],
      ),
    );
  }
}

enum DsButtonStyle { primary, secondary, link }

/// Template buttons: primary (blue fill), secondary (outlined), link (text + chevron).
class DsButton extends StatefulWidget {
  const DsButton({
    super.key,
    required this.label,
    required this.onTap,
    this.style = DsButtonStyle.secondary,
    required this.scheme,
    this.compact = false,
    this.icon,
  });

  const DsButton.primary({
    super.key,
    required this.label,
    required this.onTap,
    required this.scheme,
    this.compact = false,
    this.icon,
  }) : style = DsButtonStyle.primary;

  const DsButton.link({
    super.key,
    required this.label,
    required this.onTap,
    required this.scheme,
    this.compact = false,
    this.icon = Icons.chevron_right_rounded,
  }) : style = DsButtonStyle.link;

  final String label;
  final VoidCallback? onTap;
  final DsButtonStyle style;
  final Scheme scheme;

  /// Nav-bar sizing (px 10 / py 4) instead of the default px 12 / py 6.
  final bool compact;
  final IconData? icon;

  @override
  State<DsButton> createState() => _DsButtonState();
}

class _DsButtonState extends State<DsButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final isPrimary = widget.style == DsButtonStyle.primary;
    final isLink = widget.style == DsButtonStyle.link;
    final textColor = isPrimary ? DsColors.white : widget.scheme.text;

    Color background;
    Color borderColor;
    if (isPrimary) {
      background = _hover ? const Color(0xFF1D4ED8) : DsColors.blue;
      borderColor = background;
    } else if (isLink) {
      background = Colors.transparent;
      borderColor = Colors.transparent;
    } else {
      background = _hover
          ? widget.scheme.text.withValues(alpha: 0.06)
          : Colors.transparent;
      borderColor = widget.scheme.border;
    }

    final padding = isLink
        ? EdgeInsets.zero
        : (widget.compact
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 6));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: DsText.regularMedium(mobile, textColor).copyWith(
                  decoration: isLink && _hover ? TextDecoration.underline : null,
                  decorationColor: textColor,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: 24, color: textColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Small outlined tag: px 10, py 4, radius 6.
class DsTag extends StatelessWidget {
  const DsTag(this.label, {super.key, required this.scheme});

  final String label;
  final Scheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: scheme.border),
      ),
      child: Text(label, style: DsText.smallSemi(scheme.text)),
    );
  }
}

class DsTags extends StatelessWidget {
  const DsTags(this.tags, {super.key, required this.scheme});

  final List<String> tags;
  final Scheme scheme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final t in tags) DsTag(t, scheme: scheme)],
    );
  }
}

/// Bordered card with 16 px radius that clips its children.
class DsCard extends StatelessWidget {
  const DsCard({
    super.key,
    required this.scheme,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.height,
  });

  final Scheme scheme;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.foreground,
        borderRadius: BorderRadius.circular(DsSpace.radius),
        border: Border.all(color: scheme.border),
      ),
      child: child,
    );
  }
}

/// Two columns on desktop, stacked on mobile.
class SplitRow extends StatelessWidget {
  const SplitRow({
    super.key,
    required this.left,
    required this.right,
    this.gap = 80,
    this.mobileGap = 48,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.reverseOnMobile = false,
  });

  final Widget left;
  final Widget right;
  final double gap;
  final double mobileGap;
  final int leftFlex;
  final int rightFlex;
  final CrossAxisAlignment crossAxisAlignment;
  final bool reverseOnMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      final children = [left, SizedBox(height: mobileGap), right];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: reverseOnMobile ? children.reversed.toList() : children,
      );
    }
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Expanded(flex: leftFlex, child: left),
        SizedBox(width: gap),
        Expanded(flex: rightFlex, child: right),
      ],
    );
  }
}

/// Equal-width columns on desktop that collapse on narrow screens.
class DsGrid extends StatelessWidget {
  const DsGrid({
    super.key,
    required this.children,
    this.columns = 3,
    this.spacing = 32,
    this.tabletColumns = 2,
  });

  final List<Widget> children;
  final int columns;
  final int tabletColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final cols = isMobile(context)
        ? 1
        : isTablet(context)
            ? tabletColumns
            : columns;
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - spacing * (cols - 1)) / cols;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final c in children) SizedBox(width: itemWidth, child: c),
          ],
        );
      },
    );
  }
}

/// Network image with a quiet fallback tile.
class NetImage extends StatelessWidget {
  const NetImage(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.image_outlined,
    this.radius = 0,
    this.alignment = Alignment.center,
  });

  final String? url;
  final BoxFit fit;
  final IconData fallbackIcon;
  final double radius;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      color: DsColors.dark,
      alignment: Alignment.center,
      child: Icon(fallbackIcon, color: DsColors.white60, size: 40),
    );
    final child = url == null
        ? fallback
        : Image.network(
            url!,
            fit: fit,
            alignment: alignment,
            webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
            errorBuilder: (_, __, ___) => fallback,
          );
    if (radius == 0) return child;
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
  }
}

/// Underlined text link in the footer / contact style.
class DsLink extends StatefulWidget {
  const DsLink(this.label, {super.key, required this.onTap, required this.scheme, this.style});

  final String label;
  final VoidCallback onTap;
  final Scheme scheme;
  final TextStyle? style;

  @override
  State<DsLink> createState() => _DsLinkState();
}

class _DsLinkState extends State<DsLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final base = widget.style ?? DsText.small(widget.scheme.text);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: base.copyWith(
            decoration: _hover ? TextDecoration.underline : TextDecoration.none,
            decorationColor: widget.scheme.text,
          ),
        ),
      ),
    );
  }
}
