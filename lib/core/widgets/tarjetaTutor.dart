// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa modeloTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloTutor.dart';
// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa formatoTextos.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/formatoTextos.dart';
// Importa avatarIniciales.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avatarIniciales.dart';

/// Tarjeta de tutor del catálogo.
// Define TutorCard, que representa una tarjeta con información del tutor.
class TutorCard extends StatelessWidget {
  // Define cómo se crea TutorCard y qué datos recibe.
  const TutorCard({super.key, required this.tutor, required this.alTocar});

  // Declara el tutor que se muestra sin permitir reasignarlo.
  final Tutor tutor;
  // Declara la acción al tocar el componente sin permitir reasignarlo.
  final VoidCallback alTocar;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve una superficie con el comportamiento visual de Material con la configuración siguiente.
    return Material(
      // Establece el color al valor indicado.
      color: AppColors.superficie,
      // Establece la forma del componente al valor indicado.
      shape: RoundedRectangleBorder(
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        // Establece el borde de la forma o del botón al valor indicado.
        side: const BorderSide(color: AppColors.borde),
        // Cierra la configuración de RoundedRectangleBorder.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: InkWell(
        // Establece la acción al tocar el componente al valor indicado.
        onTap: alTocar,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        // Establece el único componente visual contenido al valor indicado.
        child: Padding(
          // Establece el espacio interior alrededor del contenido al valor indicado.
          padding: const EdgeInsets.all(AppSpacing.tarjeta),
          // Establece el único componente visual contenido al valor indicado.
          child: Row(
            // Establece la lista de componentes visuales hijos al valor indicado.
            children: [
              // Crea un avatar con las iniciales del nombre.
              InitialsAvatar(nombre: tutor.nombre, tamano: 56),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 16),
              // Crea un componente que ocupa el espacio restante.
              Expanded(
                // Establece el único componente visual contenido al valor indicado.
                child: Column(
                  // Establece la alineación en el eje transversal al valor indicado.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Establece la lista de componentes visuales hijos al valor indicado.
                  children: [
                    // Crea un texto visible.
                    Text(
                      // Utiliza tutor.nombre como parte de la operación actual.
                      tutor.nombre,
                      // Establece el máximo de líneas al valor indicado.
                      maxLines: 1,
                      // Establece cómo se muestra un texto que no cabe al valor indicado.
                      overflow: TextOverflow.ellipsis,
                      // Establece el estilo visual al valor indicado.
                      style: AppTextStyles.tituloTarjeta,
                      // Cierra la configuración de Text.
                    ),
                    // Crea un espacio o caja de tamaño fijo con valores constantes.
                    const SizedBox(height: 4),
                    // Crea un texto visible.
                    Text(
                      // Une las materias del tutor separándolas con un punto centrado.
                      tutor.materias.join(' · '),
                      // Establece el máximo de líneas al valor indicado.
                      maxLines: 1,
                      // Establece cómo se muestra un texto que no cabe al valor indicado.
                      overflow: TextOverflow.ellipsis,
                      // Establece el estilo visual al valor indicado.
                      style: AppTextStyles.cuerpo.copyWith(
                        // Establece el tamaño de la letra al valor indicado.
                        fontSize: 13.5,
                        // Establece el espacio entre letras al valor indicado.
                        letterSpacing: -0.1,
                        // Cierra la configuración de copyWith.
                      ),
                      // Cierra la configuración de Text.
                    ),
                    // Crea un espacio o caja de tamaño fijo con valores constantes.
                    const SizedBox(height: 9),
                    // Crea una fila de componentes.
                    Row(
                      // Establece la lista de componentes visuales hijos al valor indicado.
                      children: [
                        // Crea un icono con valores constantes.
                        const Icon(
                          // Utiliza Icons.star_rounded como parte de la operación actual.
                          Icons.star_rounded,
                          // Establece el tamaño del icono al valor indicado.
                          size: 17,
                          // Establece el color al valor indicado.
                          color: AppColors.ambar,
                          // Cierra la configuración de Icon.
                        ),
                        // Crea un espacio o caja de tamaño fijo con valores constantes.
                        const SizedBox(width: 4),
                        // Crea un texto visible.
                        Text(
                          // Convierte la calificación del tutor en texto con un decimal.
                          // Distingue una cuenta nueva de una calificación real de cero.
                          tutor.calificacion == 0
                              ? 'Sin reseñas'
                              : tutor.calificacion.toStringAsFixed(1),
                          // Establece el estilo visual al valor indicado.
                          style: const TextStyle(
                            // Establece la familia tipográfica al valor indicado.
                            fontFamily: AppTextStyles.inter,
                            // Establece el tamaño de la letra al valor indicado.
                            fontSize: 13.5,
                            // Establece el grosor de la letra al valor indicado.
                            fontWeight: FontWeight.w500,
                            // Establece el color al valor indicado.
                            color: AppColors.moradoOscuro,
                            // Cierra la configuración de TextStyle.
                          ),
                          // Cierra la configuración de Text.
                        ),
                        // Crea un espacio o caja de tamaño fijo con valores constantes.
                        const SizedBox(width: 14),
                        // Crea un icono con valores constantes.
                        const Icon(
                          // Utiliza Icons.schedule_rounded como parte de la operación actual.
                          Icons.schedule_rounded,
                          // Establece el tamaño del icono al valor indicado.
                          size: 16,
                          // Establece el color al valor indicado.
                          color: AppColors.textoSecundario,
                          // Cierra la configuración de Icon.
                        ),
                        // Crea un espacio o caja de tamaño fijo con valores constantes.
                        const SizedBox(width: 5),
                        // Utiliza Flexible con los argumentos indicados.
                        Flexible(
                          // Establece el único componente visual contenido al valor indicado.
                          child: Text(
                            // Utiliza tutor.horariosDisponibles.isEmpty como parte de la operación actual.
                            tutor.horariosDisponibles.isEmpty
                                // Usa esta alternativa cuando la condición anterior es verdadera.
                                ? 'Sin horario'
                                // Usa esta alternativa cuando la condición anterior es falsa.
                                : Formato.horarioCorto(
                                    // Utiliza tutor.horariosDisponibles.first como parte de la operación actual.
                                    tutor.horariosDisponibles.first,
                                    // Cierra la configuración de horarioCorto.
                                  ),
                            // Establece el máximo de líneas al valor indicado.
                            maxLines: 1,
                            // Establece cómo se muestra un texto que no cabe al valor indicado.
                            overflow: TextOverflow.ellipsis,
                            // Establece el estilo visual al valor indicado.
                            style: AppTextStyles.etiqueta.copyWith(
                              // Establece el tamaño de la letra al valor indicado.
                              fontSize: 13.5,
                              // Establece el color al valor indicado.
                              color: AppColors.textoSecundario,
                              // Cierra la configuración de copyWith.
                            ),
                            // Cierra la configuración de Text.
                          ),
                          // Cierra la configuración de Flexible.
                        ),
                        // Cierra la lista de elementos.
                      ],
                      // Cierra la configuración de Row.
                    ),
                    // Cierra la lista de elementos.
                  ],
                  // Cierra la configuración de Column.
                ),
                // Cierra la configuración de Expanded.
              ),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 8),
              // Crea un icono con valores constantes.
              const Icon(
                // Utiliza Icons.chevron_right_rounded como parte de la operación actual.
                Icons.chevron_right_rounded,
                // Establece el tamaño del icono al valor indicado.
                size: 24,
                // Establece el color al valor indicado.
                color: AppColors.morado,
                // Cierra la configuración de Icon.
              ),
              // Cierra la lista de elementos.
            ],
            // Cierra la configuración de Row.
          ),
          // Cierra la configuración de Padding.
        ),
        // Cierra la configuración de InkWell.
      ),
      // Cierra la configuración de Material y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase TutorCard.
}
