import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/feedback.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/tutopar_logo.dart';
import '../../models/rol.dart';
import '../../providers/sesion_provider.dart';

/// Login simulado de la Etapa 1.
///
/// Los campos son decorativos: no validan credenciales. El botón inicia la
/// sesión con el usuario de ejemplo del rol elegido.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.rol});

  final Rol rol;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _entrar() async {
    final sesion = context.read<SesionProvider>();
    final exito = await sesion.iniciarSesion(widget.rol);

    if (!mounted) return;

    if (!exito) {
      mostrarAviso(
        context,
        sesion.error ?? 'No se pudo iniciar sesión. Intenta de nuevo.',
        error: true,
      );
      return;
    }

    final destino = widget.rol == Rol.alumno
        ? AppRoutes.catalogo
        : AppRoutes.panelSolicitudes;

    Navigator.of(context).pushReplacementNamed(destino);
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProvider>();
    final esAlumno = widget.rol == Rol.alumno;
    final colorBanner = esAlumno ? AppColors.moradoTinte : AppColors.ambarTinte;
    final colorTextoBanner = esAlumno
        ? AppColors.morado
        : AppColors.pendienteTexto;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: TutoParBrand(size: 44, fontSize: 22),
                      ),
                      const SizedBox(height: 72),
                      Text(
                        'Bienvenido de nuevo',
                        style: AppTextStyles.display.copyWith(fontSize: 29),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Inicia sesión para continuar',
                        style: AppTextStyles.cuerpo.copyWith(fontSize: 15.5),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: colorBanner,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Acceso como ${widget.rol.etiqueta}',
                          style: TextStyle(
                            fontFamily: AppTextStyles.inter,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w500,
                            color: colorTextoBanner,
                          ),
                        ),
                      ),
                      const SizedBox(height: 38),
                      const AppTextField(
                        etiqueta: 'Correo institucional',
                        hint: 'nombre@universidad.edu',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      const AppTextField(
                        etiqueta: 'Contraseña',
                        hint: '••••••••',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => mostrarAviso(
                            context,
                            'El acceso es simulado en esta etapa.',
                          ),
                          child: const Text('¿Olvidaste tu contraseña?'),
                        ),
                      ),
                      const SizedBox(height: 6),
                      PrimaryButton(
                        label: 'Iniciar sesión',
                        cargando: sesion.cargando,
                        onPressed: _entrar,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        '¿No tienes una cuenta? Contacta a tu institución',
                        style: AppTextStyles.etiqueta,
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_rounded, size: 18),
                          label: const Text('Cambiar de rol'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'MVP local · Acceso simulado',
                          style: AppTextStyles.etiqueta.copyWith(
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
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
