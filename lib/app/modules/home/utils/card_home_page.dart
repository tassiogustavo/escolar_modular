import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardHomePage extends StatelessWidget {
  final String imageTilePath;
  final String title;
  final String subtitle;
  final String routePath;
  final String acessarKey;
  const CardHomePage({
    super.key,
    required this.imageTilePath,
    required this.title,
    required this.subtitle,
    required this.routePath,
    required this.acessarKey,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.asset(imageTilePath),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtitle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                key: Key(acessarKey),
                child: const Text('Acessar'),
                onPressed: () {
                  Modular.to.pushNamed(routePath);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
