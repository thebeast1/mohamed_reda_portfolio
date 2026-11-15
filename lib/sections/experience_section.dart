import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface.withValues(alpha: 0.35),
      child: SectionShell(
        eyebrow: 'Experience',
        title: 'Where I have worked',
        child: Column(
          children: [
            for (var i = 0; i < CvData.experience.length; i++)
              _ExperienceRow(
                item: CvData.experience[i],
                isLast: i == CvData.experience.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceRow extends StatelessWidget {
  const _ExperienceRow({required this.item, required this.isLast});

  final Experience item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);
    final card = Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
      child: _ExperienceCard(item: item, showMeta: mobile),
    );

    if (mobile) return card;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.only(top: 26, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.period,
                    textAlign: TextAlign.right,
                    style: AppText.small.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(item.location, textAlign: TextAlign.right, style: AppText.small),
                ],
              ),
            ),
          ),
          _TimelineRail(isLast: isLast),
          const SizedBox(width: 24),
          Expanded(child: card),
        ],
      ),
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({required this.isLast});

  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      child: Column(
        children: [
          const SizedBox(height: 28),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bg,
              border: Border.all(color: AppColors.accent, width: 3),
            ),
          ),
          Expanded(
            child: Container(
              width: 2,
              color: isLast ? Colors.transparent : AppColors.border,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({required this.item, required this.showMeta});

  final Experience item;
  final bool showMeta;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  static const _collapsedCount = 4;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final canCollapse = item.highlights.length > _collapsedCount;
    final visible = _expanded || !canCollapse
        ? item.highlights
        : item.highlights.take(_collapsedCount).toList();

    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(item.company, style: AppText.h3.copyWith(fontSize: 22)),
              _TypeBadge(item.type),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.role,
            style: AppText.body.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (widget.showMeta) ...[
            const SizedBox(height: 4),
            Text('${item.period} · ${item.location}', style: AppText.small),
          ],
          const SizedBox(height: 12),
          Text(item.summary, style: AppText.body),
          const SizedBox(height: 14),
          for (final h in visible) _Bullet(h),
          if (canCollapse)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => setState(() => _expanded = !_expanded),
                icon: Icon(
                  _expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  size: 20,
                ),
                label: Text(
                  _expanded
                      ? 'Show less'
                      : 'Show ${item.highlights.length - _collapsedCount} more',
                ),
                style: TextButton.styleFrom(foregroundColor: AppColors.accent),
              ),
            ),
          if (item.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            TagWrap(item.tags),
          ],
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.muted,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 12),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(child: Text(text, style: AppText.body)),
        ],
      ),
    );
  }
}
