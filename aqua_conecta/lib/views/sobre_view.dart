import 'package:flutter/material.dart';
import '../components/drawer.dart';

class SobreView extends StatefulWidget {
  const SobreView({Key? key}) : super(key: key);

  static const routeName = '/sobre';

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            color: Color.fromRGBO(114, 154, 214, 1), // Cor de fundo
            child: Column(
              children: <Widget>[
                const SizedBox(height: 60),
                Expanded(
                  child: Center(
                    child: Text(
                      'O objetivo do nosso aplicativo é abordar o problema da escassez de água, buscando soluções colaborativas para apoiar aqueles que enfrentam desafios relacionados à falta d\'água. Estamos comprometidos em criar uma plataforma que una as pessoas e ofereça recursos para lidar com essa questão crucial.',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'version   1.0 - magikarp',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
