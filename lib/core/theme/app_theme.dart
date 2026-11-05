import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

/// Tipografía del sistema de diseño.
///
/// Poppins para títulos, etiquetas y botones; Inter para lectura y metadatos.
class AppTextStyles {
  const AppTextStyles._();

  static const String poppins = 'Poppins';
  static const String inter = 'Inter';

  static const TextStyle display = TextStyle(
    fontFamily: poppins,
    fontSize: 30,
    height: 1.16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle marca = TextStyle(
    fontFamily: poppins,
    fontSize: 36,
    height: 1,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
  );

  static const TextStyle tituloPantalla = TextStyle(
    fontFamily: poppins,
    fontSize: 23,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle tituloSeccion = TextStyle(
    fontFamily: poppins,
    fontSize: 19,
    height: 1.25,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle tituloTarjeta = TextStyle(
    fontFamily: poppins,
    fontSize: 17,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle cuerpo = TextStyle(
    fontFamily: inter,
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textoSecundario,
  );

  static const TextStyle cuerpoFuerte = TextStyle(
    fontFamily: inter,
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle etiqueta = TextStyle(
    fontFamily: inter,
    fontSize: 12.5,
    height: 1.35,
    fontWeight: FontWeight.w400,
    color: AppColors.textoSecundario,
  );

  static const TextStyle etiquetaCampo = TextStyle(
    fontFamily: poppins,
    fontSize: 15,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle boton = TextStyle(
    fontFamily: poppins,
    fontSize: 15,
    height: 1.33,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle chip = TextStyle(
    fontFamily: inter,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w500,
    color: AppColors.moradoOscuro,
  );

  static const TextStyle chipEstado = TextStyle(
    fontFamily: inter,
    fontSize: 13.5,
    height: 1.3,
    fontWeight: FontWeight.w500,
  );
}

/// Tokens de forma y espaciado.
class AppRadii {
  const AppRadii._();

  static const double campo = 12;
  static const double boton = 12;
  static const double tarjeta = 16;
  static const double hoja = 24;
  static const double pill = 999;
}

class AppSpacing {
  const AppSpacing._();

  static const double margen = 20;
  static const double tarjeta = 16;
  static const double seccion = 24;
  static const double entreTarjetas = 12;
}

/// Tema claro de TutoPar.
class AppTheme {
  const AppTheme._();

  static const ColorScheme _scheme = ColorScheme.light(
    primary: AppColors.morado,
    onPrimary: Colors.white,
    secondary: AppColors.ambar,
    onSecondary: AppColors.ambarTexto,
    surface: AppColors.superficie,
    onSurface: AppColors.moradoOscuro,
    error: AppColors.rechazada,
    onError: Colors.white,
    outline: AppColors.borde,
  );

  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppTextStyles.display,
    displayMedium: AppTextStyles.display,
    headlineLarge: AppTextStyles.display,
    headlineMedium: AppTextStyles.tituloPantalla,
    headlineSmall: AppTextStyles.tituloSeccion,
    titleLarge: AppTextStyles.tituloTarjeta,
    titleMedium: AppTextStyles.tituloTarjeta,
    titleSmall: AppTextStyles.etiquetaCampo,
    bodyLarge: AppTextStyles.cuerpoFuerte,
    bodyMedium: TextStyle(
      fontFamily: AppTextStyles.inter,
      fontSize: 14,
      height: 1.45,
      color: AppColors.textoSecundario,
    ),
    bodySmall: AppTextStyles.etiqueta,
    labelLarge: AppTextStyles.boton,
    labelMedium: AppTextStyles.chip,
    labelSmall: AppTextStyles.etiqueta,
  );

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: _scheme,
      scaffoldBackgroundColor: AppColors.fondo,
      textTheme: _textTheme,
      splashFactory: InkSparkle.splashFactory,
    );

    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadii.campo)),
      borderSide: BorderSide(color: AppColors.borde),
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.superficie,
        foregroundColor: AppColors.moradoOscuro,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 76,
        titleSpacing: AppSpacing.margen,
        titleTextStyle: AppTextStyles.tituloPantalla,
        iconTheme: IconThemeData(color: AppColors.moradoOscuro, size: 26),
        shape: Border(bottom: BorderSide(color: AppColors.borde)),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.deshabilitado
                : AppColors.morado,
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          overlayColor: const WidgetStatePropertyAll(Color(0x1FFFFFFF)),
          elevation: const WidgetStatePropertyAll(0),
          minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.boton)),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(AppTextStyles.boton),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.morado),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          overlayColor: const WidgetStatePropertyAll(Color(0x125A2D82)),
          elevation: const WidgetStatePropertyAll(0),
          minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColors.morado, width: 1.2),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.boton)),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: AppTextStyles.poppins,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.morado,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.morado),
          overlayColor: const WidgetStatePropertyAll(Color(0x125A2D82)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: AppTextStyles.poppins,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.morado,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.superficie,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tarjeta,
          vertical: 14,
        ),
        hintStyle: const TextStyle(
          fontFamily: AppTextStyles.inter,
          fontSize: 15,
          color: AppColors.textoSecundario,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.morado, width: 1.6),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.rechazada, width: 1.4),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.rechazada, width: 1.6),
        ),
        errorStyle: const TextStyle(
          fontFamily: AppTextStyles.inter,
          fontSize: 12.5,
          color: AppColors.rechazada,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.moradoOscuro,
        contentTextStyle: TextStyle(
          fontFamily: AppTextStyles.inter,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.margen,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.campo)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borde,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: AppColors.moradoOscuro),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.morado,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.superficie,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
