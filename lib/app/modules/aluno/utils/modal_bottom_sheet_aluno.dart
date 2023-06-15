import 'package:escolar_modular/app/modules/aluno/utils/display_input_dialog.dart';
import 'package:escolar_modular/app/shared/stores/aluno_store.dart';
import 'package:escolar_modular/models/aluno.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModalBottomSheetAluno {
  final AlunoStore alunoStore = Modular.get<AlunoStore>();
  final DatabaseRepository _databaseRepository =
      Modular.get<DatabaseRepository>();

  Future<void> modalBottomSheetAluno(TextEditingController textNomeController,
      BuildContext context, Aluno item) {
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
                      "Matricular",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/matricula/', arguments: item);
                      Navigator.pop(context);
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
                      textNomeController.text = item.nome;
                      DisplayInputDialog displayDialog = DisplayInputDialog();
                      displayDialog.displayTextInputDialog(
                          textNomeController, context, true,
                          alunoToEdit: item);
                      alunoStore.fetchTodos();
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
                      _databaseRepository.deleteAluno(item.codigo!);
                      alunoStore.fetchTodos();
                      Navigator.pop(context);
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
