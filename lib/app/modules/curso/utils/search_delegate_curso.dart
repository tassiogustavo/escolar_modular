import 'package:escolar_modular/app/modules/curso/utils/display_dialog_helper.dart';
import 'package:escolar_modular/app/shared/stores/curso_store.dart';
import 'package:escolar_modular/models/curso.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchDelegateCurso extends SearchDelegate {
  List<Curso> cursos = [];
  SearchDelegateCurso(this.cursos);
  final CursoStore cursoStore = Modular.get<CursoStore>();

  String removeDiacritics(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Curso> searchCursos = [];
    if (!(query.length < 3)) {
      searchCursos = cursos.where((element) {
        final partesNome =
            removeDiacritics(element.descricao.toLowerCase()).split(' ');
        final partesBusca = removeDiacritics(query.toLowerCase()).split(' ');

        bool encontrou = true;

        for (String parteBusca in partesBusca) {
          bool parteEncontrada = false;

          for (String parteNome in partesNome) {
            if (parteNome.contains(parteBusca)) {
              parteEncontrada = true;
              break;
            }
          }

          if (!parteEncontrada) {
            encontrou = false;
            break;
          }
        }

        return encontrou;
      }).toList();
    }

    return ListView.builder(
      itemCount: searchCursos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchCursos[index].descricao),
          onTap: () {
            Navigator.pop(context);
            cursoStore.fetchByCurso(searchCursos[index].codigo!);
            DisplayDialogHelper displayDialog = DisplayDialogHelper();
            displayDialog.displayMatriculados(context);
          },
        );
      },
    );
  }
}
