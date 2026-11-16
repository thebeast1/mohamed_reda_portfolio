import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import 'ds.dart';

class NavItem {
  const NavItem(this.label, this.path);
  final String label;
  final String path;
}

const navItems = <NavItem>[
  NavItem('Home', '/'),
  NavItem('About', '/about'),
  NavItem('Projects', '/projects'),
  NavItem('Contact', '/contact'),
];

/// Template "Navbar / 8": 72 px tall, logo + links on the left, actions on the right.
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final compact = isTablet(context);
    final current = GoRouterState.of(context).uri.path;
    const scheme = Scheme.darkest;

    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? DsSpace.pagePaddingMobile : DsSpace.pagePaddingDesktop,
      ),
      color: scheme.background,
      child: Row(
        children: [
          const Logo(),
          if (!compact) ...[
            const SizedBox(width: 24),
            for (final item in navItems)
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: _NavLink(
                  item: item,
                  active: current == item.path,
                ),
              ),
          ],
          const Spacer(),
          if (!compact) ...[
            DsButton(
              label: 'LinkedIn',
              compact: true,
              scheme: scheme,
              onTap: () => openLink(CvData.linkedIn),
            ),
            const SizedBox(width: 16),
            DsButton.primary(
              label: 'Contact',
              compact: true,
              scheme: scheme,
              onTap: () => context.go('/contact'),
            ),
          ] else
            IconButton(
              tooltip: 'Menu',
              icon: const Icon(Icons.menu_rounded, color: DsColors.white, size: 28),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.item, required this.active});

  final NavItem item;
  final bool active;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.active
        ? DsText.regularMedium(false, DsColors.white)
        : DsText.regular(false, _hover ? DsColors.white : DsColors.white60);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.path),
        child: Text(widget.item.label, style: style),
      ),
    );
  }
}

/// White square mark with initials plus the name, 32 px tall like the template logo.
class Logo extends StatelessWidget {
  const Logo({super.key, this.onDark = true});

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final fg = onDark ? DsColors.white : DsColors.darkest;
    final bg = onDark ? DsColors.darkest : DsColors.white;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'MR',
                style: DsText.h6(true, bg).copyWith(fontSize: 13, letterSpacing: 0),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              CvData.name,
              style: DsText.h6(true, fg).copyWith(fontSize: 18, letterSpacing: -0.3),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-screen mobile menu, matching the template's mobile navbar state.
class MobileMenu extends StatelessWidget {
  const MobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final current = GoRouterState.of(context).uri.path;
    const scheme = Scheme.darkest;
    return Drawer(
      width: MediaQuery.sizeOf(context).width,
      backgroundColor: scheme.background,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 72,
                child: Row(
                  children: [
                    const Logo(),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: DsColors.white, size: 28),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              for (final item in navItems)
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(item.path);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      item.label,
                      style: current == item.path
                          ? DsText.regularMedium(true, DsColors.white)
                          : DsText.regular(true, DsColors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: DsButton(
                        label: 'LinkedIn',
                        scheme: scheme,
                        onTap: () => openLink(CvData.linkedIn),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Center(
                      child: DsButton.primary(
                        label: 'Contact',
                        scheme: scheme,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go('/contact');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
