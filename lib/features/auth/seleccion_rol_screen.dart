import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/role_card.dart';
import '../../core/widgets/tutopar_logo.dart';
import '../../models/rol.dart';

/// Selección de rol: entrada al login simulado de alumno o tutor.
class SeleccionRolScreen extends StatelessWidget {
  const SeleccionRolScreen({super.key});

  void _elegirRol(BuildContext context, Rol rol) {
    Navigator.of(context).pushNamed(AppRoutes.login, arguments: rol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TutoParWordmark(fontSize: 30),
                        const SizedBox(height: 80),
                        Text(
                          '¿Cómo quieres entrar?',
                          style: AppTextStyles.display.copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Elige tu rol para continuar. El inicio de sesión '
                          'es simulado en esta etapa.',
                          style: AppTextStyles.cuerpo.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 50),
                        RoleCard(
                          titulo: 'Alumno',
                          descripcion: 'Busca tutores y solicita asesorías',
                          icono: Icons.person_outline_rounded,
                          colorIcono: AppColors.morado,
                          colorFondoIcono: AppColors.moradoTinte,
                          onTap: () => _elegirRol(context, Rol.alumno),
                        ),
                        const SizedBox(height: 16),
                        RoleCard(
                          titulo: 'Tutor',
                          descripcion:
                              'Revisa y responde las solicitudes recibidas',
                          icono: Icons.people_alt_outlined,
                          colorIcono: AppColors.pendienteTexto,
                          colorFondoIcono: AppColors.ambarTinte,
                          onTap: () => _elegirRol(context, Rol.tutor),
                        ),
                        const Spacer(),
                        const SizedBox(height: 40),
                        Center(
                          child: Text(
                            'TutoPar · Etapa 1 (MVP local)',
                            style: AppTextStyles.etiqueta,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
