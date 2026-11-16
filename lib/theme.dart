import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens taken from the Figma template
/// "Full Stack Developer Portfolio – Modern Tech Showcase".
class DsColors {
  static const darkest = Color(0xFF0C0801); // Neutral Darkest
  static const dark = Color(0xFF24201A); // Color Scheme 3 background
  static const light = Color(0xFFDAD9D8); // Color Scheme 4 background
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF2563EB); // Royal Blue
  static const white20 = Color(0x33FFFFFF);
  static const white60 = Color(0x99FFFFFF);
  static const darkest15 = Color(0x260C0801);
  static const darkest60 = Color(0x990C0801);
}

/// The four colour schemes used by the template's sections.
enum Scheme {
  white(DsColors.white, DsColors.darkest, DsColors.darkest15),
  darkest(DsColors.darkest, DsColors.white, DsColors.white20),
  dark(DsColors.dark, DsColors.white, DsColors.white20),
  light(DsColors.light, DsColors.darkest, DsColors.darkest15);

  const Scheme(this.background, this.text, this.border);

  final Color background;
  final Color text;
  final Color border;

  bool get isDark => text == DsColors.white;

  /// Card / foreground surface colour.
  Color get foreground => isDark ? background : DsColors.white;

  /// 60 % version of the text colour for secondary copy.
  Color get muted => isDark ? DsColors.white60 : DsColors.darkest60;
}

class DsSpace {
  static const pagePaddingDesktop = 64.0;
  static const pagePaddingMobile = 20.0;
  static const sectionLargeDesktop = 112.0;
  static const sectionLargeMobile = 64.0;
  static const sectionMediumDesktop = 80.0;
  static const sectionMediumMobile = 48.0;
  static const container = 1280.0;
  static const maxWidth = 768.0;
  static const radius = 16.0;
}

const double kMobileBreakpoint = 768;
const double kTabletBreakpoint = 1100;

bool isMobile(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kMobileBreakpoint;

bool isTablet(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kTabletBreakpoint;

/// Typography. Headings are Poppins Bold, body copy is Inter.
class DsText {
  static TextStyle _poppins(
    double size,
    double height,
    Color color, {
    double letterSpacing = -1,
  }) =>
      GoogleFonts.poppins(
        fontSize: size,
        height: height,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle _inter(
    double size,
    Color color, {
    FontWeight weight = FontWeight.w400,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        height: 1.5,
        fontWeight: weight,
        color: color,
      );

  static TextStyle h1(bool mobile, Color color) =>
      _poppins(mobile ? 40 : 84, 1.1, color);
  static TextStyle h2(bool mobile, Color color) =>
      _poppins(mobile ? 36 : 60, 1.2, color);
  static TextStyle h3(bool mobile, Color color) =>
      _poppins(mobile ? 32 : 48, 1.2, color);
  static TextStyle h4(bool mobile, Color color) =>
      _poppins(mobile ? 24 : 40, 1.3, color);
  static TextStyle h5(bool mobile, Color color) =>
      _poppins(mobile ? 20 : 32, 1.3, color);
  static TextStyle h6(bool mobile, Color color) =>
      _poppins(mobile ? 18 : 26, 1.4, color);

  /// Big stat numbers (Roboto Bold 80 in the template).
  static TextStyle stat(bool mobile, Color color) => GoogleFonts.roboto(
        fontSize: mobile ? 56 : 80,
        height: 1.3,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tagline(Color color) =>
      _inter(16, color, weight: FontWeight.w600);

  static TextStyle medium(bool mobile, Color color) =>
      _inter(mobile ? 18 : 20, color);
  static TextStyle regular(bool mobile, Color color) =>
      _inter(mobile ? 16 : 18, color);
  static TextStyle regularMedium(bool mobile, Color color) =>
      _inter(mobile ? 16 : 18, color, weight: FontWeight.w500);
  static TextStyle regularSemi(bool mobile, Color color) =>
      _inter(mobile ? 16 : 18, color, weight: FontWeight.w600);
  static TextStyle small(Color color) => _inter(16, color);
  static TextStyle smallSemi(Color color) =>
      _inter(16, color, weight: FontWeight.w600);
  static TextStyle tiny(Color color) => _inter(12, color);
}

class AppTheme {
  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: DsColors.blue,
        surface: DsColors.darkest,
        onSurface: DsColors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
    return base.copyWith(
      scaffoldBackgroundColor: DsColors.darkest,
      splashFactory: InkSparkle.splashFactory,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: DsColors.blue.withValues(alpha: 0.35),
        cursorColor: DsColors.white,
      ),
      dividerColor: DsColors.white20,
    );
  }
}
