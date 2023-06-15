// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curso_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CursoStore on _CursoStoreBase, Store {
  late final _$cursosAtom =
      Atom(name: '_CursoStoreBase.cursos', context: context);

  @override
  ObservableList<Curso> get cursos {
    _$cursosAtom.reportRead();
    return super.cursos;
  }

  @override
  set cursos(ObservableList<Curso> value) {
    _$cursosAtom.reportWrite(value, super.cursos, () {
      super.cursos = value;
    });
  }

  late final _$listMatriculadosAtom =
      Atom(name: '_CursoStoreBase.listMatriculados', context: context);

  @override
  List<String> get listMatriculados {
    _$listMatriculadosAtom.reportRead();
    return super.listMatriculados;
  }

  @override
  set listMatriculados(List<String> value) {
    _$listMatriculadosAtom.reportWrite(value, super.listMatriculados, () {
      super.listMatriculados = value;
    });
  }

  late final _$fetchTodosAsyncAction =
      AsyncAction('_CursoStoreBase.fetchTodos', context: context);

  @override
  Future<void> fetchTodos() {
    return _$fetchTodosAsyncAction.run(() => super.fetchTodos());
  }

  late final _$fetchByCursoAsyncAction =
      AsyncAction('_CursoStoreBase.fetchByCurso', context: context);

  @override
  Future<void> fetchByCurso(int codigo) {
    return _$fetchByCursoAsyncAction.run(() => super.fetchByCurso(codigo));
  }

  @override
  String toString() {
    return '''
cursos: ${cursos},
listMatriculados: ${listMatriculados}
    ''';
  }
}
