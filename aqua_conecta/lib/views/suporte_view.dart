import 'package:flutter/material.dart';
import '../components/drawer.dart';

class SuporteView extends StatefulWidget {
  const SuporteView({Key? key}) : super(key: key);

  static const routeName = '/suporte';

  @override
  State<SuporteView> createState() => _SuporteViewState();
}

class _SuporteViewState extends State<SuporteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      const Text(
                        'PRINCIPAIS PERGUNTAS',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ExpansionTile(
                        title: const Text('Como reportar vazamento/qualidade da água?'),
                        children: const <Widget>[
                          ListTile(
                            title: Text(
                              '1- Na tela principal (home) clique no ícone "+"',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '2- Ao aparecer o popup você pode escolher entre reportar vazamento de água ou a qualidade da mesma',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('O que significam os ícones no mapa?'),
                        children: const <Widget>[
                          ListTile(
                            title: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('Como acessar seu perfil?'),
                        children: const <Widget>[
                          ListTile(
                            title: Text(
                              '1- No menu lateral (drawer) clique na imagem de perfil que aparece no topo',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '2- Depois de clicado você será levado para a aba de perfil',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('Como verificar os relatórios gerados?'),
                        children: const <Widget>[
                          ListTile(
                            title: Text(
                              '1- No menu lateral (drawer) clique em “Relatórios”',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '2- Depois de clicado você será levado para a aba de relatórios',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '3- Dentro você pode selecionar o tipo de relatório que gostaria de visualizar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('Como reportar disponibilidade da água?'),
                        children: const <Widget>[
                          ListTile(
                            title: Text(
                              '1- Na tela inicial clique no  botão flutuante com o símbolo de água, localizado no canto inferior direito.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(91, 91, 91, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Ainda precisa de ajuda?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Elaborar tela
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Envie uma mensagem',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 15)
                    ],
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
