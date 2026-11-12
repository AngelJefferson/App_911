// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

class Evento {
  final int? id;
  final String fecha; // ISO 8601
  final String titulo;
  final String descripcion;
  final String? fotoPath;

  Evento({
    this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    this.fotoPath,
  });

  // Objeto -> Map (para guardar en SQLite)
  Map<String, dynamic> toMap() => {
        'id': id,
        'fecha': fecha,
        'titulo': titulo,
        'descripcion': descripcion,
        'fotoPath': fotoPath,
      };

  // Map -> Objeto (al leer de SQLite)
  factory Evento.fromMap(Map<String, dynamic> m) => Evento(
        id: m['id'] as int?,
        fecha: m['fecha'] as String,
        titulo: m['titulo'] as String,
        descripcion: m['descripcion'] as String,
        fotoPath: m['fotoPath'] as String?,
      );
}