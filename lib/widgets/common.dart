import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

const double kMobileBreakpoint = 760;

bool isMobileWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kMobileBreakpoint;

Future<void> openLink(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(
    uri,
    webOnlyWindowName: url.startsWith('mailto:') ? '_self' : '_blank',
  );
}

/// Centers content and caps its width.
class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child, this.maxWidth = 1120});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Standard section layout: eyebrow, title, then content.
class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 20 : 40,
        vertical: mobile ? 56 : 88,
      ),
      child: MaxWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eyebrow.toUpperCase(), style: AppText.eyebrow),
            const SizedBox(height: 10),
            Text(title, style: mobile ? AppText.h2Mobile : AppText.h2),
            const SizedBox(height: 36),
            child,
          ],
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.22)),
      ),
      child: Text(label, style: AppText.chip),
    );
  }
}

class TagWrap extends StatelessWidget {
  const TagWrap(this.tags, {super.key});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final t in tags) TagChip(t)],
    );
  }
}

/// Card that lifts slightly and glows on hover.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hover
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.border,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ]
              : const [],
        ),
        child: widget.child,
      ),
    );
  }
}

/// Lays children out in equal-width columns that collapse on narrow screens.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 300,
    this.spacing = 20,
    this.maxColumns = 4,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fit = ((width + spacing) / (minItemWidth + spacing)).floor();
        final columns = math.max(1, math.min(maxColumns, fit));
        final itemWidth = (width - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children) SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

/// Fades and slides its child in once, when first built.
class FadeIn extends StatelessWidget {
  const FadeIn({super.key, required this.child, this.delayMs = 0});

  final Widget child;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 700 + delayMs),
      curve: Interval(delayMs / (700 + delayMs), 1, curve: Curves.easeOutCubic),
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, 24 * (1 - t)), child: child),
      ),
      child: child,
    );
  }
}
