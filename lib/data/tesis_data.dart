import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tesis.dart';

class TesisService {
  final CollectionReference tesisCollection = FirebaseFirestore.instance.collection('tesis');

  Future<void> addTesis(Tesis nuevaTesis) {
    return tesisCollection.add({
      'titulo': nuevaTesis.titulo,
      'descripcion': nuevaTesis.descripcion,
      'archivo': nuevaTesis.archivo,
      'estado': nuevaTesis.estado,
      'autor': nuevaTesis.autor,
      'evaluador': nuevaTesis.evaluador,
      'comentario': nuevaTesis.comentario,
    });
  }

  Stream<List<Tesis>> getTesis() {
    return tesisCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Tesis(
              titulo: doc['titulo'],
              descripcion: doc['descripcion'],
              archivo: doc['archivo'],
              estado: doc['estado'],
              autor: doc['autor'],
              evaluador: doc['evaluador'],
              comentario: doc['comentario'],
            ))
        .toList());
  }
}
