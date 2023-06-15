// ignore_for_file: library_private_types_in_public_api

import 'package:escolar_modular/models/aluno.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../repositories/database_repository.dart';

part 'aluno_store.g.dart';

class AlunoStore = _AlunoStoreBase with _$AlunoStore;

abstract class _AlunoStoreBase with Store {
  final DatabaseRepository _databaseRepository =
      Modular.get<DatabaseRepository>();

  @observable
  ObservableList<Aluno> alunos = ObservableList<Aluno>();

  @action
  Future<void> fetchTodos() async {
    final List<Aluno> fetchedTodos = await _databaseRepository.getAlunos();
    alunos = ObservableList<Aluno>.of(fetchedTodos);
  }
}
