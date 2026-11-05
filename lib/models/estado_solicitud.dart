/// Estado por el que pasa una solicitud de tutoría.
enum EstadoSolicitud {
  pendiente('pendiente', 'Pendiente'),
  aceptada('aceptada', 'Aceptada'),
  rechazada('rechazada', 'Rechazada');

  const EstadoSolicitud(this.valor, this.etiqueta);

  final String valor;
  final String etiqueta;

  static EstadoSolicitud desdeValor(String? valor) {
    return EstadoSolicitud.values.firstWhere(
      (estado) => estado.valor == valor,
      orElse: () => EstadoSolicitud.pendiente,
    );
  }
}
