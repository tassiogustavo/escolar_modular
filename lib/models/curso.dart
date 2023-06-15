class Curso {
  int? codigo;
  String descricao;
  String ementa;

  Curso({
    this.codigo,
    required this.descricao,
    required this.ementa,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'ementa': ementa,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      codigo: map['codigo'],
      descricao: map['descricao'],
      ementa: map['ementa'],
    );
  }
}
