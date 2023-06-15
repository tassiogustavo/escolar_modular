import 'package:escolar_modular/app/modules/curso/curso_page.dart';
import 'package:escolar_modular/app/shared/stores/curso_store.dart';
import 'package:escolar_modular/data/database_helper.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CursoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DatabaseRepository(DatabaseHelper())),
    Bind((_) => CursoStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CursoPage()),
  ];
}
