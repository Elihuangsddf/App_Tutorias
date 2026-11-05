// Importa package:flutter/material.dart para utilizar sus componentes y clases.
import 'package:flutter/material.dart';
// Importa package:provider/provider.dart para utilizar sus componentes y clases.
import 'package:provider/provider.dart';
// Importa botonesAplicacion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/widgets/botonesAplicacion.dart';
// Importa campoTexto.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/widgets/campoTexto.dart';
// Importa controladorSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa logotipoTutopar.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/widgets/logotipoTutopar.dart';
// Importa modeloUsuario.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa rutasAplicacion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';
// Importa temaAplicacion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

// Define LoginScreen y los datos o acciones que contiene.
class LoginScreen extends StatefulWidget {
  // Crea el formulario de inicio de sesión y registro con los valores indicados.
  const LoginScreen({super.key});

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Crea el estado que conservará el formulario.
  State<LoginScreen> createState() {
    // Devuelve _LoginScreenState() como resultado de la función.
    return _LoginScreenState();
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}

// Define _LoginScreenState y los datos o acciones que contiene.
class _LoginScreenState extends State<LoginScreen> {
  // Prepara el texto del nombre completo.
  final TextEditingController _controladorNombre = TextEditingController();
  // Prepara el texto del correo electrónico.
  final TextEditingController _controladorCorreo = TextEditingController();
  // Prepara el texto de la contraseña.
  final TextEditingController _controladorContrasena = TextEditingController();
  // Prepara el texto de confirmación de contraseña.
  final TextEditingController _controladorConfirmacion =
      // Crea el objeto o la llamada TextEditingController.
      TextEditingController();
  // Prepara si se muestra el formulario de registro.
  // Conserva los datos académicos del registro de tutor.
  final _controladorMaterias = TextEditingController();
  final _controladorHorarios = TextEditingController();
  bool _registrando = false;
  // Prepara el rol elegido para crear la cuenta.
  Rol _rolRegistro = Rol.alumno;
  // Guarda el error de confirmación de contraseña.
  String? _errorConfirmacion;

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Libera los controladores de texto al cerrar la pantalla.
  void dispose() {
    // Libera el controlador de texto y sus recursos.
    _controladorNombre.dispose();
    // Libera el controlador de texto y sus recursos.
    _controladorCorreo.dispose();
    // Libera el controlador de texto y sus recursos.
    _controladorContrasena.dispose();
    // Libera el controlador de texto y sus recursos.
    _controladorConfirmacion.dispose();
    // Completa la liberación del estado de Flutter.
    _controladorMaterias.dispose();
    _controladorHorarios.dispose();
    super.dispose();
    // Cierra el bloque de instrucciones o la definición.
  }

  // Alterna entre inicio de sesión y registro y limpia las contraseñas.
  void _cambiarFormulario() {
    // Prepara el controlador de la sesión.
    final sesion = context.read<SesionProvider>();
    // Evita iniciar otra operación mientras la anterior sigue en curso.
    if (sesion.cargando) {
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Completa la operación utilizando sesion.limpiarError().
    sesion.limpiarError();
    // Actualiza los datos locales y solicita redibujar el formulario.
    setState(() {
      // Actualiza si se muestra el formulario de registro con el valor indicado.
      _registrando = !_registrando;
      // Actualiza el error de confirmación de contraseña con el valor indicado.
      _errorConfirmacion = null;
      // Vacía el campo de texto para no conservar la contraseña anterior.
      _controladorContrasena.clear();
      // Vacía el campo de texto para no conservar la contraseña anterior.
      _controladorConfirmacion.clear();
      // Cierra el bloque de instrucciones o la definición.
    });
    // Cierra el bloque de instrucciones o la definición.
  }

  // Envía las credenciales o registra la cuenta y abre la ruta que corresponde a su rol.
  Future<void> _enviar() async {
    // Prepara el controlador de la sesión.
    final sesion = context.read<SesionProvider>();
    // Evita iniciar otra operación mientras la anterior sigue en curso.
    if (sesion.cargando) {
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Quita el foco del campo de texto para cerrar el teclado.
    FocusScope.of(context).unfocus();
    // Completa la operación utilizando sesion.limpiarError().
    sesion.limpiarError();
    // Actualiza los datos locales y solicita redibujar el formulario.
    setState(() {
      // Actualiza el error de confirmación de contraseña con el valor indicado.
      _errorConfirmacion = null;
      // Cierra el bloque de instrucciones o la definición.
    });
    // Guarda si la operación se completó correctamente.
    bool exito;
    // Utiliza el formulario de creación de cuenta en lugar del inicio de sesión.
    if (_registrando) {
      // Comprueba (_controladorContrasena.text != _controladorConfirmacion.text) antes de ejecutar el bloque.
      if (_controladorContrasena.text != _controladorConfirmacion.text) {
        // Actualiza los datos locales y solicita redibujar el formulario.
        setState(() {
          // Actualiza el error de confirmación de contraseña con el valor indicado.
          _errorConfirmacion = 'Las contraseñas no coinciden.';
          // Cierra el bloque de instrucciones o la definición.
        });
        // Termina la función sin ejecutar las instrucciones siguientes.
        return;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Actualiza si la operación se completó correctamente con el valor indicado.
      exito = await sesion.registrar(
        // Configura el nombre del usuario.
        nombre: _controladorNombre.text,
        // Configura el correo electrónico.
        correo: _controladorCorreo.text,
        // Configura la contraseña que se comprobará en la demostración.
        contrasena: _controladorContrasena.text,
        // Configura el rol guardado en la cuenta.
        rol: _rolRegistro,
        // Limpia y elimina duplicados antes de guardar los datos.
        materias: _controladorMaterias.text
            .split(',')
            .map((valor) => valor.trim())
            .where((valor) => valor.isNotEmpty)
            .toSet()
            .toList(),
        horarios: _controladorHorarios.text
            .split(';')
            .map((valor) => valor.trim())
            .where((valor) => valor.isNotEmpty)
            .toSet()
            .toList(),
        // Cierra los argumentos de la operación actual.
      );
      // Ejecuta esta alternativa cuando la condición anterior no se cumplió.
    } else {
      // Actualiza si la operación se completó correctamente con el valor indicado.
      exito = await sesion.iniciarSesion(
        // Completa la operación utilizando _controladorCorreo.text.
        _controladorCorreo.text,
        // Completa la operación utilizando _controladorContrasena.text.
        _controladorContrasena.text,
        // Cierra los argumentos de la operación actual.
      );
      // Cierra el bloque de instrucciones o la definición.
    }
    // Evita navegar o actualizar una pantalla que ya fue eliminada.
    if (!mounted || !exito) {
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Prepara la ruta inicial correspondiente al rol autenticado.
    final destino = AppRoutes.inicioPorRol(sesion.rol!);
    // Abre el destino elegido y actualiza el historial de navegación.
    Navigator.of(context).pushNamedAndRemoveUntil(destino, (ruta) {
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Cierra el bloque de instrucciones o la definición.
    });
    // Cierra el bloque de instrucciones o la definición.
  }

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Construye el contenido visual de esta pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el controlador de la sesión.
    final sesion = contexto.watch<SesionProvider>();
    // Prepara el título del formulario.
    String titulo = 'Bienvenido de nuevo';
    // Prepara el texto del botón principal.
    String textoBoton = 'Iniciar sesión';
    // Utiliza el formulario de creación de cuenta en lugar del inicio de sesión.
    if (_registrando) {
      // Actualiza el título del formulario con el valor indicado.
      titulo = 'Crear cuenta';
      // Actualiza el texto del botón principal con el valor indicado.
      textoBoton = 'Registrarme';
      // Cierra el bloque de instrucciones o la definición.
    }
    // Devuelve la estructura de la pantalla con la configuración siguiente.
    return Scaffold(
      // Configura el contenido principal.
      body: SafeArea(
        // Configura el contenido visual del componente.
        child: Center(
          // Configura el contenido visual del componente.
          child: SingleChildScrollView(
            // Configura el espacio alrededor del contenido.
            padding: const EdgeInsets.all(20),
            // Configura el contenido visual del componente.
            child: ConstrainedBox(
              // Configura los límites del tamaño del formulario.
              constraints: const BoxConstraints(maxWidth: 460),
              // Configura el contenido visual del componente.
              child: Column(
                // Configura la alineación transversal de los elementos.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // Configura la lista de componentes hijos.
                children: [
                  // Crea el nombre y símbolo de la aplicación con los valores indicados.
                  const TutoParBrand(tamano: 44, tamanoFuente: 22),
                  // Crea un espacio de tamaño fijo con los valores indicados.
                  const SizedBox(height: 32),
                  // Crea un texto visible.
                  Text(titulo, style: AppTextStyles.tituloPrincipal),
                  // Crea un espacio de tamaño fijo con los valores indicados.
                  const SizedBox(height: 8),
                  // Crea un texto visible con los valores indicados.
                  const Text('Ingresa con tu cuenta. Tu rol define el acceso.'),
                  // Crea un espacio de tamaño fijo con los valores indicados.
                  const SizedBox(height: 24),
                  // Comprueba (_registrando) ...[ antes de ejecutar el bloque.
                  if (_registrando) ...[
                    // Crea un campo de texto con etiqueta.
                    AppTextField(
                      // Configura la etiqueta del campo.
                      etiqueta: 'Nombre completo',
                      // Configura el controlador que guarda el texto del campo.
                      controlador: _controladorNombre,
                      // Configura si el campo se puede editar.
                      habilitado: !sesion.cargando,
                      // Configura la acción del teclado.
                      accionTeclado: TextInputAction.next,
                      // Cierra los argumentos de la operación actual.
                    ),
                    // Crea un espacio de tamaño fijo con los valores indicados.
                    const SizedBox(height: 16),
                    // Cierra la lista de elementos.
                  ],
                  // Crea un campo de texto con etiqueta.
                  AppTextField(
                    // Configura la etiqueta del campo.
                    etiqueta: 'Correo electrónico',
                    // Configura el ejemplo del campo vacío.
                    textoEjemplo: 'nombre@universidad.edu',
                    // Configura el controlador que guarda el texto del campo.
                    controlador: _controladorCorreo,
                    // Configura si el campo se puede editar.
                    habilitado: !sesion.cargando,
                    // Configura el tipo de teclado.
                    tipoTeclado: TextInputType.emailAddress,
                    // Configura la acción del teclado.
                    accionTeclado: TextInputAction.next,
                    // Cierra los argumentos de la operación actual.
                  ),
                  // Crea un espacio de tamaño fijo con los valores indicados.
                  const SizedBox(height: 16),
                  // Crea un campo de texto con etiqueta.
                  AppTextField(
                    // Configura la etiqueta del campo.
                    etiqueta: 'Contraseña',
                    // Configura el controlador que guarda el texto del campo.
                    controlador: _controladorContrasena,
                    // Configura si el campo se puede editar.
                    habilitado: !sesion.cargando,
                    // Configura si se ocultan los caracteres de la contraseña.
                    ocultarTexto: true,
                    // Cierra los argumentos de la operación actual.
                  ),
                  // Comprueba (_registrando) ...[ antes de ejecutar el bloque.
                  if (_registrando) ...[
                    // Crea un espacio de tamaño fijo con los valores indicados.
                    const SizedBox(height: 16),
                    // Crea un campo de texto con etiqueta.
                    AppTextField(
                      // Configura la etiqueta del campo.
                      etiqueta: 'Confirmar contraseña',
                      // Configura el controlador que guarda el texto del campo.
                      controlador: _controladorConfirmacion,
                      // Configura si el campo se puede editar.
                      habilitado: !sesion.cargando,
                      // Configura si se ocultan los caracteres de la contraseña.
                      ocultarTexto: true,
                      // Configura el error mostrado debajo del campo.
                      errorTexto: _errorConfirmacion,
                      // Cierra los argumentos de la operación actual.
                    ),
                    // Crea un espacio de tamaño fijo con los valores indicados.
                    const SizedBox(height: 16),
                    // Crea el selector del rol de registro.
                    DropdownButtonFormField<Rol>(
                      // Configura el valor inicial del selector.
                      initialValue: _rolRegistro,
                      // Configura la etiqueta o decoración del campo.
                      decoration: const InputDecoration(
                        // Configura label text.
                        labelText: 'Quiero registrarme como',
                        // Cierra los argumentos de la operación actual.
                      ),
                      // Configura las opciones permitidas en el selector.
                      items: const [
                        // Crea una opción del selector de rol.
                        DropdownMenuItem(
                          // Configura value.
                          value: Rol.alumno,
                          // Configura el contenido visual del componente.
                          child: Text('Alumno'),
                          // Cierra los argumentos de la operación actual.
                        ),
                        // Crea una opción del selector de rol.
                        DropdownMenuItem(
                          // Configura value.
                          value: Rol.tutor,
                          // Configura el contenido visual del componente.
                          child: Text('Tutor'),
                          // Cierra los argumentos de la operación actual.
                        ),
                        // Cierra la lista de elementos.
                      ],
                      // Configura la función que recibe la opción elegida.
                      onChanged: sesion.cargando ? null : _seleccionarRol,
                      // Cierra los argumentos de la operación actual.
                    ),
                    // Solicita el perfil completo únicamente para tutores.
                    if (_rolRegistro == Rol.tutor) ...[
                      const SizedBox(height: 16),
                      AppTextField(
                        etiqueta: 'Materias (separadas por comas)',
                        textoEjemplo: 'Matemáticas, Física',
                        controlador: _controladorMaterias,
                        habilitado: !sesion.cargando,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        etiqueta: 'Horarios (separados por ;)',
                        textoEjemplo:
                            'Lunes 08:00 - 10:00; Martes 14:00 - 16:00',
                        controlador: _controladorHorarios,
                        habilitado: !sesion.cargando,
                      ),
                    ],
                    // Cierra la lista de elementos.
                  ],
                  // Comprueba (sesion.error != null) ...[ antes de ejecutar el bloque.
                  if (sesion.error != null) ...[
                    // Crea un espacio de tamaño fijo con los valores indicados.
                    const SizedBox(height: 16),
                    // Crea un texto visible.
                    Text(
                      // Completa la operación utilizando sesion.error!.
                      sesion.error!,
                      // Configura style.
                      style: const TextStyle(color: AppColors.rechazada),
                      // Cierra los argumentos de la operación actual.
                    ),
                    // Cierra la lista de elementos.
                  ],
                  // Crea un espacio de tamaño fijo con los valores indicados.
                  const SizedBox(height: 24),
                  // Crea el botón principal del formulario.
                  PrimaryButton(
                    // Configura el texto del componente.
                    texto: textoBoton,
                    // Configura si se muestra la carga.
                    cargando: sesion.cargando,
                    // Configura la acción del botón.
                    alPresionar: _enviar,
                    // Cierra los argumentos de la operación actual.
                  ),
                  // Crea un espacio de tamaño fijo con los valores indicados.
                  const SizedBox(height: 12),
                  // Crea un botón de texto.
                  TextButton(
                    // Configura la acción al tocar el botón.
                    onPressed: sesion.cargando ? null : _cambiarFormulario,
                    // Configura el contenido visual del componente.
                    child: Text(
                      // Completa la operación utilizando _registrando ? 'Ya tengo cuenta' : 'Crear una cuenta'.
                      _registrando ? 'Ya tengo cuenta' : 'Crear una cuenta',
                      // Cierra los argumentos de la operación actual.
                    ),
                    // Cierra los argumentos de la operación actual.
                  ),
                  // Cierra la lista de elementos.
                ],
                // Cierra los argumentos de la operación actual.
              ),
              // Cierra los argumentos de la operación actual.
            ),
            // Cierra los argumentos de la operación actual.
          ),
          // Cierra los argumentos de la operación actual.
        ),
        // Cierra los argumentos de la operación actual.
      ),
      // Cierra los argumentos de la operación actual.
    );
    // Cierra el bloque de instrucciones o la definición.
  }

  // Guarda el rol elegido en el registro público.
  void _seleccionarRol(Rol? rol) {
    // Comprueba (rol == null) antes de ejecutar el bloque.
    if (rol == null) {
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Actualiza los datos locales y solicita redibujar el formulario.
    setState(() {
      // Actualiza el rol elegido para crear la cuenta con el valor indicado.
      _rolRegistro = rol;
      // Cierra el bloque de instrucciones o la definición.
    });
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}
