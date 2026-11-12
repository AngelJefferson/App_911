// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:app_911/models/evento.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._();
  DbHelper._();

  Database? _db;

  Future<Database> get db async => _db ??= await _abrir();

  Future<Database> _abrir() async {
    final ruta = p.join(await getDatabasesPath(), 'emergencias911.db');
    return openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE eventos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fecha TEXT NOT NULL,
          titulo TEXT NOT NULL,
          descripcion TEXT NOT NULL,
          fotoPath TEXT
        )
      '''),
    );
  }

  Future<int> insertar(Evento e) async =>
      (await db).insert('eventos', e.toMap()..remove('id'));

  Future<List<Evento>> listar() async {
    final filas = await (await db).query('eventos', orderBy: 'fecha DESC');
    return filas.map(Evento.fromMap).toList();
  }

  Future<void> eliminar(int id) async =>
      (await db).delete('eventos', where: 'id = ?', whereArgs: [id]);
}