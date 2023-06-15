import 'package:escolar_modular/data/database_helper.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/stores/aluno_store.dart';
import 'aluno_page.dart';

class AlunoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DatabaseRepository(DatabaseHelper())),
    Bind((_) => AlunoStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AlunoPage()),
  ];
}
