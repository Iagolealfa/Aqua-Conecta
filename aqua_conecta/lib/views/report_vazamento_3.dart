import 'package:flutter/material.dart';

class ReportSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vazamento'),
        automaticallyImplyLeading: false, // Remove o botão de voltar padrão
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.horizontal_rule,
                    size: 50, color: Color.fromARGB(254, 58, 57, 57)),
                Icon(Icons.horizontal_rule,
                    size: 50, color: Color.fromARGB(254, 58, 57, 57)),
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                  size: 40,
                ),
              ],
            ),
            const SizedBox(height: 100),
            const Text(
              'Concluído!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Você ganhou 10 pontos por compartilhar essa informação.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/pin_vazamento.png',
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Ok!'),
            ),
          ],
        ),
      ),
    );
  }
}
