# 🚨 App 911 - Registro de Eventos de Emergencia

Aplicación móvil desarrollada con **Flutter** para que los equipos de emergencia del 911 registren información después de cada misión, ayuda o evento. Los datos se guardan **localmente** en el dispositivo, sin necesidad de internet.

> **Autor:** TU NOMBRE Y APELLIDO
> **Matrícula:** TU MATRÍCULA
> **Institución:** ITLA - Instituto Tecnológico de las Américas
> **Asignatura:** Introducción al Desarrollo de Aplicaciones Móviles
> **Videotutorial:** [Ver en YouTube](PEGA_AQUI_EL_LINK_DEL_VIDEO)

---

## 📋 Características

- 📅 **Fecha** del evento (selector de calendario).
- 📝 **Título** del evento.
- 🗒️ **Descripción** detallada.
- 📸 **Foto** tomada con la cámara o elegida desde la galería.
- 💾 **Almacenamiento local** con SQLite (los datos persisten al cerrar la app).
- 📋 **Lista de eventos** registrados, ordenados del más reciente al más antiguo.
- 🔍 **Pantalla de detalle** con la foto y toda la información del evento.
- 🗑️ **Eliminar** eventos con confirmación.

---

## 🛠️ Tecnologías y paquetes

| Tecnología | Uso |
|---|---|
| [Flutter](https://flutter.dev) / Dart | Framework y lenguaje |
| [sqflite](https://pub.dev/packages/sqflite) | Base de datos SQLite local |
| [path](https://pub.dev/packages/path) | Construcción de rutas de archivos |
| [path_provider](https://pub.dev/packages/path_provider) | Acceso a la carpeta privada de la app |
| [image_picker](https://pub.dev/packages/image_picker) | Cámara y galería |

---

## 📁 Estructura del proyecto

```
app_911/
├── pubspec.yaml
└── lib/
    ├── main.dart                         # Punto de entrada y configuración de la app
    ├── constants.dart                    # Datos del autor (nombre y matrícula)
    ├── models/
    │   └── evento.dart                   # Modelo Evento (toMap / fromMap)
    ├── database/
    │   └── db_helper.dart                # Acceso a SQLite: insertar, listar, eliminar
    ├── utils/
    │   └── formato.dart                  # Formateo de fechas
    ├── widgets/
    │   └── pie_autor.dart                # Pie reutilizable con nombre y matrícula
    └── screens/
        ├── lista_eventos_page.dart       # Lista de eventos
        ├── formulario_evento_page.dart   # Registro de un nuevo evento
        └── detalle_evento_page.dart      # Detalle del evento con foto
```

---

## 🧠 Cómo funciona

1. **Modelo (`Evento`)**: representa un evento con `id`, `fecha`, `titulo`, `descripcion` y `fotoPath`. Incluye `toMap()` y `fromMap()` para convertir entre objeto y fila de la base de datos.
2. **Base de datos (`DbHelper`)**: patrón singleton que abre `emergencias911.db`, crea la tabla `eventos` y expone `insertar`, `listar` y `eliminar`.
3. **Fotos**: la imagen no se guarda dentro de la base de datos. Se copia a la carpeta de documentos de la app y solo se almacena su **ruta** como texto. Así la foto no se pierde aunque el archivo temporal de la cámara se borre.
4. **Pantalla de lista**: carga los eventos en `initState` y los muestra con `ListView.builder`. Al volver del formulario o del detalle, recarga los datos.
5. **Formulario**: valida que título y descripción no estén vacíos, copia la foto y guarda el evento.
6. **Detalle**: muestra la foto, el título, la fecha y la descripción, y permite eliminar el registro.

---

## ✅ Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (verifica con `flutter doctor`).
- Android Studio con el Android SDK.
- Un teléfono Android con **Depuración USB** activada, o un emulador Android.

---

## 🚀 Cómo ejecutar el proyecto

```bash
# 1. Clonar el repositorio
git clone https://github.com/AngelJefferson/App_911.git
cd App_911

# 2. Descargar las dependencias
flutter pub get

# 3. Ver los dispositivos disponibles
flutter devices

# 4. Ejecutar la app en un dispositivo Android
flutter run -d ID_DEL_DISPOSITIVO
```

Reemplaza `ID_DEL_DISPOSITIVO` por el id que aparece en `flutter devices` (por ejemplo `emulator-5554`).

> ⚠️ La app está pensada para **Android e iOS**. No la ejecutes en Chrome, Edge ni Windows, porque `sqflite` e `image_picker` están diseñados para móvil.

### Generar el APK

```bash
flutter build apk --release
```

El archivo se genera en `build/app/outputs/flutter-apk/app-release.apk` y puede instalarse en cualquier teléfono Android.

### Permisos en iOS

Si compilas para iOS, agrega estas claves en `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Se necesita la cámara para tomar fotos de los eventos.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Se necesita acceso a la galería para adjuntar fotos a los eventos.</string>
```

---

## 🧪 Cómo probar la app

1. Abre la app: la lista debe mostrar "No hay eventos registrados".
2. Pulsa **Nuevo evento** y completa fecha, título, descripción y foto.
3. Guarda y verifica que aparece en la lista con su miniatura.
4. Toca el evento y comprueba que se ven los detalles y la foto.
5. Cierra la app por completo y ábrela de nuevo: los datos deben seguir ahí.
6. Elimina un evento desde la pantalla de detalle.

---

## 🔧 Solución de problemas

| Problema | Solución |
|---|---|
| `Target of URI doesn't exist: package:app_911/...` | Ejecuta `flutter pub get` y verifica que el nombre del proyecto en `pubspec.yaml` sea `app_911`. |
| La app no compila tras cambios | `flutter clean` y luego `flutter pub get`. |
| El emulador no inicia | Verifica que tengas una imagen de sistema x86_64 instalada y la virtualización activada. |
| La foto no aparece al reiniciar | Revisa que la imagen se copie a la carpeta de la app antes de guardar. |

---

## 👤 Autor

**TU NOMBRE Y APELLIDO** - Matrícula **TU MATRÍCULA**
Estudiante de Desarrollo de Software en el ITLA.

---

*Proyecto académico desarrollado como parte de la asignatura Introducción al Desarrollo de Aplicaciones Móviles.*
