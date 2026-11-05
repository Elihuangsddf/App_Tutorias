import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/constants.dart';
import '../../core/widgets/tutopar_logo.dart';

/// Pantalla de bienvenida.
///
/// Mantiene la marca durante 1.5 s y navega a la selección de rol.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _irASeleccionDeRol();
  }

  Future<void> _irASeleccionDeRol() async {
    await Future<void>.delayed(AppConstants.duracionSplash);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.seleccionRol);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.morado,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 56),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TutoParMark(
                          size: 112,
                          backgroundColor: AppColors.superficie,
                          leftColor: AppColors.morado,
                          rightColor: AppColors.ambar,
                        ),
                        const SizedBox(height: 34),
                        Text(
                          AppConstants.nombreApp,
                          style: AppTextStyles.marca.copyWith(
                            fontSize: 38,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppConstants.descripcionApp,
                          style: const TextStyle(
                            fontFamily: AppTextStyles.inter,
                            fontSize: 16,
                            color: Color(0xD9FFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 56),
                child: Column(
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xB3FFFFFF),
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Etapa 1 · MVP local',
                      style: TextStyle(
                        fontFamily: AppTextStyles.inter,
                        fontSize: 13,
                        color: Color(0x99FFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
