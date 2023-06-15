import 'package:escolar_modular/data/database_helper.dart';
import 'package:escolar_modular/models/curso_aluno.dart';

import '../models/aluno.dart';
import '../models/curso.dart';

class DatabaseRepository {
  final DatabaseHelper _databaseHelper;

  DatabaseRepository(this._databaseHelper);

  Future<List<Aluno>> getAlunos() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('alunos');
    return List.generate(maps.length, (index) {
      return Aluno.fromMap(maps[index]);
    });
  }

  Future<void> insertAluno(Aluno aluno) async {
    final db = await _databaseHelper.database;
    await db.insert('alunos', aluno.toMap());
  }

  Future<void> updateAluno(Aluno aluno) async {
    final db = await _databaseHelper.database;
    await db.update('alunos', aluno.toMap(),
        where: 'codigo = ?', whereArgs: [aluno.codigo]);
  }

  Future<void> deleteAluno(int codigo) async {
    final db = await _databaseHelper.database;
    await db.delete('alunos', where: 'codigo = ?', whereArgs: [codigo]);
  }

  //========================================================================

  Future<List<Curso>> getCursos() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('cursos');
    return List.generate(maps.length, (index) {
      return Curso.fromMap(maps[index]);
    });
  }

  Future<List<String>> getAlunosByCurso(int codigo) async {
    final db = await _databaseHelper.database;
    final res = await db.rawQuery('''
        SELECT a.nome from curso_aluno as ca INNER JOIN  alunos as a on ca.codigo_aluno = a.codigo WHERE ca.codigo_curso = ?;
        ''', [codigo]);

    List<String> alunosMatriculados = [];
    for (Map m in res) {
      alunosMatriculados.add(m.values.first);
    }
    return alunosMatriculados;
  }

  Future<void> insertCurso(Curso curso) async {
    final db = await _databaseHelper.database;
    await db.insert('cursos', curso.toMap());
  }

  Future<void> updateCurso(Curso curso) async {
    final db = await _databaseHelper.database;
    await db.update('cursos', curso.toMap(),
        where: 'codigo = ?', whereArgs: [curso.codigo]);
  }

  Future<void> deleteCurso(int codigo) async {
    final db = await _databaseHelper.database;
    await db.delete('cursos', where: 'codigo = ?', whereArgs: [codigo]);
  }

  //=======================================================================

  Future<List<Map<String, dynamic>>> getCursosMatriculados(int codigo) async {
    final db = await _databaseHelper.database;

    return await db.rawQuery(
        'SELECT c.codigo from curso_aluno as ca INNER JOIN  cursos as c on ca.codigo_curso = c.codigo WHERE ca.codigo_aluno = ?;',
        [codigo]);
  }

  Future<List<Map<String, dynamic>>> getQtdAlunosPorCurso() async {
    final db = await _databaseHelper.database;

    return await db
        .rawQuery('''SELECT c.codigo, COUNT(ca.codigo_aluno) as qtd_inscritos 
        FROM cursos c
        LEFT JOIN curso_aluno ca ON c.codigo = ca.codigo_curso
        GROUP BY c.codigo, c.descricao;''');
  }

  Future<void> insertCursoAlunos(CursoAluno cursoAluno) async {
    final db = await _databaseHelper.database;
    await db.insert('curso_aluno', cursoAluno.toMap());
  }

  Future<void> deleteCursoAlunos(int codigoAluno, int codigoCurso) async {
    final db = await _databaseHelper.database;
    await db.delete('curso_aluno',
        where: 'codigo_aluno = ? and codigo_curso = ?',
        whereArgs: [codigoAluno, codigoCurso]);
  }
}
