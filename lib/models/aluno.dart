class Aluno {
  int? codigo;
  String nome;

  Aluno({
    this.codigo,
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
