class Tesis {
  String titulo;
  String descripcion;
  String archivo;
  String estado;  
  String autor;   
  String? evaluador;  
  String? comentario;  

  Tesis({
    required this.titulo,
    required this.descripcion,
    required this.archivo,
    this.estado = 'pendiente',
    required this.autor,
    this.evaluador,
    this.comentario,
  });
}
