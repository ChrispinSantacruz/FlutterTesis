import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tesis.dart';

class TesisService {
  final CollectionReference tesisCollection = FirebaseFirestore.instance.collection('tesis');

  // Método para agregar una nueva tesis y devolver el DocumentReference
  Future<DocumentReference> addTesis(Tesis nuevaTesis) async {
    try {
      final tesisRef = await tesisCollection.add({
        'titulo': nuevaTesis.titulo,
        'descripcion': nuevaTesis.descripcion,
        'archivo': nuevaTesis.archivo,
        'estado': nuevaTesis.estado,
        'autor': nuevaTesis.autor,
        'evaluador': nuevaTesis.evaluador,
        'comentario': nuevaTesis.comentario,
      });
      print('Tesis agregada exitosamente');
      return tesisRef;
    } catch (e) {
      print('Error al agregar tesis: $e');
      rethrow;
    }
  }

  // Método para actualizar una tesis existente
  Future<void> updateTesis(Tesis tesis) async {
    try {
      await tesisCollection.doc(tesis.id).update({
        'titulo': tesis.titulo,
        'descripcion': tesis.descripcion,
        'archivo': tesis.archivo,
        'estado': tesis.estado,
        'autor': tesis.autor,
        'evaluador': tesis.evaluador,
        'comentario': tesis.comentario,
      });
      print('Tesis actualizada exitosamente');
    } catch (e) {
      print('Error al actualizar tesis: $e');
      rethrow;
    }
  }
}
