// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlunoStore on _AlunoStoreBase, Store {
  late final _$alunosAtom =
      Atom(name: '_AlunoStoreBase.alunos', context: context);

  @override
  ObservableList<Aluno> get alunos {
    _$alunosAtom.reportRead();
    return super.alunos;
  }

  @override
  set alunos(ObservableList<Aluno> value) {
    _$alunosAtom.reportWrite(value, super.alunos, () {
      super.alunos = value;
    });
  }

  late final _$fetchTodosAsyncAction =
      AsyncAction('_AlunoStoreBase.fetchTodos', context: context);

  @override
  Future<void> fetchTodos() {
    return _$fetchTodosAsyncAction.run(() => super.fetchTodos());
  }

  @override
  String toString() {
    return '''
alunos: ${alunos}
    ''';
  }
}
