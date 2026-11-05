import '../../models/estado_solicitud.dart';
import '../../models/rol.dart';
import '../../models/solicitud.dart';
import '../../models/tutor.dart';
import '../../models/usuario.dart';

/// Datos de ejemplo de la Etapa 1.
///
/// Están en un solo archivo para que el equipo pueda agregar tutores o
/// solicitudes sin tocar la lógica de los repositorios.
///
/// Las rutas de `foto` son provisionales: Rol 1 debe crear los assets y
/// declararlos en `pubspec.yaml`.
const List<Usuario> usuariosDemo = [
  Usuario(id: 'alumno-1', nombre: 'Ana López', rol: Rol.alumno),
  Usuario(id: 'alumno-2', nombre: 'Pedro Sánchez', rol: Rol.alumno),
  Usuario(id: 'tutor-1', nombre: 'Ana Martínez', rol: Rol.tutor),
];

const List<Tutor> tutoresDemo = [
  Tutor(
    id: 'tutor-1',
    nombre: 'Ana Martínez',
    materias: ['Matemáticas', 'Física'],
    calificacion: 4.9,
    horariosDisponibles: ['Lunes 08:00 - 10:00', 'Miércoles 14:00 - 16:00'],
    descripcion:
        'Estudiante con interés en explicar conceptos y acompañar el '
        'aprendizaje de sus compañeros.',
    foto: 'assets/images/tutor_1.png',
  ),
  Tutor(
    id: 'tutor-2',
    nombre: 'Luis Hernández',
    materias: ['Programación', 'Bases de Datos'],
    calificacion: 4.7,
    horariosDisponibles: ['Martes 10:00 - 12:00', 'Jueves 16:00 - 18:00'],
    descripcion:
        'Desarrollador backend. Ayuda con fundamentos de programación, '
        'estructuras de datos y diseño de bases de datos relacionales.',
    foto: 'assets/images/tutor_2.png',
  ),
  Tutor(
    id: 'tutor-3',
    nombre: 'Sofía Ramírez',
    materias: ['Química', 'Biología'],
    calificacion: 4.8,
    horariosDisponibles: ['Martes 10:00 - 12:00', 'Viernes 08:00 - 10:00'],
    descripcion:
        'Estudiante de último semestre de Química. Explica estequiometría, '
        'enlaces y temas de biología celular con ejercicios guiados.',
    foto: 'assets/images/tutor_3.png',
  ),
  Tutor(
    id: 'tutor-4',
    nombre: 'Diego Torres',
    materias: ['Cálculo', 'Álgebra'],
    calificacion: 4.5,
    horariosDisponibles: ['Lunes 18:00 - 20:00', 'Sábado 09:00 - 11:00'],
    descripcion:
        'Asesor con enfoque en resolución de problemas. Trabaja límites, '
        'derivadas, integrales y álgebra lineal desde cero.',
    foto: 'assets/images/tutor_4.png',
  ),
  Tutor(
    id: 'tutor-5',
    nombre: 'Valeria Cruz',
    materias: ['Inglés', 'Redacción'],
    calificacion: 4.9,
    horariosDisponibles: ['Miércoles 08:00 - 10:00', 'Viernes 14:00 - 16:00'],
    descripcion:
        'Certificada en inglés avanzado. Apoya con gramática, comprensión '
        'lectora y redacción de ensayos académicos.',
    foto: 'assets/images/tutor_5.png',
  ),
  Tutor(
    id: 'tutor-6',
    nombre: 'Marco Jiménez',
    materias: ['Estadística', 'Probabilidad'],
    calificacion: 4.3,
    horariosDisponibles: ['Jueves 08:00 - 10:00', 'Viernes 16:00 - 18:00'],
    descripcion:
        'Analista de datos. Explica estadística descriptiva, distribuciones '
        'y pruebas de hipótesis con ejemplos reales.',
    foto: 'assets/images/tutor_6.png',
  ),
];

final List<Solicitud> solicitudesDemo = [
  Solicitud(
    id: 'sol-1',
    idAlumno: 'alumno-1',
    idTutor: 'tutor-1',
    nombreAlumno: 'Ana López',
    nombreTutor: 'Ana Martínez',
    materia: 'Matemáticas',
    horario: 'Lunes 08:00 - 10:00',
    mensaje: 'Necesito repasar derivadas antes del examen parcial.',
    estado: EstadoSolicitud.pendiente,
    fecha: DateTime(2026, 10, 28),
  ),
  Solicitud(
    id: 'sol-2',
    idAlumno: 'alumno-1',
    idTutor: 'tutor-3',
    nombreAlumno: 'Ana López',
    nombreTutor: 'Sofía Ramírez',
    materia: 'Química',
    horario: 'Martes 10:00 - 12:00',
    mensaje: 'Tengo dudas con los ejercicios de estequiometría.',
    estado: EstadoSolicitud.aceptada,
    fecha: DateTime(2026, 10, 25),
  ),
  Solicitud(
    id: 'sol-3',
    idAlumno: 'alumno-2',
    idTutor: 'tutor-1',
    nombreAlumno: 'Pedro Sánchez',
    nombreTutor: 'Ana Martínez',
    materia: 'Física',
    horario: 'Miércoles 14:00 - 16:00',
    mensaje: 'Quiero prepararme para el examen de cinemática.',
    estado: EstadoSolicitud.pendiente,
    fecha: DateTime(2026, 10, 30),
  ),
];
