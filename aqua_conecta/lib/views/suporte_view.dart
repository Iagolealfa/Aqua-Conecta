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
      "resposta": "Para reportar um vazamento ou problemas de qualidade da água, vá para a seção de relatórios (Símbolo de \"+\") escolha entre as opções de relatório e preencha o formulário adequado."
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
      "resposta": "Use o botão de \"gota\" para reportar a disponibilidade de água em sua área atual."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.of(context).pushNamed('/contato');
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
