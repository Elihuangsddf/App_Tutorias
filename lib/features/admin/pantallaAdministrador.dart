// Importa package:flutter/material.dart para utilizar sus componentes y clases.
import 'package:flutter/material.dart';
// Abre el formulario para crear o modificar una cuenta y su perfil.
import 'package:app_tutorias/features/admin/formularioCuenta.dart';
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
// Importa package:provider/provider.dart para utilizar sus componentes y clases.
import 'package:provider/provider.dart';
// Importa botonCerrarSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/widgets/botonCerrarSesion.dart';
// Importa controladorSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa temaAplicacion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Representa las cuentas públicas y sus roles sin incluir contraseñas.
import 'package:app_tutorias/models/modeloUsuario.dart';

// Consulta las cuentas reales conservando los permisos y la navegación actuales.
class PantallaAdministrador extends StatefulWidget {
  // Crea el panel inicial del administrador con los valores indicados.
  const PantallaAdministrador({super.key});

  // Conserva la consulta entre reconstrucciones de la pantalla.
  @override
  State<PantallaAdministrador> createState() => _PantallaAdministradorState();
}

// Mantiene el resultado del directorio y permite actualizarlo o reintentarlo.
class _PantallaAdministradorState extends State<PantallaAdministrador> {
  // Actualiza el directorio después de guardar una cuenta.
  Future<void> _editar({Usuario? cuenta}) async {
    final guardado = await abrirFormularioCuenta(context, cuenta: cuenta);
    if (guardado == true && mounted) {
      _actualizar();
    }
  }

  // Solicita confirmación antes de eliminar una cuenta y su perfil.
  Future<void> _borrar(Usuario cuenta) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: const Text('Borrar cuenta'),
        content: Text(
          '¿Borrar a ${cuenta.nombre}? Su perfil también se eliminará. Las solicitudes anteriores conservarán su historial.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(contexto, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(contexto, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (confirmado != true || !mounted) {
      return;
    }
    try {
      await context.read<SesionProvider>().borrarCuenta(cuenta.id);
      if (mounted) {
        _actualizar();
      }
    } on ErrorAutenticacion catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.mensaje)));
      }
    }
  }

  // Guarda la lectura pendiente de las cuentas registradas.
  late Future<List<Usuario>> _usuarios;

  // Consulta el directorio una vez al abrir el panel.
  @override
  void initState() {
    // Inicializa el estado de Flutter antes de consultar sus dependencias.
    super.initState();
    // El controlador comprueba el permiso del administrador antes de leer cuentas.
    _usuarios = context.read<SesionProvider>().obtenerUsuariosAdministracion();
  }

  // Actualiza el directorio sin salir del panel.
  void _actualizar() {
    // Reconstruye el panel con el estado de la nueva consulta.
    setState(() {
      // Reutiliza la misma fuente de cuentas que el registro y el inicio de sesión.
      _usuarios = context
          .read<SesionProvider>()
          .obtenerUsuariosAdministracion();
    });
  }

  // Presenta el directorio con estados de carga, error y vacío.
  Widget _directorio() {
    // Escucha el resultado de la consulta guardada, sin repetirla al dibujar.
    return FutureBuilder<List<Usuario>>(
      // Utiliza la lectura iniciada al abrir o actualizar el panel.
      future: _usuarios,
      // Construye el contenido según el resultado asíncrono.
      builder: (contexto, resultado) {
        // Mantiene visible el progreso hasta que termine la lectura.
        if (resultado.connectionState != ConnectionState.done) {
          // Informa de la carga sin bloquear el cierre de sesión.
          return const Center(child: CircularProgressIndicator());
        }
        // Ofrece una recuperación si falla la lectura de cuentas.
        if (resultado.hasError) {
          // Agrupa el mensaje de error con su acción de reintento.
          return Column(
            // Explica el problema sin exponer detalles internos.
            children: [
              // Indica que no fue posible consultar el directorio.
              const Text('No se pudieron cargar las cuentas.'),
              // Permite repetir la consulta sin abandonar la sesión.
              TextButton(
                onPressed: _actualizar,
                child: const Text('Reintentar'),
              ),
            ],
          );
        }
        // Usa una lista vacía cuando la fuente no devuelve cuentas.
        final cuentas = resultado.data ?? const <Usuario>[];
        // Integra los usuarios en el desplazamiento general del panel.
        return Column(
          // Alinea el resumen con el encabezado de la pantalla.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Presenta el total, el resumen por rol y cada cuenta registrada.
          children: [
            // Incluye las cuentas nuevas en el total administrativo.
            Text(
              'Cuentas registradas: ${cuentas.length}',
              style: AppTextStyles.tituloSeccion,
            ),
            // Separa el total del resumen por rol.
            const SizedBox(height: 12),
            // Ajusta los contadores al ancho disponible del teléfono.
            Wrap(
              // Separa los contadores horizontalmente.
              spacing: 16,
              // Separa los contadores cuando pasan a otra fila.
              runSpacing: 8,
              // Muestra el número de cuentas reales de cada rol.
              children: [
                // Recorre únicamente los roles definidos en el modelo.
                for (final rol in Rol.values)
                  // Cuenta las cuentas del rol indicado, sin inventar usuarios de ejemplo.
                  Text(
                    '${rol.etiqueta}: ${cuentas.where((cuenta) => cuenta.rol == rol).length}',
                  ),
              ],
            ),
            // Separa el resumen de las tarjetas de cuentas.
            const SizedBox(height: 16),
            // Explica el estado vacío si no hay cuentas disponibles.
            if (cuentas.isEmpty) const Text('Aún no hay cuentas registradas.'),
            // Incorpora cada cuenta, incluidas las recién registradas.
            for (final cuenta in cuentas)
              // Agrupa visualmente los datos públicos del usuario.
              Card(
                // Conserva el panel como consulta, sin cambios de permisos.
                child: ListTile(
                  // Identifica la cuenta por su nombre registrado.
                  title: Text(cuenta.nombre),
                  // Separa correo y rol para facilitar la lectura en teléfonos.
                  subtitle: Text('${cuenta.correo}\n${cuenta.rol.etiqueta}'),
                  // Reserva espacio para las dos líneas del subtítulo.
                  isThreeLine: true,
                  // Protege la cuenta administrativa y ofrece acciones para los otros roles.
                  trailing: cuenta.rol == Rol.administrador
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Modificar ${cuenta.nombre}',
                              onPressed: () => _editar(cuenta: cuenta),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              tooltip: 'Borrar ${cuenta.nombre}',
                              onPressed: () => _borrar(cuenta),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                ),
              ),
          ],
        );
      },
    );
  }

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Construye el contenido visual de esta pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el usuario autenticado.
    final usuario = contexto.watch<SesionProvider>().usuario;
    // Devuelve la estructura de la pantalla con la configuración siguiente.
    return Scaffold(
      // Configura la barra superior.
      appBar: AppBar(
        // Configura el título visible.
        title: const Text('Panel de administración'),
        // Configura si Flutter añade automáticamente un botón para regresar.
        automaticallyImplyLeading: false,
        // Configura los botones de la barra superior.
        // Agrega una recarga explícita y conserva el cierre de sesión.
        actions: [
          // Actualiza las cuentas sin abandonar el panel.
          IconButton(
            // Describe la acción para accesibilidad.
            tooltip: 'Actualizar cuentas',
            // Solicita otra lectura al pulsar el icono.
            onPressed: _actualizar,
            // Representa visualmente la actualización del directorio.
            icon: const Icon(Icons.refresh_rounded),
          ),
          // Conserva el botón compartido de cierre de sesión.
          const SalirButton(),
        ],
        // Cierra los argumentos de la operación actual.
      ),
      // Configura el contenido principal.
      body: ListView(
        // Configura el espacio alrededor del contenido.
        padding: const EdgeInsets.all(20),
        // Configura la lista de componentes hijos.
        children: [
          // Crea un texto visible.
          Text(
            // Aporta el texto indicado a la operación actual.
            'Bienvenido, ${usuario?.nombre ?? ""}',
            // Configura style.
            style: AppTextStyles.tituloPantalla,
            // Cierra los argumentos de la operación actual.
          ),
          // Crea un espacio de tamaño fijo con los valores indicados.
          const SizedBox(height: 16),
          // Crea un texto visible con los valores indicados.
          const Text('Sesión de Administrador'),
          // Crea un espacio de tamaño fijo con los valores indicados.
          const SizedBox(height: 8),
          // Crea un texto visible.
          Text(usuario?.correo ?? ''),
          // Separa la información de sesión de las cuentas registradas.
          const SizedBox(height: 24),
          // Presenta los datos actuales del directorio administrativo.
          // Crea alumnos o tutores desde el panel administrativo.
          FilledButton.icon(
            onPressed: () => _editar(),
            icon: const Icon(Icons.person_add_alt),
            label: const Text('Crear alumno o tutor'),
          ),
          const SizedBox(height: 16),
          _directorio(),
          // Cierra la lista de elementos.
        ],
        // Cierra los argumentos de la operación actual.
      ),
      // Cierra los argumentos de la operación actual.
    );
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}
