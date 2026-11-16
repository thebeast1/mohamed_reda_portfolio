import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import 'ds.dart';

/// Horizontally scrolling store screenshots with arrow buttons; tap to enlarge.
class ScreenshotStrip extends StatefulWidget {
  const ScreenshotStrip(
    this.shots, {
    super.key,
    required this.height,
    required this.scheme,
  });

  final List<Shot> shots;
  final double height;
  final Scheme scheme;

  @override
  State<ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<ScreenshotStrip> {
  final _controller = ScrollController();

  double _widthOf(Shot shot) => widget.height * shot.aspect;

  void _scrollBy(double direction) {
    if (!_controller.hasClients) return;
    final step = _widthOf(widget.shots.first) + 16;
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
              borderRadius: BorderRadius.circular(DsSpace.radius),
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
    final showArrows = !isMobile(context);
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.shots.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final shot = widget.shots[i];
              return MouseRegion(
                cursor: SystemMouseCursors.zoomIn,
                child: GestureDetector(
                  onTap: () => _open(shot),
                  child: Container(
                    width: _widthOf(shot),
                    decoration: BoxDecoration(
                      color: DsColors.dark,
                      borderRadius: BorderRadius.circular(DsSpace.radius),
                      border: Border.all(color: widget.scheme.border),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: NetImage(shot.thumb, fit: BoxFit.contain),
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
              child: Center(
                child: _ArrowButton(Icons.chevron_left_rounded, () => _scrollBy(-1)),
              ),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowButton(Icons.chevron_right_rounded, () => _scrollBy(1)),
              ),
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
      color: DsColors.darkest.withValues(alpha: 0.85),
      shape: const CircleBorder(side: BorderSide(color: DsColors.white20)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: DsColors.white),
      ),
    );
  }
}
