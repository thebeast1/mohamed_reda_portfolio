import 'package:flutter/material.dart';

import '../data/cv_data.dart';
import '../theme.dart';
import '../widgets/cta_section.dart';
import '../widgets/ds.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(),
        _ContactForm(),
        _Faq(),
        CtaSection(
          heading: 'Ready to get started?',
          description:
              'The best time to build is now. Send a message and I will reply within a day.',
        ),
      ],
    );
  }
}

/// Template "Header / 80": centred copy with screenshots floating around it.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final wide = !isTablet(context);
    const scheme = Scheme.darkest;
    final shots = [for (final app in LiveApps.all) ...app.shots.take(2)];

    final content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: DsSpace.maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Let's build your\nnext app",
              textAlign: TextAlign.center,
              style: DsText.h1(mobile, scheme.text),
            ),
            const SizedBox(height: 24),
            Text(
              "Ready to turn an idea into a shipped product, or looking for a senior Flutter developer for your team? Let's talk about scope, timeline and what success looks like.",
              textAlign: TextAlign.center,
              style: DsText.medium(mobile, scheme.text),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                DsButton.primary(
                  label: 'Email me',
                  scheme: scheme,
                  onTap: () => openLink('mailto:${CvData.email}'),
                ),
                DsButton(
                  label: 'LinkedIn',
                  scheme: scheme,
                  onTap: () => openLink(CvData.linkedIn),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (!wide) return Section(scheme: scheme, child: content);

    Widget tile(int i, double size) => SizedBox(
          width: size,
          height: size,
          child: NetImage(
            shots[i % shots.length].thumb,
            radius: DsSpace.radius,
            alignment: const Alignment(0, -0.8),
          ),
        );

    return Container(
      color: scheme.background,
      height: 900,
      child: Stack(
        children: [
          Positioned(left: 64, top: 112, child: tile(0, 200)),
          Positioned(right: 64, top: 160, child: tile(1, 150)),
          Positioned(right: 40, top: 390, child: tile(2, 190)),
          Positioned(left: 160, top: 420, child: tile(3, 170)),
          Positioned(left: 60, bottom: 100, child: tile(4, 120)),
          Positioned(right: 190, bottom: 112, child: tile(5, 160)),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DsSpace.pagePaddingDesktop),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}

/// Template "Contact / 6": contact details beside a form.
class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  static const _scheme = Scheme.dark;
  static const _subjects = ['Job opportunity', 'Freelance project', 'Consultation', 'Something else'];
  static const _roles = ['Recruiter', 'Founder', 'Engineering lead', 'Developer', 'Other'];

  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  final _company = TextEditingController();
  final _message = TextEditingController();
  String? _subject;
  String? _role;

  @override
  void dispose() {
    for (final c in [_first, _last, _email, _company, _message]) {
      c.dispose();
    }
    super.dispose();
  }

  void _send() {
    final name = '${_first.text} ${_last.text}'.trim();
    final subject = _subject ?? 'Message from the portfolio site';
    final body = [
      if (name.isNotEmpty) 'Name: $name',
      if (_email.text.isNotEmpty) 'Email: ${_email.text}',
      if (_company.text.isNotEmpty) 'Company: ${_company.text}',
      if (_role != null) 'I am a: $_role',
      '',
      _message.text,
    ].join('\n');
    final uri = Uri(
      scheme: 'mailto',
      path: CvData.email,
      queryParameters: {'subject': subject, 'body': body},
    );
    openLink(uri.toString());
  }

  InputDecoration _decoration([String? hint]) => InputDecoration(
        hintText: hint,
        hintStyle: DsText.regular(isMobile(context), DsColors.white60),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: DsColors.white20)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: DsColors.white)),
      );

  Widget _field(String label, TextEditingController controller, {int lines = 1, String? hint}) {
    final mobile = isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: DsText.regular(mobile, _scheme.text)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: lines,
          maxLines: lines == 1 ? 1 : null,
          style: DsText.regular(mobile, _scheme.text),
          cursorColor: DsColors.white,
          decoration: _decoration(hint),
        ),
      ],
    );
  }

  Widget _pair(Widget a, Widget b) {
    if (isMobile(context)) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [a, const SizedBox(height: 24), b]);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(child: a), const SizedBox(width: 24), Expanded(child: b)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          scheme: _scheme,
          tagline: 'Connect',
          heading: 'Get in touch',
          description: 'Tell me about the role or the product you are building.',
        ),
        const SizedBox(height: 32),
        _InfoRow(
          Icons.mail_outline_rounded,
          DsLink(
            CvData.email,
            scheme: _scheme,
            style: DsText.regular(mobile, _scheme.text).copyWith(decoration: TextDecoration.underline, decorationColor: DsColors.white),
            onTap: () => openLink('mailto:${CvData.email}'),
          ),
        ),
        _InfoRow(
          Icons.work_outline_rounded,
          DsLink(
            CvData.linkedInLabel,
            scheme: _scheme,
            style: DsText.regular(mobile, _scheme.text).copyWith(decoration: TextDecoration.underline, decorationColor: DsColors.white),
            onTap: () => openLink(CvData.linkedIn),
          ),
        ),
        _InfoRow(
          Icons.location_on_outlined,
          Text('${CvData.location} · remote since 2020', style: DsText.regular(mobile, _scheme.text)),
        ),
      ],
    );

    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _pair(_field('First name', _first), _field('Last name', _last)),
        const SizedBox(height: 24),
        _pair(_field('Email', _email), _field('Company', _company)),
        const SizedBox(height: 24),
        Text("What's this about?", style: DsText.regular(mobile, _scheme.text)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _subject,
          dropdownColor: DsColors.dark,
          iconEnabledColor: DsColors.white,
          style: DsText.regular(mobile, _scheme.text),
          decoration: _decoration('Select one'),
          items: [for (final s in _subjects) DropdownMenuItem(value: s, child: Text(s))],
          onChanged: (v) => setState(() => _subject = v),
        ),
        const SizedBox(height: 32),
        Text('What describes you best?', style: DsText.regular(mobile, _scheme.text)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 24,
          runSpacing: 14,
          children: [
            for (final r in _roles)
              SizedBox(
                width: mobile ? double.infinity : 260,
                child: _Radio(
                  label: r,
                  selected: _role == r,
                  onTap: () => setState(() => _role = r),
                ),
              ),
          ],
        ),
        const SizedBox(height: 32),
        _field('Message', _message, lines: 6, hint: 'Tell me what you need'),
        const SizedBox(height: 32),
        Align(
          alignment: Alignment.centerLeft,
          child: DsButton.primary(label: 'Send', scheme: _scheme, onTap: _send),
        ),
      ],
    );

    return Section(
      scheme: _scheme,
      child: SplitRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        left: details,
        right: form,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.child);

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: DsColors.white),
          const SizedBox(width: 16),
          Flexible(child: child),
        ],
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? DsColors.white : DsColors.white20),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: DsColors.white, shape: BoxShape.circle),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(label, style: DsText.regular(mobile, DsColors.white)),
          ],
        ),
      ),
    );
  }
}

/// Template "FAQ / 4": accordion list with a closing prompt.
class _Faq extends StatefulWidget {
  const _Faq();

  @override
  State<_Faq> createState() => _FaqState();
}

class _FaqState extends State<_Faq> {
  int? _open = 0;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    const scheme = Scheme.light;
    final faqs = CvData.faqs;
    return Section(
      scheme: scheme,
      child: Column(
        children: [
          const SectionTitle(
            scheme: scheme,
            centered: true,
            heading: 'Questions',
            description: 'Answers to what you might be wondering about working with me.',
          ),
          SizedBox(height: mobile ? 48 : 80),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: DsSpace.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < faqs.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DsCard(
                      scheme: scheme,
                      padding: const EdgeInsets.all(24),
                      child: InkWell(
                        onTap: () => setState(() => _open = _open == i ? null : i),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(faqs[i].question, style: DsText.regularSemi(mobile, scheme.text)),
                                ),
                                const SizedBox(width: 24),
                                AnimatedRotation(
                                  duration: const Duration(milliseconds: 200),
                                  turns: _open == i ? 0.125 : 0,
                                  child: Icon(Icons.add_rounded, color: scheme.text, size: 28),
                                ),
                              ],
                            ),
                            if (_open == i)
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(faqs[i].answer, style: DsText.regular(mobile, scheme.text)),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: mobile ? 32 : 48),
          Text('How do we get started?', style: DsText.h4(mobile, scheme.text), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'Send a message through the form above or email me directly, and I will get back to you within a day.',
              style: DsText.medium(mobile, scheme.text),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          DsButton(
            label: 'Email me',
            scheme: scheme,
            onTap: () => openLink('mailto:${CvData.email}'),
          ),
        ],
      ),
    );
  }
}
