import 'package:escolar_modular/app/shared/stores/aluno_store.dart';
import 'package:escolar_modular/models/aluno.dart';
import 'package:escolar_modular/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DisplayInputDialog {
  final AlunoStore alunoStore = Modular.get<AlunoStore>();
  final DatabaseRepository _databaseRepository =
      Modular.get<DatabaseRepository>();

  Future<void> displayTextInputDialog(TextEditingController textNomeController,
      BuildContext context, bool isUpdate,
      {Aluno? alunoToEdit}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isUpdate
              ? const Text('Alterar Aluno')
              : const Text('Cadastre um Aluno'),
          content: TextField(
            controller: textNomeController,
            decoration: const InputDecoration(hintText: "Nome do Aluno"),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('OK'),
              onPressed: () {
                if (isUpdate) {
                  alunoToEdit!.nome = textNomeController.text;
                  _databaseRepository.updateAluno(alunoToEdit).then((value) {
                    textNomeController.clear();
                    Navigator.pop(context);
                    alunoStore.fetchTodos();
                  });
                } else {
                  Aluno aluno = Aluno(nome: textNomeController.text);
                  _databaseRepository.insertAluno(aluno).then((value) {
                    textNomeController.clear();
                    Navigator.pop(context);
                    alunoStore.fetchTodos();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
