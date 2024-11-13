import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tesis.dart';

class TesisService {
  // Referencia a la colección 'tesis' en Firestore
  final CollectionReference tesisCollection =
      FirebaseFirestore.instance.collection('tesis');

  // Método para agregar una nueva tesis
  Future<void> addTesis(Tesis nuevaTesis) async {
    try {
      await tesisCollection.add({
        'titulo': nuevaTesis.titulo,
        'descripcion': nuevaTesis.descripcion,
        'archivo': nuevaTesis.archivo,
        'estado': nuevaTesis.estado,
        'autor': nuevaTesis.autor,
        'evaluador': nuevaTesis.evaluador,
        'comentario': nuevaTesis.comentario,
      });
      print('Tesis agregada exitosamente');
    } catch (e) {
      print('Error al agregar tesis: $e');
    }
  }

  // Método para obtener las tesis como un stream
  Stream<List<Tesis>> getTesis() {
    return tesisCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Tesis(
                titulo: doc['titulo'],
                descripcion: doc['descripcion'],
                archivo: doc['archivo'],
                estado: doc['estado'],
                autor: doc['autor'],
                evaluador: doc['evaluador'],
                comentario: doc['comentario'],
              );
            }).toList());
  }
}
