// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:app_911/database/db_helper.dart';
import 'package:app_911/models/evento.dart';
import 'package:app_911/utils/formato.dart';
import 'package:app_911/widgets/pie_autor.dart';

class FormularioEventoPage extends StatefulWidget {
  const FormularioEventoPage({super.key});

  @override
  State<FormularioEventoPage> createState() => _FormularioEventoPageState();
}

class _FormularioEventoPageState extends State<FormularioEventoPage> {
  final _titulo = TextEditingController();
  final _descripcion = TextEditingController();
  final _picker = ImagePicker();
  DateTime _fecha = DateTime.now();
  File? _foto;

  Future<void> _elegirFecha() async {
    final f = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (f != null) setState(() => _fecha = f);
  }

  Future<void> _tomarFoto(ImageSource origen) async {
    final x = await _picker.pickImage(source: origen, imageQuality: 70);
    if (x != null) setState(() => _foto = File(x.path));
  }

  void _opcionesFoto() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Cámara'),
            onTap: () {
              Navigator.pop(context);
              _tomarFoto(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galería'),
            onTap: () {
              Navigator.pop(context);
              _tomarFoto(ImageSource.gallery);
            },
          ),
        ]),
      ),
    );
  }

  Future<void> _guardar() async {
    if (_titulo.text.trim().isEmpty || _descripcion.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Título y descripción son obligatorios')),
      );
      return;
    }

    
    String? rutaFinal;
    if (_foto != null) {
      final dir = await getApplicationDocumentsDirectory();
      final nombre = 'evento_${DateTime.now().millisecondsSinceEpoch}.jpg';
      rutaFinal = (await _foto!.copy(p.join(dir.path, nombre))).path;
    }

    await DbHelper.instance.insertar(Evento(
      fecha: _fecha.toIso8601String(),
      titulo: _titulo.text.trim(),
      descripcion: _descripcion.text.trim(),
      fotoPath: rutaFinal,
    ));
    if (mounted) Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _titulo.dispose();
    _descripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo evento')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OutlinedButton.icon(
            onPressed: _elegirFecha,
            icon: const Icon(Icons.calendar_today),
            label: Text('Fecha: ${formatearFecha(_fecha.toIso8601String())}'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titulo,
            decoration: const InputDecoration(
                labelText: 'Título', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descripcion,
            maxLines: 5,
            decoration: const InputDecoration(
                labelText: 'Descripción', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _opcionesFoto,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _foto == null
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_a_photo, size: 40),
                          Text('Agregar foto'),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(_foto!,
                          fit: BoxFit.cover, width: double.infinity),
                    ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _guardar,
            icon: const Icon(Icons.save),
            label: const Text('Guardar evento'),
          ),
          const PieAutor(),
        ],
      ),
    );
  }
}