import 'package:flutter/material.dart';

/// All portfolio content lives here, so updating the site after a CV change
/// only means editing this file.
class CvData {
  static const name = 'Mohamed Reda';
  static const title = 'Senior Flutter Developer';
  static const location = 'Cairo, Egypt';
  static const email = 'mohamed.reda.ali.ebayd@gmail.com';
  static const linkedIn = 'https://linkedin.com/in/mohamed-reda1';
  static const linkedInLabel = 'linkedin.com/in/mohamed-reda1';

  static const tagline =
      '6 years shipping consumer and operations apps for Android, iOS and web, '
      'across automotive services, healthcare, edtech, transport and safety.';

  static const summary =
      'Flutter developer with 6 years of experience shipping consumer and '
      'operations apps for Android, iOS and web, across automotive services, '
      'healthcare, edtech, transport and safety. For the past three years I have '
      'worked on Mismar, a Saudi car-services app with 100K+ Google Play '
      'downloads and 15K App Store ratings, covering payments, loyalty, native '
      'SDK integration, analytics and over-the-air releases. Working remotely '
      'since 2020. Native Arabic, professional English.';

  static const stats = <Stat>[
    Stat('6+', 'Years building with Flutter'),
    Stat('100K+', 'Google Play downloads on Mismar'),
    Stat('160+', 'White-label apps published for Infinity Academy'),
    Stat('2020', 'Working remotely since'),
  ];

  static const focusAreas = <FocusArea>[
    FocusArea(
      Icons.payments_outlined,
      'Payments & commerce',
      'Moyasar, Apple Pay, Noon, wallets, invoices, VAT, loyalty and referrals.',
    ),
    FocusArea(
      Icons.integration_instructions_outlined,
      'Native integration',
      'Platform channels, Swift packages, iOS notification extensions and third-party native SDKs.',
    ),
    FocusArea(
      Icons.rocket_launch_outlined,
      'Release engineering',
      'Shorebird code push, Fastlane, Codemagic, multi-environment and white-label builds.',
    ),
  ];

  static const experience = <Experience>[
    Experience(
      role: 'Flutter Developer',
      company: 'Mismar',
      period: 'Jun 2023 – Present',
      location: 'Remote (Saudi Arabia)',
      type: 'Full-time',
      summary:
          'Mismar connects car owners with workshops and technicians for maintenance, '
          'repair, towing and rental. The customer app has 100K+ downloads on Google Play '
          'and 15K ratings (4.1) on the App Store.',
      highlights: [
        'Built and maintained the customer app and the internal operations app (Android and iOS) in a team of about six developers; the customer app spans 45 feature modules.',
        'Worked on the payment flows: card payments through Moyasar, Apple Pay and Noon, wallet deductions, invoices, quotations, discounts and VAT.',
        "Delivered car rental through a third-party rental partner's API, gift packages, subscriptions, a loyalty-points and referral programme, order scheduling with time slots, towing, and insurance and B2B orders.",
        'Set up over-the-air updates with Shorebird code push, including automatic patch install and a CI patch workflow, and handled release branches across dev, staging, UAT and production.',
        'Integrated a driving-behaviour (telematics) SDK natively on iOS (Swift packages) and Android, and added an iOS notification service extension for rich push notifications.',
        'Instrumented the app with Adjust (events and revenue), PostHog, CleverTap and Firebase Analytics, and migrated Firebase Dynamic Links to native deep links.',
        'Refactored features into Clean Architecture domain and presentation layers, moved API base URLs to Firebase Remote Config, and resolved crashes reported through Sentry.',
        'Operations app: chat with pagination and group mentions, spare-parts quotations and purchase orders, towing flows and order confirmation codes.',
        'Flutter Web: contributed to the web version of the customer app, including a white-label build for a banking partner and card payments on web.',
        'Built seasonal mini-games with the Flame engine for Ramadan, Eid and national-day campaigns to increase engagement.',
      ],
      tags: ['Clean Architecture', 'Payments', 'Shorebird', 'Native SDKs', 'Flutter Web', 'Flame'],
    ),
    Experience(
      role: 'Part-time Flutter Developer',
      company: 'Crash Move',
      period: 'Feb 2024 – Feb 2025',
      location: 'Remote',
      type: 'Part-time',
      summary:
          'Crash Move builds safety apps that let communities and workplaces report and '
          'respond to incidents in real time.',
      highlights: [
        'Built and maintained Safe Home (community incident reporting, missing-person searches, live location sharing) and Safe Work (workplace hazard reporting) for Android and iOS.',
        'Implemented "report and join": responders join an incident, connect in a voice call and coordinate, backed by Firebase Cloud Functions.',
      ],
      tags: ['Firebase', 'Cloud Functions', 'Real-time', 'Location'],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Tikshif',
      period: 'Jun 2022 – May 2023',
      location: 'Cairo, Egypt',
      type: 'Full-time',
      summary:
          'Tikshif is a primary-healthcare platform offering on-demand GP telehealth, '
          'specialist bookings, lab and radiology services and medical records.',
      highlights: [
        'Built and maintained the patient app: doctor search, booking for consultations, labs and radiology, and video consultations with Twilio Programmable Video.',
        'Built and maintained the doctor and nurse app: appointment management, digital prescriptions and wallets.',
        'Stack: BLoC, Firebase Cloud Messaging, Pusher for real-time updates, Google Maps and deep links.',
      ],
      tags: ['BLoC', 'Twilio Video', 'Pusher', 'Google Maps'],
    ),
    Experience(
      role: 'Part-time Flutter Developer',
      company: 'Infinity Academy',
      period: 'Jul 2020 – Jan 2024',
      location: 'Remote',
      type: 'Part-time',
      summary:
          "Infinity Academy is an Egyptian online-learning platform whose apps are published "
          "under each teacher's own brand: more than 160 apps on Google Play with about 300K "
          'downloads in total.',
      highlights: [
        'Built and maintained the student app (recorded lessons, live video, exams, assignments) and the teacher app (finances, submissions, performance tracking), using BLoC.',
        'Produced and released white-label copies of the base app for individual teachers on Google Play and the App Store.',
        'Added in-app purchases and Apple Pay, PDF downloads and a redesigned exam flow with solutions and results.',
        'Protected paid content with video watermarking and rooted-device detection, and set up Fastlane for iOS releases.',
      ],
      tags: ['White-label', 'BLoC', 'In-app purchases', 'Fastlane'],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Yellow Helmet',
      period: 'Feb 2020 – Jan 2021',
      location: 'Cairo, Egypt',
      type: 'Full-time',
      summary:
          'Yellow Helmet builds digital safety and operations systems for oil and gas companies.',
      highlights: [
        'Designed and built a digital permit-to-work system from scratch: the Flutter app plus the Laravel backend, APIs and database.',
        'Created approval workflows for maintenance requests, permits and isolation certificates across departments, replacing manual paperwork.',
        'Led the project from first requirements to final delivery.',
      ],
      tags: ['Flutter', 'Laravel', 'REST APIs', 'Workflows'],
    ),
  ];

  static const projects = <Project>[
    Project(
      icon: Icons.directions_car_outlined,
      category: 'Automotive · Saudi Arabia',
      name: 'Mismar',
      description:
          'Car-services marketplace for maintenance, repair, towing and rental, plus an internal operations app.',
      metric: '100K+ downloads · 45 feature modules',
      tags: ['Payments', 'Loyalty', 'Shorebird', 'Telematics SDK'],
    ),
    Project(
      icon: Icons.school_outlined,
      category: 'EdTech · White-label',
      name: 'Infinity Academy',
      description:
          "Student and teacher apps released under each teacher's own brand, with live video, exams and protected content.",
      metric: '160+ apps · ~300K downloads',
      tags: ['White-label', 'IAP', 'Fastlane'],
    ),
    Project(
      icon: Icons.local_hospital_outlined,
      category: 'Healthcare',
      name: 'Tikshif',
      description:
          'Telehealth patient app and doctor/nurse app: bookings, labs, radiology, video consultations and digital prescriptions.',
      tags: ['Twilio Video', 'BLoC', 'Pusher'],
    ),
    Project(
      icon: Icons.health_and_safety_outlined,
      category: 'Safety',
      name: 'Safe Home & Safe Work',
      description:
          'Community and workplace incident reporting with live location sharing and "report and join" voice coordination.',
      tags: ['Firebase', 'Cloud Functions', 'Voice'],
    ),
    Project(
      icon: Icons.engineering_outlined,
      category: 'Oil & Gas',
      name: 'Digital Permit-to-Work',
      description:
          'End-to-end system built from scratch: Flutter app, Laravel backend and approval workflows replacing paperwork.',
      tags: ['Flutter', 'Laravel', 'Full-stack'],
    ),
    Project(
      icon: Icons.train_outlined,
      category: 'Transport · Freelance',
      name: 'Saudi Rail Booking App',
      description:
          'Booking, saved passengers, extras, boarding passes and car cargo screens with full Arabic localisation.',
      tags: ['Localisation', 'RTL', 'Calendar'],
    ),
    Project(
      icon: Icons.sports_tennis_outlined,
      category: 'Sports · Freelance',
      name: 'Padel Community Admin',
      description:
          'Flutter Web admin dashboard: clubs, match details, and feedback and ratings tables with filters.',
      tags: ['Flutter Web', 'Riverpod', 'Firestore', 'go_router'],
    ),
    Project(
      icon: Icons.sports_esports_outlined,
      category: 'Engagement',
      name: 'Seasonal Mini-games',
      description:
          'Campaign games built with the Flame engine for Ramadan, Eid and national-day promotions inside Mismar.',
      tags: ['Flame', 'Gamification'],
    ),
  ];

  static const skills = <SkillGroup>[
    SkillGroup('Flutter & Dart', [
      'Android', 'iOS', 'Flutter Web', 'Flame engine', 'Arabic/English RTL', 'White-label builds', 'Multi-environment',
    ]),
    SkillGroup('Architecture & State', [
      'BLoC', 'Provider', 'Riverpod', 'Clean Architecture', 'SOLID', 'get_it', 'injectable', 'go_router',
    ]),
    SkillGroup('Backend & Data', [
      'REST / Dio', 'Firebase', 'Firestore', 'Cloud Functions', 'Remote Config', 'Hive', 'Pusher', 'Laravel',
    ]),
    SkillGroup('Payments', ['Moyasar', 'Apple Pay', 'Noon', 'In-app purchases', 'Wallets']),
    SkillGroup('Maps & Real-time', ['Google Maps', 'Geolocation', 'Twilio', 'Agora']),
    SkillGroup('Native Integration', [
      'Platform channels', 'Swift packages', 'iOS notification extensions', 'Native SDKs',
    ]),
    SkillGroup('Release & Monitoring', [
      'Shorebird', 'Fastlane', 'Codemagic', 'Git', 'Sentry', 'Crashlytics',
    ]),
    SkillGroup('Analytics', ['Firebase Analytics', 'PostHog', 'Adjust', 'CleverTap']),
  ];

  static const education = Education(
    degree: 'Bachelor of Computer Science',
    school: 'Faculty of Computers and Artificial Intelligence, Cairo University',
    period: 'Sep 2016 – Jun 2020',
  );

  static const earlyRoles = <EarlyRole>[
    EarlyRole('Android Instructor', 'SCCI', 'Sep 2019 – Jun 2020'),
    EarlyRole('ASP.NET Developer (intern)', 'National Technology', 'Jul – Aug 2019'),
    EarlyRole('Android Developer (intern)', 'El-Sab3 Auto Service', 'Jun – Sep 2018'),
  ];

  static const languages = <String>['Arabic — native', 'English — professional working proficiency'];
}

class Stat {
  const Stat(this.value, this.label);
  final String value;
  final String label;
}

class FocusArea {
  const FocusArea(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;
}

class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.type,
    required this.summary,
    required this.highlights,
    this.tags = const [],
  });

  final String role;
  final String company;
  final String period;
  final String location;
  final String type;
  final String summary;
  final List<String> highlights;
  final List<String> tags;
}

class Project {
  const Project({
    required this.icon,
    required this.category,
    required this.name,
    required this.description,
    this.metric,
    this.tags = const [],
  });

  final IconData icon;
  final String category;
  final String name;
  final String description;
  final String? metric;
  final List<String> tags;
}

class SkillGroup {
  const SkillGroup(this.title, this.items);
  final String title;
  final List<String> items;
}

class Education {
  const Education({required this.degree, required this.school, required this.period});
  final String degree;
  final String school;
  final String period;
}

class EarlyRole {
  const EarlyRole(this.title, this.org, this.period);
  final String title;
  final String org;
  final String period;
}

// ---------------------------------------------------------------------------
// Live apps: published store listings (links verified Nov 2026) with
// screenshots hot-linked from the stores.
// ---------------------------------------------------------------------------

enum StoreKind { googlePlay, appStore, more }

class StoreLink {
  const StoreLink(this.kind, this.url, [this.label]);
  final StoreKind kind;
  final String url;
  final String? label;

  String get text =>
      label ??
      switch (kind) {
        StoreKind.googlePlay => 'Google Play',
        StoreKind.appStore => 'App Store',
        StoreKind.more => 'More',
      };
}

enum ShotSource { play, appStore }

/// A store screenshot. [base] is the image URL without its size suffix.
class Shot {
  /// [aspect] is the screenshot's width / height, so the gallery can show it
  /// at its real shape instead of cropping it.
  const Shot.play(this.base, {this.aspect = 9 / 19.5}) : source = ShotSource.play;
  const Shot.appStore(this.base, {this.aspect = 9 / 19.5}) : source = ShotSource.appStore;

  final String base;
  final ShotSource source;
  final double aspect;

  String get thumb =>
      source == ShotSource.play ? '$base=h840' : '${base}420x912bb.jpg';
  String get full =>
      source == ShotSource.play ? '$base=h1600' : '${base}736x1600bb.jpg';
}

class LiveApp {
  const LiveApp({
    required this.name,
    required this.company,
    required this.description,
    required this.links,
    required this.shots,
    required this.fallbackIcon,
    this.iconUrl,
    this.metric,
    this.note,
  });

  final String name;
  final String company;
  final String description;
  final String? metric;
  final String? note;
  final String? iconUrl;
  final IconData fallbackIcon;
  final List<StoreLink> links;
  final List<Shot> shots;
}

class LiveApps {
  static const _play = 'https://play-lh.googleusercontent.com/';
  static const _mz = 'https://is1-ssl.mzstatic.com/image/thumb/';

  static const all = <LiveApp>[
    LiveApp(
      name: 'MisMar مسمار',
      company: 'Mismar · Customer app',
      description:
          'Car maintenance, repair, towing and rental for car owners in Saudi Arabia. '
          'I worked on payments, loyalty, rental, native SDKs, analytics and OTA releases.',
      metric: '100K+ downloads on Google Play · 16K App Store ratings',
      iconUrl:
          '${_play}EeWiABto_IriBpd6x2aZvT6gTNWKrwHIAINq2zotGNj77gfPmzJGq_zV6hOC_ZdEmcIPNuFL0oL8H9iaPYstRw=s128',
      fallbackIcon: Icons.directions_car_outlined,
      links: [
        StoreLink(StoreKind.googlePlay, 'https://play.google.com/store/apps/details?id=sa.com.carx'),
        StoreLink(StoreKind.appStore, 'https://apps.apple.com/sa/app/id1493302809'),
      ],
      shots: [
        Shot.appStore('${_mz}Purple221/v4/2c/3a/68/2c3a6840-63a0-e099-5201-b4ad6b851b57/68b08513-dc8b-468f-822e-12ab1bdaff3c_01-6.5.png/'),
        Shot.appStore('${_mz}Purple211/v4/74/90/28/74902890-9ae1-66bd-0225-41e07470fe29/548d93a3-5f1a-48d1-9c7a-916c7b9c8154_02-6.5.png/'),
        Shot.appStore('${_mz}Purple211/v4/d1/fb/b2/d1fbb2a1-aca1-a6e2-c6c8-dca6f9efbdd8/151fd44a-ee04-4c53-adde-5f6b2060edc4_03-6.5.png/'),
        Shot.appStore('${_mz}Purple211/v4/57/b7/f6/57b7f645-a225-b10a-5d5a-b3a2b4dfe760/4bd15d6e-74a6-4a4a-a6fb-ccd109744515_04-6.5.png/'),
        Shot.appStore('${_mz}Purple211/v4/d1/a7/9b/d1a79ba6-ccdf-47e2-02c5-b08013f20255/630283c3-d1ee-4eae-b092-8da4a7b11c50_05-6.5.png/'),
        Shot.appStore('${_mz}Purple221/v4/b6/b8/64/b6b86400-e59b-55bf-1b64-f6945e2e5334/ef20b7a9-c04b-4b0b-b37b-2522cb186139_06-6.5.png/'),
      ],
    ),
    LiveApp(
      name: 'MisMar Ops',
      company: 'Mismar · Operations app',
      description:
          'Internal app for workshops and suppliers in the MisMar network: order management, '
          'chat with mentions, spare-parts quotations, purchase orders and towing flows.',
      iconUrl:
          '${_play}jor_tH3nRno2ui9HrHVF75hoz7l9vxIsi_pRFDBzQ1FaQEDxUNoadcMmF8dLM7JOYlTI51OH9upPdeUq7rqNiW4=s128',
      fallbackIcon: Icons.build_outlined,
      links: [
        StoreLink(StoreKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.mismarapp.opsapp'),
        StoreLink(StoreKind.appStore, 'https://apps.apple.com/sa/app/id6461161680'),
      ],
      shots: [
        Shot.play('${_play}9s_kP-8438GgjGoAQawnJQ-JESAM0kw9-W-0BVAr49ozgzyViEAea-64jBtoYSQ-CRZ_Bnjy7UmQSAmzMIJju5c', aspect: 387 / 840),
        Shot.play('${_play}7gJyJAYyAXLLr5RVTkpfSECT-RqjtUlBQUkh40FmpuBhcsmyS3EdSKq3ZlQy6GjrTCvLBEb-7IlBUQkJyWUUu7U', aspect: 387 / 840),
        Shot.play('${_play}1UsrERVkUBy86Mbq4ouQs3e_08bOxHi8LSknXwrQ-MaWe2f9zlNBnSPb_tgO2zFn4QV9mcShPBGOqUvI9tiOPA', aspect: 387 / 840),
      ],
    ),
    LiveApp(
      name: 'Infinity Academy',
      company: 'Infinity Academy · EdTech',
      description:
          "The base student app behind 160+ white-label apps published under each teacher's "
          'own brand: recorded lessons, live video, exams and protected paid content.',
      metric: '160+ apps on Google Play · ~300K downloads in total',
      iconUrl:
          '${_play}xMUvMEwTmG4VQon4uIZ6672SgWtJavZ8nOGZnhEDR29NTuqmf3QqCuKaU8LaDSAVe_-JkoQoBVD__8kmomly=s128',
      fallbackIcon: Icons.school_outlined,
      links: [
        StoreLink(StoreKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.geek.infinity'),
        StoreLink(StoreKind.more, 'https://play.google.com/store/apps/dev?id=5014854231813871405', 'All 160+ apps'),
      ],
      shots: [
        Shot.play('${_play}Q_2CC2pInOvQMlBXjBpSWSIFh6OiIZx7zBC8cV1XTtDamVG0iOJ_A83EREsyEK8R_ipapNavulO96-j8313P', aspect: 420 / 840),
        Shot.play('${_play}AG2V0DvfiTMVHGAf5jJw-dPYZzlShQO2WWB8ivIk9T9YtBAxcwQOQtdfb5VmDqH1ctRc5CGqYmvg-F7w8B_-', aspect: 420 / 840),
        Shot.play('${_play}hn18EA0kCLyGL2OiAAz4oApQv6C0akOYuTsdQIrzG4YW_wO2wLYUxociz9H2tPcvBndycur4DwI1bN8TIIerWA', aspect: 420 / 840),
        Shot.play('${_play}s5ksRSMj_6nepZ6jgin7uf859W_h9FS4u9dJAXtUivwja9Ktp6CDj4fSlS-HxZGCsehqG8fQWk32QNNZdmvy', aspect: 420 / 840),
        Shot.play('${_play}tMijzNq5JyDcGyULtd1yfiCbZOOiiYd3-LVnBVfcRd6xsPIDq7FQDLmt6vSiocwyOVqUEzUU865GVPMC8FK-6g', aspect: 630 / 840),
        Shot.play('${_play}l2G6OFiqEUpLS_-ieAjrAZ_X3zVFJX3eGE2rtqSzOg658CSdBUnbSg90VEpORkM1LxcJk77KuJG1oKvlBHOb', aspect: 630 / 840),
      ],
    ),
    LiveApp(
      name: 'Crash Move: Safe Work',
      company: 'Crash Move · Safety (Netherlands)',
      description:
          'Workplace incident reporting that connects employees, visitors and responders, '
          'with "report and join" voice coordination.',
      note: 'Crash Move has since renamed and redesigned the listing as "Paraat Locatie"; current store screenshots show the new version.',
      fallbackIcon: Icons.health_and_safety_outlined,
      links: [
        StoreLink(StoreKind.googlePlay, 'https://play.google.com/store/apps/details?id=com.safework.app'),
        StoreLink(StoreKind.appStore, 'https://apps.apple.com/nl/app/id1471607363'),
      ],
      shots: [
        Shot.play('${_play}HI75WzDy2IAp756mXqE7kDvxkNkhE8cTC5bkiPsSygixjNv1QZuGsVOaweggZxrhpr_VD-gHINkh_wKDIVOHzA', aspect: 472 / 840),
        Shot.play('${_play}aYf3N5sGuAYgiRj0S2GjdetRzT6XxumDkCLesublLse9R81JNGM28UgKci0swAvX_Nwcgh2CjRYHGJeA-8lA', aspect: 472 / 840),
        Shot.play('${_play}RpGPShpy_9Qc5hfYPkqqOlIwm6oDXxTe-SobJem4O9e2cGEH6ipUeu8YtQOS8WgfgilNdvVC7bYFJ-mbTS9c', aspect: 472 / 840),
        Shot.play('${_play}dcsf1ce63JbSQQ1J30iRB5EfTkJC-Xn2DHfaThcYCSgmjB-svR1UGv0GEkH9UzvMHUdYUgPyGOWSBldFJKJSxg', aspect: 472 / 840),
        Shot.play('${_play}vBTzmU2wjP-XFi6qu0W69FiLoAKtkuxT8AqHFEBFo3Luf_88NpB7orZxZlwcJbsnChduTkxhluJW2PsU3pXIRw', aspect: 472 / 840),
      ],
    ),
  ];
}
