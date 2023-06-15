import 'package:escolar_modular/models/curso_aluno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../models/aluno.dart';
import '../../../models/curso.dart';
import '../../../repositories/database_repository.dart';

class MatriculaPage extends StatefulWidget {
  const MatriculaPage({super.key, required this.aluno});

  final Aluno aluno;

  @override
  State<MatriculaPage> createState() => _MatriculaPageState();
}

class _MatriculaPageState extends State<MatriculaPage> {
  final DatabaseRepository _databaseRepository =
      Modular.get<DatabaseRepository>();
  List<Curso> cursos = [];
  List<Map<String, dynamic>> cursosMatriculados = [];
  List<Map<String, dynamic>> qtdAlunosPorCurso = [];

  @override
  void initState() {
    _getCursos();
    _getCursoAlunos();
    _getQtdAlunosPorCurso();
    super.initState();
  }

  void _getCursos() {
    _databaseRepository.getCursos().then((value) {
      setState(() {
        cursos = value;
      });
    });
  }

  void _getCursoAlunos() {
    _databaseRepository
        .getCursosMatriculados(widget.aluno.codigo!)
        .then((value) {
      setState(() {
        cursosMatriculados = value;
      });
    });
  }

  void _getQtdAlunosPorCurso() {
    _databaseRepository.getQtdAlunosPorCurso().then((value) {
      setState(() {
        qtdAlunosPorCurso = value;
      });
    });
  }

  bool _verifiInscricao(int codigo) {
    for (var map in cursosMatriculados) {
      if (map.containsValue(codigo)) {
        return true;
      }
    }
    return false;
  }

  Text _verificaQtdInscritos(int index) {
    if (qtdAlunosPorCurso.isNotEmpty) {
      if (qtdAlunosPorCurso[index]['qtd_inscritos'] < 5) {
        return const Text(
          'turma não fechada',
          style: TextStyle(fontSize: 15, color: Colors.orange),
        );
      } else if (qtdAlunosPorCurso[index]['qtd_inscritos'] == 10) {
        return const Text(
          'turma cheia',
          style: TextStyle(fontSize: 15, color: Colors.green),
        );
      } else {
        return const Text('');
      }
    }
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrícula: ${widget.aluno.nome}'),
      ),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              cursos[index].descricao,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: _verificaQtdInscritos(index),
            value: _verifiInscricao(cursos[index].codigo!),
            onChanged: (val) {
              if (_verifiInscricao(cursos[index].codigo!)) {
                _databaseRepository.deleteCursoAlunos(
                    widget.aluno.codigo!, cursos[index].codigo!);
              } else {
                if (qtdAlunosPorCurso[index]['qtd_inscritos'] < 10) {
                  if (cursosMatriculados.length == 3) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "${widget.aluno.nome} já está matrículado no máximo de 3 Cursos",
                        textAlign: TextAlign.center,
                      ),
                    ));
                  } else {
                    CursoAluno cursoAluno = CursoAluno(
                        codigoAluno: widget.aluno.codigo!,
                        codigoCurso: cursos[index].codigo!);
                    _databaseRepository.insertCursoAlunos(cursoAluno);
                  }
                }
              }

              _getCursoAlunos();
              _getQtdAlunosPorCurso();
            },
          );
        },
      ),
    );
  }
}
