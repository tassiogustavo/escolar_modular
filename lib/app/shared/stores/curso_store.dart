// ignore_for_file: library_private_types_in_public_api

import 'package:escolar_modular/models/curso.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'curso_store.g.dart';

class CursoStore = _CursoStoreBase with _$CursoStore;

abstract class _CursoStoreBase with Store {
  final DatabaseRepository _databaseRepository =
      Modular.get<DatabaseRepository>();

  @observable
  ObservableList<Curso> cursos = ObservableList<Curso>();

  @observable
  List<String> listMatriculados = [];

  @action
  Future<void> fetchTodos() async {
    final List<Curso> fetchedTodos = await _databaseRepository.getCursos();
    cursos = ObservableList<Curso>.of(fetchedTodos);
  }

  @action
  Future<void> fetchByCurso(int codigo) async {
    final fetchByCurso = await _databaseRepository.getAlunosByCurso(codigo);
    listMatriculados = List<String>.of(fetchByCurso);
  }
}
