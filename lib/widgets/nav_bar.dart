import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import 'common.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
    required this.labels,
    required this.onSelect,
    required this.onLogoTap,
  });

  final List<String> labels;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogoTap;

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    // The full link row needs ~1050px; below that, use the drawer menu.
    final compact = MediaQuery.sizeOf(context).width < 1080;
    final mobile = isMobileWidth(context);
    final contactIndex = labels.length - 1;

    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 40),
      decoration: BoxDecoration(
        color: AppColors.bg.withValues(alpha: 0.92),
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: MaxWidth(
        child: Row(
          children: [
            InkWell(
              onTap: onLogoTap,
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LogoBadge(),
                  const SizedBox(width: 12),
                  Text(
                    CvData.name,
                    style: AppText.h3.copyWith(fontSize: 17),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (!compact) ...[
              for (var i = 0; i < contactIndex; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: TextButton(
                    onPressed: () => onSelect(i),
                    child: Text(labels[i]),
                  ),
                ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () => onSelect(contactIndex),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                ),
                child: Text(labels[contactIndex]),
              ),
            ] else
              IconButton(
                tooltip: 'Menu',
                icon: const Icon(Icons.menu_rounded, color: AppColors.text),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
          ],
        ),
      ),
    );
  }
}

class LogoBadge extends StatelessWidget {
  const LogoBadge({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: const LinearGradient(
          colors: [AppColors.accent, AppColors.accentDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Text(
        'MR',
        style: TextStyle(
          color: AppColors.bg,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.38,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
