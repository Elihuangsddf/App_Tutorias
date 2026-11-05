// Importa modeloSolicitud.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloSolicitud.dart';
// Importa modeloUsuario.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa modeloTutor.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloTutor.dart';

// Prepara usuarios demo.
const List<Usuario> usuariosDemo = [
  // Crea un modelo de usuario sin contraseña.
  Usuario(
    // Configura el identificador de la cuenta.
    id: 'alumno-1',
    // Configura el nombre del usuario.
    nombre: 'Ana López',
    // Configura el correo electrónico.
    correo: 'ana.alumno@tutopar.local',
    // Configura el rol guardado en la cuenta.
    rol: Rol.alumno,
    // Cierra los argumentos de la operación actual.
  ),
  // Crea un modelo de usuario sin contraseña.
  Usuario(
    // Configura el identificador de la cuenta.
    id: 'alumno-2',
    // Configura el nombre del usuario.
    nombre: 'Pedro Sánchez',
    // Configura el correo electrónico.
    correo: 'pedro.alumno@tutopar.local',
    // Configura el rol guardado en la cuenta.
    rol: Rol.alumno,
    // Cierra los argumentos de la operación actual.
  ),
  // Crea un modelo de usuario sin contraseña.
  Usuario(
    // Configura el identificador de la cuenta.
    id: 'tutor-1',
    // Configura el nombre del usuario.
    nombre: 'Ana Martínez',
    // Configura el correo electrónico.
    correo: 'ana.tutor@tutopar.local',
    // Configura el rol guardado en la cuenta.
    rol: Rol.tutor,
    // Cierra los argumentos de la operación actual.
  ),
  // Crea un modelo de usuario sin contraseña.
  Usuario(
    // Configura el identificador de la cuenta.
    id: 'admin-1',
    // Configura el nombre del usuario.
    nombre: 'Administración TutoPar',
    // Configura el correo electrónico.
    correo: 'admin@tutopar.local',
    // Configura el rol guardado en la cuenta.
    rol: Rol.administrador,
    // Cierra los argumentos de la operación actual.
  ),
  // Cierra la lista de elementos.
];

// Prepara tutores demo.
const List<Tutor> tutoresDemo = [
  // Crea el objeto o la llamada Tutor.
  Tutor(
    // Configura el identificador de la cuenta.
    id: 'tutor-1',
    // Configura el nombre del usuario.
    nombre: 'Ana Martínez',
    // Configura materias.
    materias: ['Matemáticas', 'Física'],
    // Configura calificacion.
    calificacion: 4.9,
    // Configura horarios disponibles.
    horariosDisponibles: ['Lunes 08:00 - 10:00', 'Miércoles 14:00 - 16:00'],
    // Configura descripcion.
    descripcion:
        // Aporta el texto indicado a la operación actual.
        'Estudiante con interés en explicar conceptos y acompañar el '
        // Aporta el texto indicado a la operación actual.
        'aprendizaje de sus compañeros.',
    // Configura foto.
    foto: 'assets/images/tutor_1.png',
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Tutor.
  Tutor(
    // Configura el identificador de la cuenta.
    id: 'tutor-2',
    // Configura el nombre del usuario.
    nombre: 'Luis Hernández',
    // Configura materias.
    materias: ['Programación', 'Bases de Datos'],
    // Configura calificacion.
    calificacion: 4.7,
    // Configura horarios disponibles.
    horariosDisponibles: ['Martes 10:00 - 12:00', 'Jueves 16:00 - 18:00'],
    // Configura descripcion.
    descripcion:
        // Aporta el texto indicado a la operación actual.
        'Desarrollador backend. Ayuda con fundamentos de programación, '
        // Aporta el texto indicado a la operación actual.
        'estructuras de datos y diseño de bases de datos relacionales.',
    // Configura foto.
    foto: 'assets/images/tutor_2.png',
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Tutor.
  Tutor(
    // Configura el identificador de la cuenta.
    id: 'tutor-3',
    // Configura el nombre del usuario.
    nombre: 'Sofía Ramírez',
    // Configura materias.
    materias: ['Química', 'Biología'],
    // Configura calificacion.
    calificacion: 4.8,
    // Configura horarios disponibles.
    horariosDisponibles: ['Martes 10:00 - 12:00', 'Viernes 08:00 - 10:00'],
    // Configura descripcion.
    descripcion:
        // Aporta el texto indicado a la operación actual.
        'Estudiante de último semestre de Química. Explica estequiometría, '
        // Aporta el texto indicado a la operación actual.
        'enlaces y temas de biología celular con ejercicios guiados.',
    // Configura foto.
    foto: 'assets/images/tutor_3.png',
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Tutor.
  Tutor(
    // Configura el identificador de la cuenta.
    id: 'tutor-4',
    // Configura el nombre del usuario.
    nombre: 'Diego Torres',
    // Configura materias.
    materias: ['Cálculo', 'Álgebra'],
    // Configura calificacion.
    calificacion: 4.5,
    // Configura horarios disponibles.
    horariosDisponibles: ['Lunes 18:00 - 20:00', 'Sábado 09:00 - 11:00'],
    // Configura descripcion.
    descripcion:
        // Aporta el texto indicado a la operación actual.
        'Asesor con enfoque en resolución de problemas. Trabaja límites, '
        // Aporta el texto indicado a la operación actual.
        'derivadas, integrales y álgebra lineal desde cero.',
    // Configura foto.
    foto: 'assets/images/tutor_4.png',
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Tutor.
  Tutor(
    // Configura el identificador de la cuenta.
    id: 'tutor-5',
    // Configura el nombre del usuario.
    nombre: 'Valeria Cruz',
    // Configura materias.
    materias: ['Inglés', 'Redacción'],
    // Configura calificacion.
    calificacion: 4.9,
    // Configura horarios disponibles.
    horariosDisponibles: ['Miércoles 08:00 - 10:00', 'Viernes 14:00 - 16:00'],
    // Configura descripcion.
    descripcion:
        // Aporta el texto indicado a la operación actual.
        'Certificada en inglés avanzado. Apoya con gramática, comprensión '
        // Aporta el texto indicado a la operación actual.
        'lectora y redacción de ensayos académicos.',
    // Configura foto.
    foto: 'assets/images/tutor_5.png',
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Tutor.
  Tutor(
    // Configura el identificador de la cuenta.
    id: 'tutor-6',
    // Configura el nombre del usuario.
    nombre: 'Marco Jiménez',
    // Configura materias.
    materias: ['Estadística', 'Probabilidad'],
    // Configura calificacion.
    calificacion: 4.3,
    // Configura horarios disponibles.
    horariosDisponibles: ['Jueves 08:00 - 10:00', 'Viernes 16:00 - 18:00'],
    // Configura descripcion.
    descripcion:
        // Aporta el texto indicado a la operación actual.
        'Analista de datos. Explica estadística descriptiva, distribuciones '
        // Aporta el texto indicado a la operación actual.
        'y pruebas de hipótesis con ejemplos reales.',
    // Configura foto.
    foto: 'assets/images/tutor_6.png',
    // Cierra los argumentos de la operación actual.
  ),
  // Cierra la lista de elementos.
];

// Prepara solicitudes demo.
final List<Solicitud> solicitudesDemo = [
  // Crea el objeto o la llamada Solicitud.
  Solicitud(
    // Configura el identificador de la cuenta.
    id: 'sol-1',
    // Configura id alumno.
    idAlumno: 'alumno-1',
    // Configura id tutor.
    idTutor: 'tutor-1',
    // Configura nombre alumno.
    nombreAlumno: 'Ana López',
    // Configura nombre tutor.
    nombreTutor: 'Ana Martínez',
    // Configura materia.
    materia: 'Matemáticas',
    // Configura horario.
    horario: 'Lunes 08:00 - 10:00',
    // Configura el mensaje de error.
    mensaje: 'Necesito repasar derivadas antes del examen parcial.',
    // Configura estado.
    estado: EstadoSolicitud.pendiente,
    // Configura fecha.
    fecha: DateTime(2026, 10, 28),
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Solicitud.
  Solicitud(
    // Configura el identificador de la cuenta.
    id: 'sol-2',
    // Configura id alumno.
    idAlumno: 'alumno-1',
    // Configura id tutor.
    idTutor: 'tutor-3',
    // Configura nombre alumno.
    nombreAlumno: 'Ana López',
    // Configura nombre tutor.
    nombreTutor: 'Sofía Ramírez',
    // Configura materia.
    materia: 'Química',
    // Configura horario.
    horario: 'Martes 10:00 - 12:00',
    // Configura el mensaje de error.
    mensaje: 'Tengo dudas con los ejercicios de estequiometría.',
    // Configura estado.
    estado: EstadoSolicitud.aceptada,
    // Configura fecha.
    fecha: DateTime(2026, 10, 25),
    // Cierra los argumentos de la operación actual.
  ),
  // Crea el objeto o la llamada Solicitud.
  Solicitud(
    // Configura el identificador de la cuenta.
    id: 'sol-3',
    // Configura id alumno.
    idAlumno: 'alumno-2',
    // Configura id tutor.
    idTutor: 'tutor-1',
    // Configura nombre alumno.
    nombreAlumno: 'Pedro Sánchez',
    // Configura nombre tutor.
    nombreTutor: 'Ana Martínez',
    // Configura materia.
    materia: 'Física',
    // Configura horario.
    horario: 'Miércoles 14:00 - 16:00',
    // Configura el mensaje de error.
    mensaje: 'Quiero prepararme para el examen de cinemática.',
    // Configura estado.
    estado: EstadoSolicitud.pendiente,
    // Configura fecha.
    fecha: DateTime(2026, 10, 30),
    // Cierra los argumentos de la operación actual.
  ),
  // Cierra la lista de elementos.
];
