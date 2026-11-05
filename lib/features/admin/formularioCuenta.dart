// Formulario compartido para crear y modificar alumnos y tutores.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tutorias/models/modeloUsuario.dart';
import 'package:app_tutorias/models/modeloTutor.dart';
import 'package:app_tutorias/providers/controladorSesion.dart';
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';

// Devuelve true cuando se guardaron los cambios.
Future<bool?> abrirFormularioCuenta(BuildContext contexto, {Usuario? cuenta}) {
  return showDialog<bool>(
    context: contexto,
    builder: (_) => FormularioCuenta(cuenta: cuenta),
  );
}

class FormularioCuenta extends StatefulWidget {
  const FormularioCuenta({super.key, this.cuenta});
  final Usuario? cuenta;
  @override
  State<FormularioCuenta> createState() => _FormularioCuentaState();
}

class _FormularioCuentaState extends State<FormularioCuenta> {
  // Valida todos los campos antes de escribir en el repositorio.
  final claveFormulario = GlobalKey<FormState>();
  final nombre = TextEditingController();
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  final materias = TextEditingController();
  final horarios = TextEditingController();
  final descripcion = TextEditingController();
  Rol rol = Rol.alumno;
  double puntuacion = 0;
  bool guardando = false;
  String? error;

  @override
  void initState() {
    super.initState();
    // Precarga los datos existentes conservando la contraseña privada.
    final cuenta = widget.cuenta;
    final perfil = cuenta == null
        ? null
        : context.read<SesionProvider>().perfilTutor(cuenta.id);
    nombre.text = cuenta?.nombre ?? '';
    correo.text = cuenta?.correo ?? '';
    rol = cuenta?.rol ?? Rol.alumno;
    materias.text = perfil?.materias.join(', ') ?? '';
    horarios.text = perfil?.horariosDisponibles.join('; ') ?? '';
    descripcion.text = perfil?.descripcion ?? '';
    puntuacion = perfil?.calificacion ?? 0;
  }

  @override
  void dispose() {
    // Libera los controladores al cerrar el formulario.
    for (final controlador in [
      nombre,
      correo,
      contrasena,
      materias,
      horarios,
      descripcion,
    ]) {
      controlador.dispose();
    }
    super.dispose();
  }

  // Limpia espacios y duplicados; borrar texto elimina una materia o un horario.
  List<String> separar(String texto, String separador) => texto
      .split(separador)
      .map((valor) => valor.trim())
      .where((valor) => valor.isNotEmpty)
      .toSet()
      .toList();

  Future<void> guardar() async {
    if (guardando || !claveFormulario.currentState!.validate()) {
      return;
    }
    setState(() {
      guardando = true;
      error = null;
    });
    try {
      // Usa identificadores diferentes a los del registro público.
      final id =
          widget.cuenta?.id ?? 'admin-${DateTime.now().microsecondsSinceEpoch}';
      final usuario = Usuario(
        id: id,
        nombre: nombre.text.trim(),
        correo: correo.text.trim(),
        rol: rol,
      );
      final perfil = rol == Rol.tutor
          ? Tutor(
              id: id,
              nombre: usuario.nombre,
              materias: separar(materias.text, ','),
              calificacion: puntuacion,
              horariosDisponibles: separar(horarios.text, ';'),
              descripcion: descripcion.text.trim(),
              foto: context.read<SesionProvider>().perfilTutor(id)?.foto ?? '',
            )
          : null;
      await context.read<SesionProvider>().guardarCuenta(
        usuario,
        contrasena.text,
        perfil,
      );
      if (mounted) {
        Navigator.pop(context, true);
      }
    } on ErrorAutenticacion catch (fallo) {
      if (mounted) {
        setState(() {
          error = fallo.mensaje;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          error = 'No se pudo guardar la cuenta.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  // Reutiliza el formato y las validaciones básicas de cada campo.
  Widget campo(
    String etiqueta,
    TextEditingController controlador, {
    bool obligatorio = true,
    bool secreto = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controlador,
        enabled: !guardando,
        obscureText: secreto,
        decoration: InputDecoration(labelText: etiqueta),
        validator: (valor) => obligatorio && (valor ?? '').trim().isEmpty
            ? 'Completa este campo.'
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext contexto) {
    return AlertDialog(
      title: Text(widget.cuenta == null ? 'Crear cuenta' : 'Modificar cuenta'),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Form(
            key: claveFormulario,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                campo('Nombre completo', nombre),
                campo('Correo electrónico', correo),
                campo(
                  widget.cuenta == null
                      ? 'Contraseña (mínimo 8 caracteres)'
                      : 'Nueva contraseña (vacío conserva la actual)',
                  contrasena,
                  obligatorio: widget.cuenta == null,
                  secreto: true,
                ),
                // El rol se elige al crear; editar conserva la relación con las solicitudes.
                DropdownButtonFormField<Rol>(
                  initialValue: rol,
                  decoration: const InputDecoration(labelText: 'Rol'),
                  items: [
                    for (final opcion in [Rol.alumno, Rol.tutor])
                      DropdownMenuItem(
                        value: opcion,
                        child: Text(opcion.etiqueta),
                      ),
                  ],
                  onChanged: guardando || widget.cuenta != null
                      ? null
                      : (valor) => setState(() {
                          rol = valor!;
                        }),
                ),
                if (rol == Rol.tutor) ...[
                  const SizedBox(height: 16),
                  campo('Materias (separadas por comas)', materias),
                  campo('Horarios (separados por ;)', horarios),
                  campo('Descripción', descripcion, obligatorio: false),
                  Text('Puntuación: ${puntuacion.toStringAsFixed(1)} de 5'),
                  // Una puntuación decimal se representa mediante estrellas completas y medias.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var indice = 1; indice <= 5; indice++)
                        Icon(
                          indice <= puntuacion
                              ? Icons.star
                              : indice - 0.5 <= puntuacion
                              ? Icons.star_half
                              : Icons.star_border,
                          color: Colors.amber,
                        ),
                    ],
                  ),
                  Slider(
                    value: puntuacion,
                    min: 0,
                    max: 5,
                    divisions: 50,
                    label: puntuacion.toStringAsFixed(1),
                    onChanged: guardando
                        ? null
                        : (valor) => setState(() {
                            puntuacion = valor;
                          }),
                  ),
                ],
                if (error != null)
                  Text(error!, style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: guardando ? null : () => Navigator.pop(contexto, false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: guardando ? null : guardar,
          child: Text(guardando ? 'Guardando...' : 'Guardar'),
        ),
      ],
    );
  }
}
