class CursoAluno {
  int? codigo;
  int codigoAluno;
  int codigoCurso;

  CursoAluno({
    this.codigo,
    required this.codigoAluno,
    required this.codigoCurso,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'codigo_aluno': codigoAluno,
      'codigo_curso': codigoCurso,
    };
  }

  factory CursoAluno.fromMap(Map<String, dynamic> map) {
    return CursoAluno(
      codigo: map['codigo'],
      codigoAluno: map['codigo_aluno'],
      codigoCurso: map['codigo_curso'],
    );
  }
}
