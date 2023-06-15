import 'package:escolar_modular/app/modules/curso/utils/display_dialog_helper.dart';
import 'package:escolar_modular/app/modules/curso/utils/modal_bottom_sheet_curso.dart';
import 'package:escolar_modular/app/modules/curso/utils/search_delegate_curso.dart';
import 'package:escolar_modular/app/shared/stores/curso_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CursoPage extends StatelessWidget {
  CursoPage({Key? key}) : super(key: key);

  final TextEditingController _textDescricaoController =
      TextEditingController();

  final TextEditingController _textEmentaController = TextEditingController();
  final CursoStore cursoStore = Modular.get<CursoStore>();

  @override
  Widget build(BuildContext context) {
    cursoStore.fetchTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchDelegateCurso(cursoStore.cursos));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: cursoStore.cursos.length,
            itemBuilder: (BuildContext context, int index) {
              final item = cursoStore.cursos[index];
              return GestureDetector(
                child: ListTile(
                  title: Text(
                    item.descricao,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'Ementa: ${item.ementa}',
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      '${item.descricao[0]}${item.descricao[1]}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onTap: () {
                  ModalBottomSheetCurso modalBottomSheetCurso =
                      ModalBottomSheetCurso();
                  modalBottomSheetCurso.modalBottomSheetCurso(
                      _textDescricaoController,
                      _textEmentaController,
                      context,
                      item);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DisplayDialogHelper displayDialog = DisplayDialogHelper();
          displayDialog.displayInputDialogCurso(
              _textDescricaoController, _textEmentaController, context, false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
