import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Campo de texto con etiqueta visible, mensaje de ayuda/error y contador.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.etiqueta,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.errorTexto,
    this.helperTexto,
    this.contadorTexto,
    this.contadorAlLimite = false,
    this.enabled = true,
    this.resaltarError = false,
  });

  final String? etiqueta;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? errorTexto;
  final String? helperTexto;
  final String? contadorTexto;
  final bool contadorAlLimite;
  final bool enabled;
  final bool resaltarError;

  @override
  Widget build(BuildContext context) {
    final conError = resaltarError || errorTexto != null;
    final mensajeInferior = errorTexto ?? helperTexto;
    final tieneFilaInferior = mensajeInferior != null || contadorTexto != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (etiqueta != null) ...[
          Text(etiqueta!, style: AppTextStyles.etiquetaCampo),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          minLines: obscureText ? 1 : minLines,
          maxLines: obscureText ? 1 : maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          enabled: enabled,
          style: const TextStyle(
            fontFamily: AppTextStyles.inter,
            fontSize: 15,
            height: 1.4,
            color: AppColors.moradoOscuro,
          ),
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: conError
                ? const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadii.campo),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.rechazada,
                      width: 1.4,
                    ),
                  )
                : null,
            focusedBorder: conError
                ? const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadii.campo),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.rechazada,
                      width: 1.6,
                    ),
                  )
                : null,
          ),
        ),
        if (tieneFilaInferior) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  mensajeInferior ?? '',
                  style: AppTextStyles.etiqueta.copyWith(
                    color: errorTexto != null
                        ? AppColors.rechazada
                        : AppColors.textoSecundario,
                  ),
                ),
              ),
              if (contadorTexto != null)
                Text(
                  contadorTexto!,
                  style: AppTextStyles.etiqueta.copyWith(
                    color: contadorAlLimite
                        ? AppColors.rechazada
                        : AppColors.textoSecundario,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
