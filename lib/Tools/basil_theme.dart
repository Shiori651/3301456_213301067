import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/main.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class BasilTheme extends ThemeExtension<BasilTheme> {
  const BasilTheme({
    this.primaryColor = const Color(0xFF356859),
    this.tertiaryColor = const Color(0xFFFF5722),
    this.neutralColor = const Color(0xFFFFFBE6),
  });

  final Color primaryColor;
  final Color tertiaryColor;
  final Color neutralColor;

  ThemeData toThemeData() {
    ColorScheme colorScheme;

    colorScheme = themeColor().toColorScheme();

    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }

  ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      fontFamily: "OpenSans",
      useMaterial3: true,
      extensions: [this],
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      // ignore: prefer_const_constructors
      textTheme: TextTheme(
        bodyMedium: const TextStyle(fontSize: 15),
      ),
    );
  }

  @override
  ThemeExtension<BasilTheme> copyWith({
    Color? primaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) =>
      BasilTheme(
        primaryColor: primaryColor ?? this.primaryColor,
        tertiaryColor: tertiaryColor ?? this.tertiaryColor,
        neutralColor: neutralColor ?? this.neutralColor,
      );

  @override
  ThemeExtension<BasilTheme> lerp(
    covariant ThemeExtension<BasilTheme>? other,
    double t,
  ) {
    if (other is! BasilTheme) return this;
    return BasilTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }

  Scheme themeColor() {
    final base = CorePalette.of(primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(tertiaryColor.value).primary;
    final neutral = CorePalette.of(neutralColor.value).neutral;
    if (themeManager.themeMode == ThemeMode.light) {
      return Scheme(
        primary: primary.get(40),
        onPrimary: primary.get(100),
        primaryContainer: primary.get(90),
        onPrimaryContainer: primary.get(10),
        secondary: base.secondary.get(40),
        onSecondary: base.secondary.get(100),
        secondaryContainer: base.secondary.get(90),
        onSecondaryContainer: base.secondary.get(10),
        tertiary: tertiary.get(40),
        onTertiary: tertiary.get(100),
        tertiaryContainer: tertiary.get(90),
        onTertiaryContainer: tertiary.get(10),
        error: base.error.get(40),
        onError: base.error.get(100),
        errorContainer: base.error.get(90),
        onErrorContainer: base.error.get(10),
        background: neutral.get(99),
        onBackground: neutral.get(10),
        surface: neutral.get(99),
        onSurface: neutral.get(10),
        surfaceVariant: base.neutralVariant.get(90),
        onSurfaceVariant: base.neutralVariant.get(30),
        outline: base.neutralVariant.get(50),
        outlineVariant: base.neutralVariant.get(80),
        shadow: neutral.get(0),
        scrim: neutral.get(0),
        inverseSurface: neutral.get(20),
        inverseOnSurface: neutral.get(95),
        inversePrimary: primary.get(80),
      );
    } else {
      return Scheme(
        primary: primary.get(80),
        onPrimary: primary.get(20),
        primaryContainer: primary.get(30),
        onPrimaryContainer: primary.get(90),
        secondary: base.secondary.get(80),
        onSecondary: base.secondary.get(20),
        secondaryContainer: base.secondary.get(30),
        onSecondaryContainer: base.secondary.get(90),
        tertiary: tertiary.get(80),
        onTertiary: tertiary.get(20),
        tertiaryContainer: tertiary.get(30),
        onTertiaryContainer: tertiary.get(90),
        error: base.error.get(80),
        onError: base.error.get(20),
        errorContainer: base.error.get(30),
        onErrorContainer: base.error.get(90),
        background: neutral.get(10),
        onBackground: neutral.get(90),
        surface: neutral.get(10),
        onSurface: neutral.get(90),
        surfaceVariant: base.neutralVariant.get(30),
        onSurfaceVariant: base.neutralVariant.get(80),
        outline: base.neutralVariant.get(60),
        outlineVariant: base.neutralVariant.get(30),
        shadow: neutral.get(0),
        scrim: neutral.get(0),
        inverseSurface: neutral.get(20),
        inverseOnSurface: neutral.get(95),
        inversePrimary: primary.get(80),
      );
    }
  }
}

extension on Scheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: themeManager.themeMode == ThemeMode.dark
          ? Brightness.dark
          : Brightness.light,
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      primaryContainer: Color(primaryContainer),
      onPrimaryContainer: Color(onPrimaryContainer),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      secondaryContainer: Color(secondaryContainer),
      onSecondaryContainer: Color(onSecondaryContainer),
      tertiary: Color(tertiary),
      onTertiary: Color(onTertiary),
      tertiaryContainer: Color(tertiaryContainer),
      onTertiaryContainer: Color(onTertiaryContainer),
      error: Color(error),
      onError: Color(onError),
      errorContainer: Color(errorContainer),
      onErrorContainer: Color(onErrorContainer),
      background: Color(background),
      onBackground: Color(onBackground),
      surface: Color(surface),
      onSurface: Color(onSurface),
      surfaceVariant: Color(surfaceVariant),
      onSurfaceVariant: Color(onSurfaceVariant),
      outline: Color(outline),
      outlineVariant: Color(outlineVariant),
      shadow: Color(shadow),
      scrim: Color(scrim),
      inverseSurface: Color(inverseSurface),
      onInverseSurface: Color(inverseOnSurface),
      inversePrimary: Color(inversePrimary),
    );
  }
}
