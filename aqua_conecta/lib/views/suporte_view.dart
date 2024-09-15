import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:aqua_conecta/components/large_button.dart';

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
      "resposta":
          "1- Na tela principal (home) clique no ícone “+” \n2- Ao aparecer o popup você pode escolher entre reportar vazamento de água ou a qualidade da mesma"
    },
    {
      "pergunta": "O que significam os ícones no mapa?",
      "resposta":
          "Cada ícone representa um ponto de interesse ou um relatório enviado pelos usuários. Você pode clicar nos ícones para mais detalhes."
    },
    {
      "pergunta": "Como acessar seu perfil?",
      "resposta":
          "1- No menu lateral (drawer) clique na imagem de perfil que aparece no topo\n2- Depois de clicado você será levado para a aba de perfil"
    },
    {
      "pergunta": "Como verificar os relatórios gerados?",
      "resposta":
          "1- No menu lateral (drawer) clique em “Relatórios”\n2- Depois de clicado você será levado para a aba de relatórios\n3- Dentro você pode selecionar o tipo de relatório que gostaria de visualizar"
    },
    {
      "pergunta": "Como reportar disponibilidade da água?",
      "resposta":
          "1- Na tela inicial clique no  botão flutuante com o símbolo de água, localizado no canto inferior direito."
    },
  ];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white, // Define o fundo da tela como branco
    drawer: const AppDrawer(),
    appBar: AppBar(
      title: const Text(
        'Suporte',
        style: TextStyle(color: Color(0xFF729AD6)),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'PRINCIPAIS PERGUNTAS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
                fontFamily: 'Roboto'
            ),
            textAlign: TextAlign.center,
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
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
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
          LargeButton(
              texto: 'Enviar uma mensagem',
              onPressed: () {
                Navigator.of(context).pushNamed('/contato');
              },
          ),
              const SizedBox(height: 30),
        ],
      ),
    ),
  );
}

}
