import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore para DocumentSnapshot

class Tesis {
  String id;
  String titulo;
  String descripcion;
  String archivo;
  String estado;
  String autor;
  String? evaluador;
  String? comentario;

  Tesis({
    required this.id, // Aseguramos que id esté siempre presente
    required this.titulo,
    required this.descripcion,
    required this.archivo,
    this.estado = 'pendiente',
    required this.autor,
    this.evaluador,
    this.comentario,
  });

  // Convertir desde DocumentSnapshot (para leer de Firebase)
  factory Tesis.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Tesis(
      id: doc.id, // Utilizamos el ID del documento
      titulo: doc['titulo'] ?? '',
      descripcion: doc['descripcion'] ?? '',
      archivo: doc['archivo'] ?? '',
      estado: doc['estado'] ?? 'pendiente',
      autor: doc['autor'] ?? '',
      evaluador: doc['evaluador'],
      comentario: doc['comentario'],
    );
  }

  // Convertir a Map (para escribir en Firebase)
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'archivo': archivo,
      'estado': estado,
      'autor': autor,
      'evaluador': evaluador,
      'comentario': comentario,
    };
  }
}
