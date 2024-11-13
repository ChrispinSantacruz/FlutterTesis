import 'package:flutter/material.dart';
import '../models/tesis.dart';
import '../services/tesis_services.dart';

class DetalleTesisScreen extends StatefulWidget {
  final Tesis tesis;
  final String role;
  final String evaluador;

  const DetalleTesisScreen({
    required this.tesis,
    required this.role,
    required this.evaluador,
    Key? key,
  }) : super(key: key);

  @override
  DetalleTesisScreenState createState() => DetalleTesisScreenState();
}

class DetalleTesisScreenState extends State<DetalleTesisScreen> {
  final TextEditingController _comentarioController = TextEditingController();

  void _cambiarEstado(String nuevoEstado) async {
    setState(() {
      widget.tesis.estado = nuevoEstado;
      if (nuevoEstado == 'rechazada') {
        widget.tesis.comentario = _comentarioController.text;
      }
      widget.tesis.evaluador = widget.evaluador;
    });

    await TesisService().updateTesis(widget.tesis);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(nuevoEstado == 'aprobada'
            ? 'Tesis aprobada correctamente'
            : 'Tesis rechazada con comentario'),
      ));
      Navigator.pop(context);
    }
  }

  void _mostrarDialogoRechazo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rechazar Tesis'),
          content: TextField(
            controller: _comentarioController,
            decoration: const InputDecoration(labelText: 'Añadir comentario'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _cambiarEstado('rechazada');
                Navigator.pop(context);
              },
              child: const Text('Rechazar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Tesis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${widget.tesis.titulo}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Descripción:', style: TextStyle(fontSize: 18)),
            Text(
              widget.tesis.descripcion,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            Text('Archivo: ${widget.tesis.archivo}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Estado actual: ', style: TextStyle(fontSize: 18)),
                Chip(
                  label: Text(
                    widget.tesis.estado.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: widget.tesis.estado == 'aprobada'
                      ? Colors.green
                      : widget.tesis.estado == 'rechazada'
                          ? Colors.red
                          : Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (widget.tesis.evaluador != null && widget.tesis.evaluador!.isNotEmpty)
              Text('Calificada por: ${widget.tesis.evaluador}', style: const TextStyle(fontSize: 16)),
            if (widget.tesis.estado == 'rechazada' && widget.tesis.comentario != null)
              Text('Comentario del Rechazo: ${widget.tesis.comentario}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            widget.role == 'docente'
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check),
                            label: const Text('Aprobar'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () => _cambiarEstado('aprobada'),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.close),
                            label: const Text('Rechazar'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () => _mostrarDialogoRechazo(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text('Descargar PDF'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Descargando ${widget.tesis.archivo}'),
                          ));
                        },
                      ),
                    ],
                  )
                : ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('Descargar PDF'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Descargando ${widget.tesis.archivo}'),
                      ));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
