// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa las herramientas de entrada y de las barras del sistema.
import 'package:flutter/services.dart';

/// Tipografía del sistema de diseño.
///
/// Poppins para títulos, etiquetas y botones; Inter para lectura y metadatos.
// Define la clase que reúne los estilos de texto.
class AppTextStyles {
  // Define cómo se crea AppTextStyles y qué datos recibe.
  const AppTextStyles._();

  // Prepara poppins.
  static const String poppins = 'Poppins';
  // Prepara inter.
  static const String inter = 'Inter';

  // Prepara titulo principal.
  static const TextStyle tituloPrincipal = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 30,
    // Establece la altura al valor indicado.
    height: 1.16,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w700,
    // Establece el espacio entre letras al valor indicado.
    letterSpacing: -0.5,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara marca.
  static const TextStyle marca = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 36,
    // Establece la altura al valor indicado.
    height: 1,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w700,
    // Establece el espacio entre letras al valor indicado.
    letterSpacing: -1,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara titulo pantalla.
  static const TextStyle tituloPantalla = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 23,
    // Establece la altura al valor indicado.
    height: 1.2,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w700,
    // Establece el espacio entre letras al valor indicado.
    letterSpacing: -0.3,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara titulo seccion.
  static const TextStyle tituloSeccion = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 19,
    // Establece la altura al valor indicado.
    height: 1.25,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w600,
    // Establece el espacio entre letras al valor indicado.
    letterSpacing: -0.2,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara titulo tarjeta.
  static const TextStyle tituloTarjeta = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 17,
    // Establece la altura al valor indicado.
    height: 1.3,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w600,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara cuerpo.
  static const TextStyle cuerpo = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: inter,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 15,
    // Establece la altura al valor indicado.
    height: 1.5,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w400,
    // Establece el color al valor indicado.
    color: AppColors.textoSecundario,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara cuerpo fuerte.
  static const TextStyle cuerpoFuerte = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: inter,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 15,
    // Establece la altura al valor indicado.
    height: 1.5,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w500,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara la etiqueta visible.
  static const TextStyle etiqueta = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: inter,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 12.5,
    // Establece la altura al valor indicado.
    height: 1.35,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w400,
    // Establece el color al valor indicado.
    color: AppColors.textoSecundario,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara etiqueta campo.
  static const TextStyle etiquetaCampo = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 15,
    // Establece la altura al valor indicado.
    height: 1.3,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w600,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara boton.
  static const TextStyle boton = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: poppins,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 15,
    // Establece la altura al valor indicado.
    height: 1.33,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w600,
    // Establece el color al valor indicado.
    color: Colors.white,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara chip.
  static const TextStyle chip = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: inter,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 14,
    // Establece la altura al valor indicado.
    height: 1.3,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w500,
    // Establece el color al valor indicado.
    color: AppColors.moradoOscuro,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );

  // Prepara chip estado.
  static const TextStyle chipEstado = TextStyle(
    // Establece la familia tipográfica al valor indicado.
    fontFamily: inter,
    // Establece el tamaño de la letra al valor indicado.
    fontSize: 13.5,
    // Establece la altura al valor indicado.
    height: 1.3,
    // Establece el grosor de la letra al valor indicado.
    fontWeight: FontWeight.w500,
    // Cierra la configuración de TextStyle y termina la instrucción.
  );
  // Cierra la clase AppTextStyles.
}

/// Tokens de forma y espaciado.
// Define la clase que reúne los radios de redondeado.
class AppRadii {
  // Define cómo se crea AppRadii y qué datos recibe.
  const AppRadii._();

  // Prepara campo.
  static const double campo = 12;
  // Prepara boton.
  static const double boton = 12;
  // Prepara tarjeta.
  static const double tarjeta = 16;
  // Prepara hoja.
  static const double hoja = 24;
  // Prepara pildora.
  static const double pildora = 999;
  // Cierra la clase AppRadii.
}

// Define la clase que reúne las medidas de separación.
class AppSpacing {
  // Define cómo se crea AppSpacing y qué datos recibe.
  const AppSpacing._();

  // Prepara margen.
  static const double margen = 20;
  // Prepara tarjeta.
  static const double tarjeta = 16;
  // Prepara seccion.
  static const double seccion = 24;
  // Prepara entre tarjetas.
  static const double entreTarjetas = 12;
  // Cierra la clase AppSpacing.
}

/// Tema claro de TutoPar.
// Define la clase que reúne el tema visual de la aplicación.
class AppTheme {
  // Define cómo se crea AppTheme y qué datos recibe.
  const AppTheme._();

  // Prepara esquema colores.
  static const ColorScheme _esquemaColores = ColorScheme.light(
    // Establece el color principal al valor indicado.
    primary: AppColors.morado,
    // Establece el texto sobre el color principal al valor indicado.
    onPrimary: Colors.white,
    // Establece el color secundario al valor indicado.
    secondary: AppColors.ambar,
    // Establece el texto sobre el color secundario al valor indicado.
    onSecondary: AppColors.ambarTexto,
    // Establece el color de las superficies al valor indicado.
    surface: AppColors.superficie,
    // Establece el texto sobre superficies al valor indicado.
    onSurface: AppColors.moradoOscuro,
    // Establece el error o su presentación al valor indicado.
    error: AppColors.rechazada,
    // Establece el texto sobre el color de error al valor indicado.
    onError: Colors.white,
    // Establece el color de los contornos al valor indicado.
    outline: AppColors.borde,
    // Cierra la configuración de light y termina la instrucción.
  );

  // Prepara tema texto.
  static const TextTheme _temaTexto = TextTheme(
    // Establece el estilo tipográfico de displayLarge al valor indicado.
    displayLarge: AppTextStyles.tituloPrincipal,
    // Establece el estilo tipográfico de displayMedium al valor indicado.
    displayMedium: AppTextStyles.tituloPrincipal,
    // Establece el estilo tipográfico de headlineLarge al valor indicado.
    headlineLarge: AppTextStyles.tituloPrincipal,
    // Establece el estilo tipográfico de headlineMedium al valor indicado.
    headlineMedium: AppTextStyles.tituloPantalla,
    // Establece el estilo tipográfico de headlineSmall al valor indicado.
    headlineSmall: AppTextStyles.tituloSeccion,
    // Establece el estilo tipográfico de titleLarge al valor indicado.
    titleLarge: AppTextStyles.tituloTarjeta,
    // Establece el estilo tipográfico de titleMedium al valor indicado.
    titleMedium: AppTextStyles.tituloTarjeta,
    // Establece el estilo tipográfico de titleSmall al valor indicado.
    titleSmall: AppTextStyles.etiquetaCampo,
    // Establece el estilo tipográfico de bodyLarge al valor indicado.
    bodyLarge: AppTextStyles.cuerpoFuerte,
    // Establece el estilo tipográfico de bodyMedium al valor indicado.
    bodyMedium: TextStyle(
      // Establece la familia tipográfica al valor indicado.
      fontFamily: AppTextStyles.inter,
      // Establece el tamaño de la letra al valor indicado.
      fontSize: 14,
      // Establece la altura al valor indicado.
      height: 1.45,
      // Establece el color al valor indicado.
      color: AppColors.textoSecundario,
      // Cierra la configuración de TextStyle.
    ),
    // Establece el estilo tipográfico de bodySmall al valor indicado.
    bodySmall: AppTextStyles.etiqueta,
    // Establece el estilo tipográfico de labelLarge al valor indicado.
    labelLarge: AppTextStyles.boton,
    // Establece el estilo tipográfico de labelMedium al valor indicado.
    labelMedium: AppTextStyles.chip,
    // Establece el estilo tipográfico de labelSmall al valor indicado.
    labelSmall: AppTextStyles.etiqueta,
    // Cierra la configuración de TextTheme y termina la instrucción.
  );

  // Permite consultar claro mediante una propiedad de lectura.
  static ThemeData get claro {
    // Prepara base sin permitir reasignarlo.
    final base = ThemeData(
      // Establece el uso del diseño Material 3 al valor indicado.
      useMaterial3: true,
      // Establece la paleta del tema al valor indicado.
      colorScheme: _esquemaColores,
      // Establece el fondo general de las pantallas al valor indicado.
      scaffoldBackgroundColor: AppColors.fondo,
      // Establece el conjunto de estilos tipográficos al valor indicado.
      textTheme: _temaTexto,
      // Establece el efecto visual al tocar al valor indicado.
      splashFactory: InkSparkle.splashFactory,
      // Cierra la configuración de ThemeData y termina la instrucción.
    );

    // Prepara borde campo.
    const bordeCampo = OutlineInputBorder(
      // Establece el redondeado de las esquinas al valor indicado.
      borderRadius: BorderRadius.all(Radius.circular(AppRadii.campo)),
      // Establece el color y grosor del borde al valor indicado.
      borderSide: BorderSide(color: AppColors.borde),
      // Cierra la configuración de OutlineInputBorder y termina la instrucción.
    );

    // Devuelve base.copyWith( como resultado de esta función.
    return base.copyWith(
      // Establece el estilo de las barras superiores al valor indicado.
      appBarTheme: const AppBarTheme(
        // Establece el color de fondo al valor indicado.
        backgroundColor: AppColors.superficie,
        // Establece el color del texto y los iconos al valor indicado.
        foregroundColor: AppColors.moradoOscuro,
        // Establece el tinte aplicado a la superficie al valor indicado.
        surfaceTintColor: Colors.transparent,
        // Establece la elevación visual y su sombra al valor indicado.
        elevation: 0,
        // Establece la elevación de la barra al desplazar el contenido al valor indicado.
        scrolledUnderElevation: 0,
        // Establece si se centra el título al valor indicado.
        centerTitle: false,
        // Establece la altura de la barra superior al valor indicado.
        toolbarHeight: 76,
        // Establece la separación del título de la barra al valor indicado.
        titleSpacing: AppSpacing.margen,
        // Establece el estilo del título de la barra al valor indicado.
        titleTextStyle: AppTextStyles.tituloPantalla,
        // Establece el estilo general de los iconos al valor indicado.
        iconTheme: IconThemeData(color: AppColors.moradoOscuro, size: 26),
        // Establece la forma del componente al valor indicado.
        shape: Border(bottom: BorderSide(color: AppColors.borde)),
        // Establece el aspecto de las barras del sistema al valor indicado.
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // Cierra la configuración de AppBarTheme.
      ),
      // Establece el estilo de los botones rellenos al valor indicado.
      filledButtonTheme: FilledButtonThemeData(
        // Establece el estilo visual al valor indicado.
        style: ButtonStyle(
          // Define el color de fondo mediante una función.
          backgroundColor: WidgetStateProperty.resolveWith((estados) {
            // Devuelve estados.contains(WidgetState.disabled) como resultado de esta función.
            return estados.contains(WidgetState.disabled)
                // Usa esta alternativa cuando la condición anterior es verdadera.
                ? AppColors.deshabilitado
                // Usa esta alternativa cuando la condición anterior es falsa.
                : AppColors.morado;
            // Cierra el bloque de resolveWith.
          }),
          // Establece el color del texto y los iconos al valor indicado.
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          // Establece el color que aparece al presionar al valor indicado.
          overlayColor: const WidgetStatePropertyAll(Color(0x1FFFFFFF)),
          // Establece la elevación visual y su sombra al valor indicado.
          elevation: const WidgetStatePropertyAll(0),
          // Establece el tamaño mínimo del botón al valor indicado.
          minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          // Establece la forma del componente al valor indicado.
          shape: const WidgetStatePropertyAll(
            // Utiliza RoundedRectangleBorder con los argumentos indicados.
            RoundedRectangleBorder(
              // Establece el redondeado de las esquinas al valor indicado.
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.boton)),
              // Cierra la configuración de RoundedRectangleBorder.
            ),
            // Cierra la configuración de WidgetStatePropertyAll.
          ),
          // Establece el estilo del texto del botón al valor indicado.
          textStyle: const WidgetStatePropertyAll(AppTextStyles.boton),
          // Cierra la configuración de ButtonStyle.
        ),
        // Cierra la configuración de FilledButtonThemeData.
      ),
      // Establece el estilo de los botones con borde al valor indicado.
      outlinedButtonTheme: OutlinedButtonThemeData(
        // Establece el estilo visual al valor indicado.
        style: ButtonStyle(
          // Establece el color del texto y los iconos al valor indicado.
          foregroundColor: const WidgetStatePropertyAll(AppColors.morado),
          // Establece el color de fondo al valor indicado.
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          // Establece el color que aparece al presionar al valor indicado.
          overlayColor: const WidgetStatePropertyAll(Color(0x125A2D82)),
          // Establece la elevación visual y su sombra al valor indicado.
          elevation: const WidgetStatePropertyAll(0),
          // Establece el tamaño mínimo del botón al valor indicado.
          minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          // Establece el borde de la forma o del botón al valor indicado.
          side: const WidgetStatePropertyAll(
            // Utiliza BorderSide con los argumentos indicados.
            BorderSide(color: AppColors.morado, width: 1.2),
            // Cierra la configuración de WidgetStatePropertyAll.
          ),
          // Establece la forma del componente al valor indicado.
          shape: const WidgetStatePropertyAll(
            // Utiliza RoundedRectangleBorder con los argumentos indicados.
            RoundedRectangleBorder(
              // Establece el redondeado de las esquinas al valor indicado.
              borderRadius: BorderRadius.all(Radius.circular(AppRadii.boton)),
              // Cierra la configuración de RoundedRectangleBorder.
            ),
            // Cierra la configuración de WidgetStatePropertyAll.
          ),
          // Establece el estilo del texto del botón al valor indicado.
          textStyle: const WidgetStatePropertyAll(
            // Utiliza TextStyle con los argumentos indicados.
            TextStyle(
              // Establece la familia tipográfica al valor indicado.
              fontFamily: AppTextStyles.poppins,
              // Establece el tamaño de la letra al valor indicado.
              fontSize: 15,
              // Establece el grosor de la letra al valor indicado.
              fontWeight: FontWeight.w600,
              // Establece el color al valor indicado.
              color: AppColors.morado,
              // Cierra la configuración de TextStyle.
            ),
            // Cierra la configuración de WidgetStatePropertyAll.
          ),
          // Cierra la configuración de ButtonStyle.
        ),
        // Cierra la configuración de OutlinedButtonThemeData.
      ),
      // Establece el estilo de los botones de texto al valor indicado.
      textButtonTheme: TextButtonThemeData(
        // Establece el estilo visual al valor indicado.
        style: ButtonStyle(
          // Establece el color del texto y los iconos al valor indicado.
          foregroundColor: const WidgetStatePropertyAll(AppColors.morado),
          // Establece el color que aparece al presionar al valor indicado.
          overlayColor: const WidgetStatePropertyAll(Color(0x125A2D82)),
          // Establece el estilo del texto del botón al valor indicado.
          textStyle: const WidgetStatePropertyAll(
            // Utiliza TextStyle con los argumentos indicados.
            TextStyle(
              // Establece la familia tipográfica al valor indicado.
              fontFamily: AppTextStyles.poppins,
              // Establece el tamaño de la letra al valor indicado.
              fontSize: 14,
              // Establece el grosor de la letra al valor indicado.
              fontWeight: FontWeight.w600,
              // Establece el color al valor indicado.
              color: AppColors.morado,
              // Cierra la configuración de TextStyle.
            ),
            // Cierra la configuración de WidgetStatePropertyAll.
          ),
          // Cierra la configuración de ButtonStyle.
        ),
        // Cierra la configuración de TextButtonThemeData.
      ),
      // Establece el estilo general de los campos al valor indicado.
      inputDecorationTheme: InputDecorationTheme(
        // Establece si el campo tiene fondo relleno al valor indicado.
        filled: true,
        // Establece el color de relleno del campo al valor indicado.
        fillColor: AppColors.superficie,
        // Establece el espacio interior del campo o aviso al valor indicado.
        contentPadding: const EdgeInsets.symmetric(
          // Establece el espacio horizontal al valor indicado.
          horizontal: AppSpacing.tarjeta,
          // Establece el espacio vertical al valor indicado.
          vertical: 14,
          // Cierra la configuración de symmetric.
        ),
        // Establece el estilo del texto de ejemplo al valor indicado.
        hintStyle: const TextStyle(
          // Establece la familia tipográfica al valor indicado.
          fontFamily: AppTextStyles.inter,
          // Establece el tamaño de la letra al valor indicado.
          fontSize: 15,
          // Establece el color al valor indicado.
          color: AppColors.textoSecundario,
          // Cierra la configuración de TextStyle.
        ),
        // Establece el borde al valor indicado.
        border: bordeCampo,
        // Establece el borde del campo habilitado al valor indicado.
        enabledBorder: bordeCampo,
        // Establece el borde del campo seleccionado al valor indicado.
        focusedBorder: bordeCampo.copyWith(
          // Establece el color y grosor del borde al valor indicado.
          borderSide: const BorderSide(color: AppColors.morado, width: 1.6),
          // Cierra la configuración de copyWith.
        ),
        // Establece el borde cuando hay un error al valor indicado.
        errorBorder: bordeCampo.copyWith(
          // Establece el color y grosor del borde al valor indicado.
          borderSide: const BorderSide(color: AppColors.rechazada, width: 1.4),
          // Cierra la configuración de copyWith.
        ),
        // Establece el borde del campo seleccionado con error al valor indicado.
        focusedErrorBorder: bordeCampo.copyWith(
          // Establece el color y grosor del borde al valor indicado.
          borderSide: const BorderSide(color: AppColors.rechazada, width: 1.6),
          // Cierra la configuración de copyWith.
        ),
        // Establece el estilo del mensaje de error al valor indicado.
        errorStyle: const TextStyle(
          // Establece la familia tipográfica al valor indicado.
          fontFamily: AppTextStyles.inter,
          // Establece el tamaño de la letra al valor indicado.
          fontSize: 12.5,
          // Establece el color al valor indicado.
          color: AppColors.rechazada,
          // Cierra la configuración de TextStyle.
        ),
        // Cierra la configuración de InputDecorationTheme.
      ),
      // Establece el estilo de los avisos flotantes al valor indicado.
      snackBarTheme: const SnackBarThemeData(
        // Establece la posición del aviso flotante al valor indicado.
        behavior: SnackBarBehavior.floating,
        // Establece el color de fondo al valor indicado.
        backgroundColor: AppColors.moradoOscuro,
        // Establece content text style al valor indicado.
        contentTextStyle: TextStyle(
          // Establece la familia tipográfica al valor indicado.
          fontFamily: AppTextStyles.inter,
          // Establece el tamaño de la letra al valor indicado.
          fontSize: 14,
          // Establece el grosor de la letra al valor indicado.
          fontWeight: FontWeight.w500,
          // Establece el color al valor indicado.
          color: Colors.white,
          // Cierra la configuración de TextStyle.
        ),
        // Establece la separación del aviso respecto a los bordes al valor indicado.
        insetPadding: EdgeInsets.symmetric(
          // Establece el espacio horizontal al valor indicado.
          horizontal: AppSpacing.margen,
          // Establece el espacio vertical al valor indicado.
          vertical: 16,
          // Cierra la configuración de symmetric.
        ),
        // Establece la forma del componente al valor indicado.
        shape: RoundedRectangleBorder(
          // Establece el redondeado de las esquinas al valor indicado.
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.campo)),
          // Cierra la configuración de RoundedRectangleBorder.
        ),
        // Cierra la configuración de SnackBarThemeData.
      ),
      // Establece el estilo de los separadores al valor indicado.
      dividerTheme: const DividerThemeData(
        // Establece el color al valor indicado.
        color: AppColors.borde,
        // Establece el grosor del separador al valor indicado.
        thickness: 1,
        // Establece el espacio del separador al valor indicado.
        space: 1,
        // Cierra la configuración de DividerThemeData.
      ),
      // Establece el estilo general de los iconos al valor indicado.
      iconTheme: const IconThemeData(color: AppColors.moradoOscuro),
      // Establece el estilo de los indicadores de carga al valor indicado.
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        // Establece el color al valor indicado.
        color: AppColors.morado,
        // Cierra la configuración de ProgressIndicatorThemeData.
      ),
      // Establece el estilo de los paneles inferiores al valor indicado.
      bottomSheetTheme: const BottomSheetThemeData(
        // Establece el color de fondo al valor indicado.
        backgroundColor: AppColors.superficie,
        // Establece el tinte aplicado a la superficie al valor indicado.
        surfaceTintColor: Colors.transparent,
        // Cierra la configuración de BottomSheetThemeData.
      ),
      // Cierra la configuración de copyWith y termina la instrucción.
    );
    // Cierra la propiedad claro.
  }

  // Cierra la clase AppTheme.
}

/// Paleta oficial de TutoPar.
///
/// Cada color corresponde a un token del archivo de Figma
/// (`Portada + Fundamentos`). No usar valores sueltos en las pantallas.
// Define la clase que reúne los colores de la aplicación.
class AppColors {
  // Define cómo se crea AppColors y qué datos recibe.
  const AppColors._();

  // Marca
  // Prepara morado.
  static const Color morado = Color(0xFF5A2D82);
  // Prepara morado oscuro.
  static const Color moradoOscuro = Color(0xFF3A1D56);
  // Prepara ambar.
  static const Color ambar = Color(0xFFF5B700);
  // Prepara azul.
  static const Color azul = Color(0xFF3B9DDB);

  // Estados
  // Prepara aceptada.
  static const Color aceptada = Color(0xFF1B8F5A);
  // Prepara aceptada tinte.
  static const Color aceptadaTinte = Color(0xFFDFF3E9);
  // Prepara aceptada texto.
  static const Color aceptadaTexto = Color(0xFF0E5F3B);

  // Prepara rechazada.
  static const Color rechazada = Color(0xFFC93C3C);
  // Prepara rechazada tinte.
  static const Color rechazadaTinte = Color(0xFFFBE4E4);
  // Prepara rechazada texto.
  static const Color rechazadaTexto = Color(0xFF8A2626);

  // Prepara pendiente tinte.
  static const Color pendienteTinte = Color(0xFFFFF3D1);
  // Prepara pendiente texto.
  static const Color pendienteTexto = Color(0xFF6B4A00);
  // Prepara ambar texto.
  static const Color ambarTexto = Color(0xFF6B4A00);

  // Superficies y texto
  // Prepara superficie.
  static const Color superficie = Color(0xFFFFFFFF);
  // Prepara el color de fondo elegido.
  static const Color fondo = Color(0xFFF6F4F9);
  // Prepara texto secundario.
  static const Color textoSecundario = Color(0xFF6E6678);
  // Prepara borde.
  static const Color borde = Color(0xFFE6E3EC);
  // Prepara deshabilitado.
  static const Color deshabilitado = Color(0xFFC9C3D3);

  // Tintes auxiliares
  // Prepara morado tinte.
  static const Color moradoTinte = Color(0xFFEFE7F7);
  // Prepara ambar tinte.
  static const Color ambarTinte = Color(0xFFFFF3D1);
  // Prepara resumen tinte.
  static const Color resumenTinte = Color(0xFFF1ECF7);
  // Prepara carga.
  static const Color carga = Color(0xFFE9E4F0);
  // Cierra la clase AppColors.
}
