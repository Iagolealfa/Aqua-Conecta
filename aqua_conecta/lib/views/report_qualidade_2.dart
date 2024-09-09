import 'package:flutter/material.dart';

class ConcluidoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qualidade'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone de confirmação
            Icon(
              Icons.done, // Ícone de check para indicar conclusão
              size: 70,
              color: Colors.blue, // Cor azul
            ),
            SizedBox(height: 30),
            // Título
            Text(
              'Concluído!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            // Mensagem de pontos
            Text(
              'Você ganhou 10 pontos por compartilhar essa informação.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 40),
            // Imagem (substitua pelo seu próprio ativo de imagem)
            Image.asset(
              'assets/icon_quality.png', // Certifique-se de que o arquivo esteja na pasta correta
              width: 100,
              height: 100,
            ),
            SizedBox(height: 40),
            // Botão OK
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: Text('Ok!'),
            ),
          ],
        ),
      ),
    );
  }
}
