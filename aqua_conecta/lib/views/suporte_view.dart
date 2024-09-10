import 'package:flutter/material.dart';
import '../components/drawer.dart';

class SuporteView extends StatefulWidget {
  const SuporteView({Key? key}) : super(key: key);

  static const routeName = '/suporte';

  @override
  State<SuporteView> createState() => _SuporteViewState();
}

class _SuporteViewState extends State<SuporteView> {
  final List<Map<String, String>> faq = [
    {
      "pergunta": "Como reportar vazamento/qualidade da água?",
      "resposta": "Para reportar um vazamento ou problemas de qualidade da água, vá para a seção de relatórios (Símbolo de ""+"") escolha entre as opções de relatório e preencha o formulário adequado."
    },
    {
      "pergunta": "O que significam os ícones no mapa?",
      "resposta": "Cada ícone representa um ponto de interesse ou um relatório enviado pelos usuários. Você pode clicar nos ícones para mais detalhes."
    },
    {
      "pergunta": "Como acessar seu perfil?",
      "resposta": "Para acessar seu perfil, clique no ícone de perfil na barra de navegação no canto superior direito."
    },
    {
      "pergunta": "Como verificar os relatórios gerados?",
      "resposta": "Na seção de relatórios, você encontrará todos os relatórios que você enviou, lá relatórios poderão ser filtrado por endereço ou tipo de relato."
    },
    {
      "pergunta": "Como reportar disponibilidade da água?",
      "resposta": "Use o botão de ""gota"" para reportar a disponibilidade de água em sua área atual."
    },
  ];

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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: faq.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ExpansionTile(
                      title: Text(
                        faq[index]["pergunta"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faq[index]["resposta"]!,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ainda precisa de ajuda?',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Implementar lógica de enviar mensagem
              },
              icon: const Icon(Icons.message, color: Colors.white),
              label: const Text('Envie uma mensagem', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30), // Espaço inferior para evitar corte
          ],
        ),
      ),
    );
  }
}