import 'package:flutter/material.dart';
import '../models/tesis.dart';
import '../data/tesis_data.dart';  
import 'detalle_tesis.dart';

class VerTesisScreen extends StatelessWidget {
  const VerTesisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TesisService _tesisService = TesisService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Tesis'),
      ),
      body: StreamBuilder<List<Tesis>>(
        stream: _tesisService.getTesis(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final listaDeTesis = snapshot.data!;

          return ListView.builder(
            itemCount: listaDeTesis.length,
            itemBuilder: (context, index) {
              Tesis tesis = listaDeTesis[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tesis.titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(tesis.descripcion, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      const SizedBox(height: 12),
                      Text('Estado: ${tesis.estado}'),
                      Text('Autor: ${tesis.autor}'),
                      if (tesis.evaluador != null && tesis.evaluador!.isNotEmpty)
                        Text('Calificada por: ${tesis.evaluador}'), 
                      if (tesis.estado == 'rechazada' && tesis.comentario != null)
                        Text('Comentario: ${tesis.comentario}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tesis.estado == 'aprobada' ? Colors.green : Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleTesisScreen(
                                tesis: tesis,
                                role: 'viewer',  
                                evaluador: tesis.evaluador ?? '',  
                              ),
                            ),
                          );
                        },
                        child: Text(
                          tesis.estado == 'aprobada' ? 'Ver Tesis Aprobada' : 'Ver Detalles',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
