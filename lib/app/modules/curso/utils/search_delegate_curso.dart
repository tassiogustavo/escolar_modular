import 'package:escolar_modular/models/curso.dart';
import 'package:flutter/material.dart';

class SearchDelegateCurso extends SearchDelegate {
  List<Curso> cursos = [];
  SearchDelegateCurso(this.cursos);

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
    List<Curso> searchAlunos = [];
    if (!(query.length < 3)) {
      searchAlunos = cursos.where((element) {
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
      itemCount: searchAlunos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchAlunos[index].descricao),
          onTap: () {
            query = searchAlunos[index].descricao;
            showResults(context);
          },
        );
      },
    );
  }
}
