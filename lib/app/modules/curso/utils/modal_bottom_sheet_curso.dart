import 'package:escolar_modular/app/modules/curso/utils/display_dialog_helper.dart';
import 'package:escolar_modular/app/shared/stores/curso_store.dart';
import 'package:escolar_modular/models/curso.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModalBottomSheetCurso {
  final CursoStore cursoStore = Modular.get<CursoStore>();
  final DatabaseRepository _databaseRepository =
      Modular.get<DatabaseRepository>();

  Future<void> modalBottomSheetCurso(
      TextEditingController textDescricaoController,
      TextEditingController textEmentaController,
      BuildContext context,
      Curso item) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 210,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    child: const Text(
                      "Matriculados",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      cursoStore.fetchByCurso(item.codigo!);
                      DisplayDialogHelper displayDialog = DisplayDialogHelper();
                      displayDialog.displayMatriculados(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    child: const Text(
                      "Editar",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      textDescricaoController.text = item.descricao;
                      textEmentaController.text = item.ementa;
                      DisplayDialogHelper displayDialog = DisplayDialogHelper();
                      displayDialog.displayInputDialogCurso(
                          textDescricaoController,
                          textEmentaController,
                          context,
                          true,
                          cursoToEdit: item);
                      cursoStore.fetchTodos();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    child: const Text(
                      "Excluir",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      _databaseRepository
                          .deleteCurso(item.codigo!)
                          .then((value) {
                        cursoStore.fetchTodos();
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
