// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_911/database/db_helper.dart';
import 'package:app_911/models/evento.dart';
import 'package:app_911/screens/detalle_evento_page.dart';
import 'package:app_911/screens/formulario_evento_page.dart';
import 'package:app_911/utils/formato.dart';
import 'package:app_911/widgets/pie_autor.dart';

class ListaEventosPage extends StatefulWidget {
  const ListaEventosPage({super.key});

  @override
  State<ListaEventosPage> createState() => _ListaEventosPageState();
}

class _ListaEventosPageState extends State<ListaEventosPage> {
  List<Evento> _eventos = [];

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final datos = await DbHelper.instance.listar();
    if (mounted) setState(() => _eventos = datos);
  }

  Future<void> _nuevo() async {
    final guardado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const FormularioEventoPage()),
    );
    if (guardado == true) _cargar();
  }

  Future<void> _abrirDetalle(Evento e) async {
    final cambio = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => DetalleEventoPage(evento: e)),
    );
    if (cambio == true) _cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('911 - Registro de eventos'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _eventos.isEmpty
          ? const Center(child: Text('No hay eventos registrados'))
          : ListView.builder(
              itemCount: _eventos.length,
              itemBuilder: (_, i) {
                final e = _eventos[i];
                final hayFoto =
                    e.fotoPath != null && File(e.fotoPath!).existsSync();
                return ListTile(
                  leading: hayFoto
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(File(e.fotoPath!),
                              width: 56, height: 56, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.emergency, size: 40),
                  title: Text(e.titulo),
                  subtitle: Text(formatearFecha(e.fecha)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _abrirDetalle(e),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _nuevo,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo evento'),
      ),
      bottomNavigationBar: const SafeArea(child: PieAutor()),
    );
  }
}