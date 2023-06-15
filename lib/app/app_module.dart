import 'package:escolar_modular/app/modules/aluno/aluno_module.dart';
import 'package:escolar_modular/app/modules/curso/curso_module.dart';
import 'package:escolar_modular/app/modules/home/home_module.dart';
import 'package:escolar_modular/app/modules/matricula/matricula_module.dart';
import 'package:escolar_modular/data/database_helper.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind<Object>> binds = [
    Bind.lazySingleton((i) => DatabaseHelper()),
    Bind.lazySingleton((i) => DatabaseRepository(i.get<DatabaseHelper>()))
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/aluno', module: AlunoModule()),
        ModuleRoute('/curso', module: CursoModule()),
        ModuleRoute('/matricula', module: MatriculaModule()),
      ];
}
