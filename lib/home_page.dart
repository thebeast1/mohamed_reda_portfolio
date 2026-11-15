import 'package:flutter/material.dart';

import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/education_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/live_apps_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'theme.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _labels = [
    'About',
    'Experience',
    'Apps',
    'Projects',
    'Skills',
    'Education',
    'Contact',
  ];

  final _scrollController = ScrollController();
  final _keys = List.generate(_labels.length, (_) => GlobalKey());

  static const _contact = 6;
  static const _experience = 1;

  void _scrollTo(int index) {
    final ctx = _keys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        labels: _labels,
        onSelect: _scrollTo,
        onLogoTap: _scrollToTop,
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.surface,
        child: SafeArea(
          child: Builder(
            builder: (drawerContext) => ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                for (var i = 0; i < _labels.length; i++)
                  ListTile(
                    title: Text(
                      _labels[i],
                      style: AppText.h3.copyWith(fontSize: 18),
                    ),
                    onTap: () {
                      Scaffold.of(drawerContext).closeEndDrawer();
                      Future.delayed(
                        const Duration(milliseconds: 250),
                        () => _scrollTo(i),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroSection(
                onContact: () => _scrollTo(_contact),
                onWork: () => _scrollTo(_experience),
              ),
              KeyedSubtree(key: _keys[0], child: const AboutSection()),
              KeyedSubtree(key: _keys[1], child: const ExperienceSection()),
              KeyedSubtree(key: _keys[2], child: const LiveAppsSection()),
              KeyedSubtree(key: _keys[3], child: const ProjectsSection()),
              KeyedSubtree(key: _keys[4], child: const SkillsSection()),
              KeyedSubtree(key: _keys[5], child: const EducationSection()),
              KeyedSubtree(key: _keys[6], child: const ContactSection()),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
