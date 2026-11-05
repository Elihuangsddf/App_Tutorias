import 'package:flutter/material.dart';

/// Paleta oficial de TutoPar.
///
/// Cada color corresponde a un token del archivo de Figma
/// (`Portada + Fundamentos`). No usar valores sueltos en las pantallas.
class AppColors {
  const AppColors._();

  // Marca
  static const Color morado = Color(0xFF5A2D82);
  static const Color moradoOscuro = Color(0xFF3A1D56);
  static const Color ambar = Color(0xFFF5B700);
  static const Color azul = Color(0xFF3B9DDB);

  // Estados
  static const Color aceptada = Color(0xFF1B8F5A);
  static const Color aceptadaTinte = Color(0xFFDFF3E9);
  static const Color aceptadaTexto = Color(0xFF0E5F3B);

  static const Color rechazada = Color(0xFFC93C3C);
  static const Color rechazadaTinte = Color(0xFFFBE4E4);
  static const Color rechazadaTexto = Color(0xFF8A2626);

  static const Color pendienteTinte = Color(0xFFFFF3D1);
  static const Color pendienteTexto = Color(0xFF6B4A00);
  static const Color ambarTexto = Color(0xFF6B4A00);

  // Superficies y texto
  static const Color superficie = Color(0xFFFFFFFF);
  static const Color fondo = Color(0xFFF6F4F9);
  static const Color textoSecundario = Color(0xFF6E6678);
  static const Color borde = Color(0xFFE6E3EC);
  static const Color deshabilitado = Color(0xFFC9C3D3);

  // Tintes auxiliares
  static const Color moradoTinte = Color(0xFFEFE7F7);
  static const Color ambarTinte = Color(0xFFFFF3D1);
  static const Color resumenTinte = Color(0xFFF1ECF7);
  static const Color skeleton = Color(0xFFE9E4F0);
}
