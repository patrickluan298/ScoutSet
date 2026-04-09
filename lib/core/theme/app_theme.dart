import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static const Color primaryColor = Color(0xFF081426);
  static const Color accentColor = Color(0xFFF6BF03);
  static const Color secondaryBlueColor = Color(0xFF0F58B5);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color lightGrayColor = Color(0xFFF2F5FA);
  static const Color mediumGrayColor = Color(0xFF8D99AE);
  static const Color textColor = Color(0xFF1F2933);

  static const Color _darkSurface = Color(0xFF071325);
  static const Color _darkSurfaceContainer = Color(0xFF142032);
  static const Color _darkSurfaceContainerLow = Color(0xFF101C2E);
  static const Color _darkAccent = Color(0xFFF6BF03);
  static const Color _darkPrimary = Color(0xFFADC7FF);
  static const Color _darkOnSurface = Color(0xFFD7E3FC);
  static const Color _darkOnSurfaceVariant = Color(0xFFC5C6CD);

  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF264F8F),
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFF264F8F),
          onPrimary: Colors.white,
          secondary: accentColor,
          onSecondary: const Color(0xFF081426),
          surface: const Color(0xFFF4F7FC),
          onSurface: const Color(0xFF10233B),
        ),
        tokens: const ScoutSetThemeColors(
          pageBackground: Color(0xFFF4F7FC),
          surface: Color(0xFFFFFFFF),
          surfaceContainer: Color(0xFFE6EDF8),
          surfaceContainerLow: Color(0xFFF8FAFE),
          accent: Color(0xFFF6BF03),
          primaryDetail: Color(0xFF264F8F),
          onSurface: Color(0xFF10233B),
          onSurfaceVariant: Color(0xFF5A6778),
          border: Color(0xFFD5DEEB),
          subtleBorder: Color(0xFFE6ECF5),
          heroStart: Color(0xFF0E2441),
          heroEnd: Color(0xFF2F5EAA),
          chipBackground: Color(0x0D264F8F),
          chipForeground: Color(0xFF264F8F),
          searchFill: Color(0xFFF8FAFE),
          searchBorder: Color(0xFFD5DEEB),
          divider: Color(0xFFE2E8F2),
          elevatedCard: Color(0xFFFFFFFF),
          panelBackground: Color(0xFFFDFEFF),
          panelAlternate: Color(0xFFF2F6FC),
          navBackground: Color(0xFFFFFFFF),
        ),
      );

  static ThemeData get theme => lightTheme;

  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _darkPrimary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: _darkPrimary,
          onPrimary: _darkSurface,
          secondary: _darkAccent,
          onSecondary: _darkSurface,
          surface: _darkSurface,
          onSurface: _darkOnSurface,
        ),
        tokens: const ScoutSetThemeColors(
          pageBackground: _darkSurface,
          surface: _darkSurface,
          surfaceContainer: _darkSurfaceContainer,
          surfaceContainerLow: _darkSurfaceContainerLow,
          accent: _darkAccent,
          primaryDetail: _darkPrimary,
          onSurface: _darkOnSurface,
          onSurfaceVariant: _darkOnSurfaceVariant,
          border: Color(0xFF2A3A52),
          subtleBorder: Color(0xFF1D2C43),
          heroStart: Color(0xFF0A1730),
          heroEnd: Color(0xFF183154),
          chipBackground: Color(0x1FF6BF03),
          chipForeground: _darkAccent,
          searchFill: _darkSurfaceContainerLow,
          searchBorder: Color(0xFF31435D),
          divider: Color(0xFF23324A),
          elevatedCard: _darkSurfaceContainer,
          panelBackground: _darkSurfaceContainerLow,
          panelAlternate: _darkSurfaceContainer,
          navBackground: _darkSurfaceContainer,
        ),
      );

  static ScoutSetThemeColors colorsOf(BuildContext context) {
    final colors = Theme.of(context).extension<ScoutSetThemeColors>();
    assert(colors != null,
        'ScoutSetThemeColors is not configured on the current theme.');
    return colors!;
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required ScoutSetThemeColors tokens,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.pageBackground,
      extensions: <ThemeExtension<dynamic>>[tokens],
    );

    final onSurface = tokens.onSurface;
    final onSurfaceVariant = tokens.onSurfaceVariant;
    final isDark = brightness == Brightness.dark;
    final baseTextTheme = GoogleFonts.manropeTextTheme(base.textTheme);
    final textTheme = baseTextTheme.copyWith(
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: onSurface,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: onSurface,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16,
        color: onSurface,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 14,
        color: onSurfaceVariant,
        height: 1.4,
      ),
      labelLarge: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      labelMedium: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: onSurfaceVariant,
      ),
      labelSmall: GoogleFonts.manrope(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: onSurfaceVariant,
      ),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.pageBackground,
        foregroundColor: onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      textTheme: textTheme,
      listTileTheme: ListTileThemeData(
        tileColor: tokens.surfaceContainerLow,
        iconColor: tokens.primaryDetail,
        textColor: onSurface,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return tokens.accent;
          }
          return isDark ? tokens.onSurfaceVariant : tokens.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return tokens.accent.withValues(alpha: 0.35);
          }
          return tokens.border;
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tokens.accent,
          foregroundColor: isDark ? tokens.surface : primaryColor,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: tokens.primaryDetail,
          side: BorderSide(color: tokens.primaryDetail),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: tokens.elevatedCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: tokens.subtleBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.searchFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: onSurfaceVariant),
        prefixIconColor: onSurfaceVariant,
        suffixIconColor: onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.searchBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.searchBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.accent, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: tokens.navBackground,
        selectedItemColor: tokens.primaryDetail,
        unselectedItemColor: onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }
}

@immutable
class ScoutSetThemeColors extends ThemeExtension<ScoutSetThemeColors> {
  const ScoutSetThemeColors({
    required this.pageBackground,
    required this.surface,
    required this.surfaceContainer,
    required this.surfaceContainerLow,
    required this.accent,
    required this.primaryDetail,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.border,
    required this.subtleBorder,
    required this.heroStart,
    required this.heroEnd,
    required this.chipBackground,
    required this.chipForeground,
    required this.searchFill,
    required this.searchBorder,
    required this.divider,
    required this.elevatedCard,
    required this.panelBackground,
    required this.panelAlternate,
    required this.navBackground,
  });

  final Color pageBackground;
  final Color surface;
  final Color surfaceContainer;
  final Color surfaceContainerLow;
  final Color accent;
  final Color primaryDetail;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color border;
  final Color subtleBorder;
  final Color heroStart;
  final Color heroEnd;
  final Color chipBackground;
  final Color chipForeground;
  final Color searchFill;
  final Color searchBorder;
  final Color divider;
  final Color elevatedCard;
  final Color panelBackground;
  final Color panelAlternate;
  final Color navBackground;

  @override
  ScoutSetThemeColors copyWith({
    Color? pageBackground,
    Color? surface,
    Color? surfaceContainer,
    Color? surfaceContainerLow,
    Color? accent,
    Color? primaryDetail,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? border,
    Color? subtleBorder,
    Color? heroStart,
    Color? heroEnd,
    Color? chipBackground,
    Color? chipForeground,
    Color? searchFill,
    Color? searchBorder,
    Color? divider,
    Color? elevatedCard,
    Color? panelBackground,
    Color? panelAlternate,
    Color? navBackground,
  }) {
    return ScoutSetThemeColors(
      pageBackground: pageBackground ?? this.pageBackground,
      surface: surface ?? this.surface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      accent: accent ?? this.accent,
      primaryDetail: primaryDetail ?? this.primaryDetail,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      border: border ?? this.border,
      subtleBorder: subtleBorder ?? this.subtleBorder,
      heroStart: heroStart ?? this.heroStart,
      heroEnd: heroEnd ?? this.heroEnd,
      chipBackground: chipBackground ?? this.chipBackground,
      chipForeground: chipForeground ?? this.chipForeground,
      searchFill: searchFill ?? this.searchFill,
      searchBorder: searchBorder ?? this.searchBorder,
      divider: divider ?? this.divider,
      elevatedCard: elevatedCard ?? this.elevatedCard,
      panelBackground: panelBackground ?? this.panelBackground,
      panelAlternate: panelAlternate ?? this.panelAlternate,
      navBackground: navBackground ?? this.navBackground,
    );
  }

  @override
  ScoutSetThemeColors lerp(
    ThemeExtension<ScoutSetThemeColors>? other,
    double t,
  ) {
    if (other is! ScoutSetThemeColors) {
      return this;
    }

    return ScoutSetThemeColors(
      pageBackground: Color.lerp(pageBackground, other.pageBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceContainer:
          Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surfaceContainerLow:
          Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      primaryDetail: Color.lerp(primaryDetail, other.primaryDetail, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      border: Color.lerp(border, other.border, t)!,
      subtleBorder: Color.lerp(subtleBorder, other.subtleBorder, t)!,
      heroStart: Color.lerp(heroStart, other.heroStart, t)!,
      heroEnd: Color.lerp(heroEnd, other.heroEnd, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      chipForeground: Color.lerp(chipForeground, other.chipForeground, t)!,
      searchFill: Color.lerp(searchFill, other.searchFill, t)!,
      searchBorder: Color.lerp(searchBorder, other.searchBorder, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      elevatedCard: Color.lerp(elevatedCard, other.elevatedCard, t)!,
      panelBackground: Color.lerp(panelBackground, other.panelBackground, t)!,
      panelAlternate: Color.lerp(panelAlternate, other.panelAlternate, t)!,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
    );
  }
}
