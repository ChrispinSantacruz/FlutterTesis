import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/tesis.dart';
import '../services/tesis_services.dart';

class AgregarTesisScreen extends StatefulWidget {
  final Function(Tesis) onAgregarTesis;
  final String username;

  const AgregarTesisScreen({
    required this.onAgregarTesis,
    required this.username,
    super.key,
  });

  @override
  AgregarTesisScreenState createState() => AgregarTesisScreenState();
}

class AgregarTesisScreenState extends State<AgregarTesisScreen> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  String? _archivo;
  Uint8List? _archivoBytes;

  void _seleccionarArchivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        if (kIsWeb) {
          _archivoBytes = result.files.single.bytes;
          _archivo = result.files.single.name;
        } else {
          _archivo = result.files.single.path;
        }
      });
    }
  }

  void _guardarTesis() async {
    if (_tituloController.text.isNotEmpty &&
        _descripcionController.text.isNotEmpty &&
        (_archivo != null || _archivoBytes != null)) {
      
      // Crear una nueva instancia de Tesis sin ID, ya que será asignado por Firebase
      final nuevaTesis = Tesis(
        id: '', // ID temporal
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        archivo: _archivo!,
        autor: widget.username,
      );

      // Guardar la tesis en Firebase y obtener el ID generado
      final tesisRef = await TesisService().addTesis(nuevaTesis);
      nuevaTesis.id = tesisRef.id; // Asigna el ID generado por Firebase
      
      widget.onAgregarTesis(nuevaTesis);

      // Verificar que el widget esté montado antes de navegar
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Tesis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título de la Tesis'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _seleccionarArchivo,
              child: Text(
                _archivo == null
                    ? 'Seleccionar Archivo PDF'
                    : 'Archivo: $_archivo',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarTesis,
              child: const Text('Guardar Tesis'),
            ),
          ],
        ),
      ),
    );
  }
}
