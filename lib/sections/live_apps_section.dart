import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class LiveAppsSection extends StatelessWidget {
  const LiveAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Live apps',
      title: 'Apps you can download today',
      child: Column(
        children: [
          for (final app in LiveApps.all)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _LiveAppCard(app),
            ),
        ],
      ),
    );
  }
}

class _LiveAppCard extends StatelessWidget {
  const _LiveAppCard(this.app);

  final LiveApp app;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);
    return HoverCard(
      padding: EdgeInsets.all(mobile ? 20 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppIcon(app),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(app.name, style: AppText.h3.copyWith(fontSize: 22)),
                    const SizedBox(height: 2),
                    Text(app.company, style: AppText.small),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(app.description, style: AppText.body),
          ),
          if (app.metric != null) ...[
            const SizedBox(height: 8),
            Text(
              app.metric!,
              style: AppText.small.copyWith(
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          if (app.note != null) ...[
            const SizedBox(height: 6),
            Text(
              app.note!,
              style: AppText.small.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [for (final l in app.links) _StoreButton(l)],
          ),
          if (app.shots.isNotEmpty) ...[
            const SizedBox(height: 24),
            _ScreenshotStrip(app.shots, height: mobile ? 340 : 420),
          ],
        ],
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon(this.app);

  final LiveApp app;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      color: AppColors.accent.withValues(alpha: 0.12),
      alignment: Alignment.center,
      child: Icon(app.fallbackIcon, color: AppColors.accent, size: 30),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 60,
        height: 60,
        child: app.iconUrl == null
            ? fallback
            : Image.network(
                app.iconUrl!,
                fit: BoxFit.cover,
                webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                errorBuilder: (_, __, ___) => fallback,
              ),
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  const _StoreButton(this.link);

  final StoreLink link;

  @override
  Widget build(BuildContext context) {
    final icon = switch (link.kind) {
      StoreKind.googlePlay => Icons.shop,
      StoreKind.appStore => Icons.apple,
      StoreKind.more => Icons.apps_rounded,
    };
    final primary = link.kind != StoreKind.more;
    final style = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      foregroundColor: primary ? AppColors.text : AppColors.accent,
      backgroundColor: primary ? AppColors.surfaceAlt : Colors.transparent,
    );
    return OutlinedButton.icon(
      onPressed: () => openLink(link.url),
      style: style,
      icon: Icon(icon, size: 20),
      label: Text(link.text),
    );
  }
}

/// Horizontally scrolling store screenshots with arrow buttons; tap to enlarge.
class _ScreenshotStrip extends StatefulWidget {
  const _ScreenshotStrip(this.shots, {required this.height});

  final List<Shot> shots;
  final double height;

  @override
  State<_ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<_ScreenshotStrip> {
  final _controller = ScrollController();

  double _widthOf(Shot shot) => widget.height * shot.aspect;

  void _scrollBy(double direction) {
    if (!_controller.hasClients) return;
    final step = _widthOf(widget.shots.first) + 14;
    final target = (_controller.offset + direction * step * 2)
        .clamp(0.0, _controller.position.maxScrollExtent);
    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void _open(Shot shot) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => GestureDetector(
        onTap: () => Navigator.of(dialogContext).pop(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                shot.full,
                fit: BoxFit.contain,
                webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showArrows = !isMobileWidth(context);
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.shots.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) {
              final shot = widget.shots[i];
              return MouseRegion(
                cursor: SystemMouseCursors.zoomIn,
                child: GestureDetector(
                  onTap: () => _open(shot),
                  child: Container(
                    width: _widthOf(shot),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      shot.thumb,
                      width: _widthOf(shot),
                      height: widget.height,
                      fit: BoxFit.contain,
                      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (showArrows) ...[
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(child: _ArrowButton(Icons.chevron_left_rounded, () => _scrollBy(-1))),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(child: _ArrowButton(Icons.chevron_right_rounded, () => _scrollBy(1))),
            ),
          ],
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton(this.icon, this.onPressed);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bg.withValues(alpha: 0.85),
      shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.text),
      ),
    );
  }
}
