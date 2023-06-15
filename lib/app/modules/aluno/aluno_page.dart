import 'package:escolar_modular/app/modules/aluno/utils/display_input_dialog.dart';
import 'package:escolar_modular/app/modules/aluno/utils/modal_bottom_sheet_aluno.dart';
import 'package:escolar_modular/app/modules/aluno/utils/search_delegate_aluno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/stores/aluno_store.dart';

class AlunoPage extends StatelessWidget {
  AlunoPage({Key? key}) : super(key: key);

  final TextEditingController _textNomeController = TextEditingController();
  final AlunoStore alunoStore = Modular.get<AlunoStore>();

  @override
  Widget build(BuildContext context) {
    alunoStore.fetchTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchDelegateAluno(alunoStore.alunos));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: alunoStore.alunos.length,
            itemBuilder: (BuildContext context, int index) {
              final item = alunoStore.alunos[index];
              return GestureDetector(
                child: ListTile(
                  title: Text(
                    item.nome,
                    style: const TextStyle(fontSize: 20),
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      '${item.nome[0]}${item.nome[1]}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onTap: () {
                  ModalBottomSheetAluno modalBottomSheetAluno =
                      ModalBottomSheetAluno();
                  modalBottomSheetAluno.modalBottomSheetAluno(
                      _textNomeController, context, item);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DisplayInputDialog displayDialog = DisplayInputDialog();
          displayDialog.displayTextInputDialog(
              _textNomeController, context, false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
