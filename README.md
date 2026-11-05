# App Tutorías

Aplicación móvil de tutorías académicas entre estudiantes. Un **alumno** encuentra tutores,
consulta su perfil y envía una solicitud; un **tutor** revisa las solicitudes recibidas y las
acepta o rechaza.

El proyecto aborda el **rezago académico** como problemática social, alineado con el
**ODS 4 (Educación de calidad)** de la Agenda 2030: facilitar el acceso a apoyo académico entre
pares dentro de la misma comunidad estudiantil.

> **Etapa 1 — MVP local.** Sin backend, sin Firebase y sin persistencia: los datos viven en
> memoria mientras la app está abierta. La arquitectura ya está preparada para conectar
> Firebase en la Etapa 2 cambiando una sola línea en `main.dart`.

---

## Tabla de contenido

- [Alcance de la Etapa 1](#alcance-de-la-etapa-1)
- [Arquitectura](#arquitectura)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Modelos y contratos](#modelos-y-contratos)
- [Pantallas](#pantallas)
- [Requisitos técnicos y cómo se cubren](#requisitos-técnicos-y-cómo-se-cubren)
- [Cómo ejecutar el proyecto](#cómo-ejecutar-el-proyecto)
- [Estado del proyecto](#estado-del-proyecto)
- [Etapa 2 (backlog)](#etapa-2-backlog)
- [Equipo y roles](#equipo-y-roles)
- [Convenciones de Git](#convenciones-de-git)
- [Decisiones abiertas](#decisiones-abiertas)
- [Uso de inteligencia artificial](#uso-de-inteligencia-artificial)

---

## Alcance de la Etapa 1

| Dentro del MVP | Fuera del MVP (Etapa 2) |
|---|---|
| Dos roles: **Alumno** y **Tutor** | Rol **Admin** con aprobación de perfiles |
| Seis pantallas con navegación por rutas nombradas | Notificaciones push |
| Datos de ejemplo en memoria (repositorios mock) | Firebase Auth + Firestore |
| Búsqueda y filtros en el catálogo de tutores | Chat o videollamada |
| Solicitudes con validaciones y cambio de estado | Persistencia entre sesiones |

**Flujo principal:** Splash → Selección de rol → Catálogo → Detalle del tutor → Formulario de
solicitud → Panel de solicitudes.

- **Alumno:** explora tutores, filtra por materia/calificación/horario, envía solicitudes y
  consulta el estado de las suyas.
- **Tutor:** consulta las solicitudes que recibió y las acepta o rechaza.

---

## Arquitectura

Los datos viajan en **una sola dirección** y cada capa tiene una única responsabilidad:

```
Pantalla  →  Provider  →  Repository (contrato)  →  Implementación
                                                     ├── Mock (Etapa 1)
                                                     └── Firebase (Etapa 2)
```

### Reglas

1. **Las pantallas no tienen lógica de negocio ni acceden a datos.** Solo dibujan lo que el
   Provider les entrega (`watch` al construir, `read` dentro de acciones como botones) y le
   informan lo que hizo el usuario.
2. **Los Providers no saben de dónde vienen los datos.** Reciben un `Repository` como clase
   abstracta; la implementación concreta les es indiferente.
3. **Un solo lugar decide qué implementación se usa: `main.dart`.** Ahí se registran los
   Providers con `MultiProvider` y se inyectan los repositorios mock. En la Etapa 2 solo cambia
   esa línea.

### Por qué esta arquitectura

- Cumple el mínimo técnico del curso (Provider, Model, Repository, rutas con argumentos).
- Permite que las tres personas trabajen en paralelo sobre contratos ya acordados.
- Hace que la migración a Firebase no toque pantallas, Providers ni rutas.
- Facilita las pruebas: los repositorios mock son intercambiables y deterministas.

---

## Estructura del proyecto

```
lib/
├── main.dart                  # arranque: repositorios + MultiProvider + rutas
├── core/
│   ├── theme/                 # colores, tipografía, formas, estilos de botones y campos
│   ├── widgets/               # componentes reutilizables (mínimo 2)
│   ├── routes/                # nombres de rutas y tabla de navegación
│   └── utils/                 # validadores de formularios y constantes
├── models/                    # Usuario, Tutor, Solicitud (con toMap/fromMap)
├── repositories/
│   ├── auth_repository.dart
│   ├── tutores_repository.dart
│   ├── solicitudes_repository.dart
│   └── mock/                  # implementaciones con datos locales
├── providers/                 # SesionProvider, TutoresProvider, SolicitudesProvider
└── features/
    ├── auth/                  # Splash y selección de rol
    ├── tutores/               # catálogo y detalle
    └── solicitudes/           # formulario y panel
assets/
├── images/                    # logo, íconos y fotos de ejemplo
└── data/                      # JSON de datos de ejemplo (opcional)
```

Cada carpeta de `features/` contiene solo pantallas y widgets propios de esa función; la lógica
vive en `providers/` y los datos en `repositories/`.

---

## Modelos y contratos

### Modelos

Todos incluyen `toMap()` y `fromMap()` desde la Etapa 1, y todos los identificadores son
`String`, para que el paso a Firestore sea directo.

| Modelo | Campos |
|---|---|
| `Usuario` | `id`, `nombre`, `rol` (`alumno` \| `tutor`) |
| `Tutor` | `id`, `nombre`, `materias`, `calificacion`, `horariosDisponibles`, `descripcion`, `foto` |
| `Solicitud` | `id`, `idAlumno`, `idTutor`, `materia`, `horario`, `mensaje`, `estado` (`pendiente` \| `aceptada` \| `rechazada`), `fecha` |

> El usuario con rol `tutor` comparte `id` con su entrada en el catálogo de tutores, de modo que
> `listarPorTutor` y el panel del tutor funcionan sin tablas intermedias.

### Repositorios (contratos abstractos)

Métodos **asíncronos** desde el inicio, aunque los datos sean locales. Así la firma no cambia
cuando llegue Firebase.

| Contrato | Métodos |
|---|---|
| `AuthRepository` | `iniciarSesionPorRol(rol)`, `cerrarSesion()` |
| `TutoresRepository` | `obtenerTutores()`, `obtenerTutorPorId(id)` |
| `SolicitudesRepository` | `crear(solicitud)`, `listarPorAlumno(idAlumno)`, `listarPorTutor(idTutor)`, `cambiarEstado(id, estado)` |

El login es simulado: elige un usuario de ejemplo según el rol (un alumno y un tutor que existe
en el catálogo).

### Providers

| Provider | Responsabilidad |
|---|---|
| `SesionProvider` | Usuario actual y rol; inicio y cierre de sesión |
| `TutoresProvider` | Lista de tutores, texto de búsqueda, filtros, resultados filtrados, estados de carga y error |
| `SolicitudesProvider` | Solicitudes según el rol, creación, aceptación y rechazo |

### Rutas

Un único archivo con los nombres como constantes y navegación con **rutas nombradas**. El detalle
del tutor recibe el **`id` como argumento**, no el objeto completo, y lo resuelve a través del
Provider.

---

## Pantallas

| # | Pantalla | Rol | Descripción |
|---|---|---|---|
| 1 | Splash | Ambos | Pantalla de bienvenida; verifica la sesión y navega a la selección de rol |
| 2 | Selección de rol | Ambos | Login simulado: el usuario elige entrar como alumno o como tutor |
| 3 | Catálogo de tutores | Alumno | Listado con búsqueda por materia, filtros y estados vacío / sin resultados / error |
| 4 | Detalle del tutor | Alumno | Perfil completo, materias, horarios, calificación y acceso al formulario |
| 5 | Formulario de solicitud | Alumno | Materia, horario y mensaje, con validaciones |
| 6 | Panel de solicitudes | Ambos | El alumno ve las suyas; el tutor acepta o rechaza las recibidas |

---

## Requisitos técnicos y cómo se cubren

La arquitectura y los contratos ya están listos; la implementación de cada pantalla está
pendiente y se hará según los checklists por rol.

| Requisito | Cómo se cumple |
|---|---|
| Entrada y mínimo 4 pantallas | Splash, selección de rol, catálogo, detalle, formulario y panel (6) |
| Listado con búsqueda o filtros | Catálogo con `TutoresProvider` |
| Detalle que recibe argumentos | Detalle del tutor con el `id` como argumento |
| Estado compartido con Provider | `SesionProvider`, `TutoresProvider` y `SolicitudesProvider` |
| Tema global y 2 componentes reutilizables | `core/theme` y `core/widgets` |
| Assets propios en `pubspec.yaml` | `assets/images` (logo y fotos de tutores) |
| Model y Repository | `models/` y `repositories/` |
| Validaciones en formularios | Formulario de solicitud (campos obligatorios, longitud del mensaje, horario elegido) |

---

## Cómo ejecutar el proyecto

### Requisitos

- Flutter **3.47.2** o superior (Dart **3.13.2**). El `pubspec.yaml` declara `sdk: ^3.12.1`
  porque el código usa *dot shorthands* (`.fromSeed(...)`, `.center`); una versión anterior no
  lo compila.
- Android SDK para generar el APK.
- En Windows se puede compilar `android`, `web` y `windows`; `ios`, `macos` y `linux` no son
  compilables en este entorno.

### Comandos

```powershell
# Instalar dependencias (obligatorio antes de analizar, testear o ejecutar)
flutter pub get

# Análisis estático y pruebas
flutter analyze
flutter test

# Ejecutar en escritorio o en el navegador
flutter run -d windows
flutter run -d edge

# Generar el APK de demostración
flutter build apk --debug
```

> No hay Chrome instalado en el equipo del proyecto; para web se usa **Edge** (`-d edge`).

---

## Estado del proyecto

**Actualizado:** 4 de noviembre de 2026.

`main` tiene la **base técnica** de la arquitectura: modelos, contratos, repositorios mock,
providers, rutas y arranque con `MultiProvider`. Las pantallas son **placeholders a propósito**:
el diseño en Figma y la implementación de cada función están pendientes y corresponden a los
checklists por rol.

| Elemento | Estado |
|---|---|
| Estructura de carpetas y contratos | ✅ Listo |
| Modelos con `toMap`/`fromMap` | ✅ Listo |
| Repositorios mock | ✅ Listo |
| Providers y `MultiProvider` | ✅ Listo |
| Rutas nombradas con argumentos | ✅ Listo |
| Tema global | 🟡 Tema base solo para compilar (Rol 1) |
| Componentes reutilizables | ⏳ Pendiente (Rol 1) |
| Assets y declaración en `pubspec.yaml` | ⏳ Pendiente (Rol 1) |
| Splash y selección de rol | 🟡 Funcionales, sin diseño final (Rol 1) |
| Catálogo y detalle del tutor | ⏳ Placeholder (Rol 3) |
| Formulario y panel de solicitudes | ⏳ Placeholder (Rol 2) |
| Test de la app (reemplaza el del contador) | 🟡 1 prueba de arranque |
| `AI_LOG.md` y guion de demo | ⏳ Pendiente |

---

## Etapa 2 (backlog)

Lo que cambia: se agrega una implementación de cada repositorio con Firebase y se ajusta la línea
de `main.dart` que elige la implementación, junto con las dependencias de Firebase Auth y
Firestore. Lo que **no** cambia: pantallas, Providers y rutas.

Pendientes registrados:

- Conectar **Firebase Auth** (login real, no simulado).
- Migrar los repositorios a **Firestore**.
- Rol **Admin** con aprobación de perfiles.
- **Notificaciones** cuando cambia el estado de una solicitud.
- Permiso de **INTERNET** en el manifiesto de `release`.
- Cambiar el `applicationId` de `com.example.app_tutorias`.
- Ideas futuras: chat o videollamada dentro de la app.

---

## Equipo y roles

Los roles pueden rotar. Regla de la rúbrica: **los tres programan** y cada uno es responsable
principal de una función completa (pantalla, lógica y datos).

| Rol | Responsabilidad principal | Función de código |
|---|---|---|
| **Rol 1 — Diseño UI/UX (Eri)** | Wireframes, sistema de diseño, tema global, 2 componentes reutilizables, consistencia visual en los PR | Entrada y sesión: Splash, selección de rol, `SesionProvider` y `AuthRepository` mock |
| **Rol 2 — Arquitectura y Git** | Estructura, contratos, rutas, `MultiProvider`, revisión de PR, APK, README técnico | Solicitudes: formulario con validaciones y panel por rol |
| **Rol 3 — Coordinación y documentación** | Documento de definición, validación con usuarios, README, `AI_LOG.md`, guion de demo | Tutores: catálogo con búsqueda/filtros y detalle con argumentos |

**Orden de dependencias:** Rol 2 publica modelos y contratos antes de que los demás empiecen sus
pantallas. Rol 1 entrega tema y componentes antes de que se construyan las pantallas.

---

## Convenciones de Git

- `main` **siempre compila**. Nadie hace push directo a `main`.
- Una rama por función: `feature/entrada`, `feature/tutores`, `feature/solicitudes`, más una
  para la configuración inicial.
- Cada pull request debe ser revisado por al menos otra persona antes de unirse a `main`.
- Mensajes de commit descriptivos: qué se hizo y por qué.
- Hacer `pull` antes de empezar a trabajar.
- Avisar antes de tocar archivos compartidos: `pubspec.yaml`, `main.dart` y `core/routes`.
- Antes de abrir un PR: `flutter analyze` sin issues y `flutter test` en verde.

---

## Decisiones abiertas

| Tema | Estado |
|---|---|
| Nombre definitivo de la app, logo y paleta | Provisional: "App Tutorías"; diseño pendiente (Rol 1) |
| Confirmar que el rol Admin queda fuera del MVP | Propuesto: fuera |
| Paquete de estado | Decidido: `provider` (`MultiProvider`) |
| Rutas nombradas (propuesta) o un paquete como `go_router` | Decidido: rutas nombradas (`core/routes`) |
| Datos de ejemplo: lista fija en código o JSON en `assets/data` | Decidido: lista fija en `repositories/mock/mock_data.dart` |
| Filtros del catálogo además de la búsqueda por materia | Pendiente de definir (Rol 3) |

---

## Uso de inteligencia artificial

El equipo registra cada uso de IA en un archivo `AI_LOG.md` (aún por crear) con **fecha, qué se
preguntó y qué se adaptó**. Reglas acordadas:

- No se pega código que no se entienda.
- La IA no genera pantallas, módulos o funciones completas.
- Cualquier código tomado de tutoriales, foros o repositorios se cita aquí y en los commits.

---

## Licencia

Proyecto académico de la clase de Móviles-UPMH. Sin licencia definida por ahora.
