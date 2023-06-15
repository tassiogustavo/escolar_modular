import 'package:escolar_modular/app/modules/home/utils/card_home_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          CardHomePage(
            imageTilePath: 'assets/aluno.png',
            title: 'Alunos',
            subtitle:
                'Faça inserções, alterações, exclusões e matrícula de alunos',
            routePath: '/aluno/',
            acessarKey: 'acessar_aluno',
          ),
          CardHomePage(
            imageTilePath: 'assets/curso.png',
            title: 'Cursos',
            subtitle: 'Faça inserções, alterações e exclusões de cursos',
            routePath: '/curso/',
            acessarKey: 'acessar_curso',
          ),
        ]),
      ),
    );
  }
}
