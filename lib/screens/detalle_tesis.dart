import 'package:flutter/material.dart';
import '../models/tesis.dart';

class DetalleTesisScreen extends StatefulWidget {
  final Tesis tesis;
  final String role;  
  final String evaluador;  

  DetalleTesisScreen({required this.tesis, required this.role, required this.evaluador});

  @override
  _DetalleTesisScreenState createState() => _DetalleTesisScreenState();
}

class _DetalleTesisScreenState extends State<DetalleTesisScreen> {
  TextEditingController _comentarioController = TextEditingController();

  void _cambiarEstado(String nuevoEstado) {
    setState(() {
      widget.tesis.estado = nuevoEstado;
      if (nuevoEstado == 'rechazada') {
        widget.tesis.comentario = _comentarioController.text;  
      }
      widget.tesis.evaluador = widget.evaluador;  
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(nuevoEstado == 'aprobada'
          ? 'Tesis aprobada correctamente'
          : 'Tesis rechazada con comentario'),
    ));
    Navigator.pop(context); 
  }

  void _mostrarDialogoRechazo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rechazar Tesis'),
          content: TextField(
            controller: _comentarioController,
            decoration: InputDecoration(labelText: 'Añadir comentario'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Rechazar'),
              onPressed: () {
                _cambiarEstado('rechazada');
                Navigator.pop(context);  
              },
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
        title: Text('Detalles de la Tesis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${widget.tesis.titulo}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Descripción:', style: TextStyle(fontSize: 18)),
            Text(widget.tesis.descripcion, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 20),
            Text('Archivo: ${widget.tesis.archivo}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Estado actual: ', style: TextStyle(fontSize: 18)),
                Chip(
                  label: Text(widget.tesis.estado.toUpperCase(), style: TextStyle(color: Colors.white)),
                  backgroundColor: widget.tesis.estado == 'aprobada'
                      ? Colors.green
                      : widget.tesis.estado == 'rechazada'
                          ? Colors.red
                          : Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 20),
            if (widget.tesis.evaluador != null && widget.tesis.evaluador!.isNotEmpty)
              Text('Calificada por: ${widget.tesis.evaluador}', style: TextStyle(fontSize: 16)),
            if (widget.tesis.estado == 'rechazada' && widget.tesis.comentario != null)
              Text('Comentario del Rechazo: ${widget.tesis.comentario}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            widget.role == 'docente'
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.check),
                            label: Text('Aprobar'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () => _cambiarEstado('aprobada'),
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.close),
                            label: Text('Rechazar'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () => _mostrarDialogoRechazo(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: Icon(Icons.download),
                        label: Text('Descargar PDF'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Descargando ${widget.tesis.archivo}'),
                          ));
                        },
                      ),
                    ],
                  )
                : ElevatedButton.icon(
                    icon: Icon(Icons.download),
                    label: Text('Descargar PDF'),
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
