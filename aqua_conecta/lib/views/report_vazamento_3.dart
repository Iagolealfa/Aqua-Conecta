import 'package:flutter/material.dart';

class ReportSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vazamento'),
        automaticallyImplyLeading: false, // Remove o botão de voltar padrão
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            SizedBox(height: 20),
            Row(
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
            SizedBox(height: 100),
            Text(
              'Concluído!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Você ganhou 10 pontos por compartilhar essa informação.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/pin_vazamento.png',
              height: 120,
              width: 120,
            ),
            SizedBox(height: 120),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Ok!'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
