// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_911/database/db_helper.dart';
import 'package:app_911/models/evento.dart';
import 'package:app_911/utils/formato.dart';
import 'package:app_911/widgets/pie_autor.dart';

class DetalleEventoPage extends StatelessWidget {
  final Evento evento;
  const DetalleEventoPage({super.key, required this.evento});

  Future<void> _eliminar(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar evento'),
        content: const Text('¿Seguro que deseas eliminar este registro?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar')),
        ],
      ),
    );
    if (ok == true) {
      await DbHelper.instance.eliminar(evento.id!);
      if (context.mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tieneFoto =
        evento.fotoPath != null && File(evento.fotoPath!).existsSync();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del evento'),
        actions: [
          IconButton(
            onPressed: () => _eliminar(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (tieneFoto)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(evento.fotoPath!), fit: BoxFit.cover),
            ),
          const SizedBox(height: 16),
          Text(evento.titulo,
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 6),
            Text(formatearFecha(evento.fecha)),
          ]),
          const Divider(height: 32),
          Text(evento.descripcion),
          const SizedBox(height: 24),
          const PieAutor(),
        ],
      ),
    );
  }
}