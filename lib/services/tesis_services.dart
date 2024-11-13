import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tesis.dart';

class TesisService {
  final CollectionReference tesisCollection = FirebaseFirestore.instance.collection('tesis');

  // Método para agregar una nueva tesis y devolver el DocumentReference
  Future<DocumentReference> addTesis(Tesis nuevaTesis) async {
    final tesisRef = await tesisCollection.add(nuevaTesis.toMap());
    return tesisRef;
  }

  // Obtener una lista de tesis en tiempo real
  Stream<List<Tesis>> getTesis() {
    return tesisCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Tesis.fromDocumentSnapshot(doc)).toList();
    });
  }

  // Actualizar una tesis existente
  Future<void> updateTesis(Tesis tesis) async {
    await tesisCollection.doc(tesis.id).update(tesis.toMap());
  }
}
