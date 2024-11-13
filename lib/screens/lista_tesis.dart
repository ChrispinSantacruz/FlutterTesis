import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/tesis.dart';
import '../services/tesis_services.dart';

class AgregarTesisScreen extends StatefulWidget {
  final Function(Tesis) onAgregarTesis;
  final String username;

  const AgregarTesisScreen(
      {required this.onAgregarTesis, required this.username, Key? key})
      : super(key: key);

  @override
  _AgregarTesisScreenState createState() => _AgregarTesisScreenState();
}

class _AgregarTesisScreenState extends State<AgregarTesisScreen> {
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
      if (kIsWeb) {
        setState(() {
          _archivoBytes = result.files.single.bytes;
          _archivo = result.files.single.name;
        });
      } else {
        setState(() {
          _archivo = result.files.single.path;
        });
      }
    }
  }

  void _guardarTesis() {
    if (_tituloController.text.isNotEmpty &&
        _descripcionController.text.isNotEmpty &&
        (_archivo != null || _archivoBytes != null)) {
      Tesis nuevaTesis = Tesis(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        archivo: _archivo!,
        autor: widget.username,
      );

      TesisService().addTesis(nuevaTesis); // Conexión a Firebase
      widget.onAgregarTesis(nuevaTesis);
      Navigator.pop(context);
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
              decoration:
                  const InputDecoration(labelText: 'Título de la Tesis'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _seleccionarArchivo,
              child: Text(_archivo == null
                  ? 'Seleccionar Archivo PDF'
                  : 'Archivo: $_archivo'),
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
