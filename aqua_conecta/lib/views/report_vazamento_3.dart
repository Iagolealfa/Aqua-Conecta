import 'package:flutter/material.dart';
import 'package:aqua_conecta/components/large_button.dart';

class ReportSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vazamento',
            style: TextStyle(color: Color.fromARGB(255, 114, 154, 214))),
        centerTitle: true,
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
                    size: 50, color: Colors.green),
                Icon(Icons.horizontal_rule,
                    size: 50, color: Colors.green),
                Icon(
                  Icons.check_circle_outline,
                  color:  Color.fromARGB(255, 114, 154, 214),
                  size: 40,
                ),
              ],
            ),
            SizedBox(height: 75),
            Text(
              'Concluído!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 114, 154, 214),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Você ganhou 10 pontos por compartilhar essa informação.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color:   Color.fromARGB(255, 114, 154, 214),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/pin_vazamento.png',
              height: 120,
              width: 120,
            ),
            SizedBox(height: 40),
            LargeButton(
                texto: "Ok!",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                        (Route<dynamic> route) => false,
                  );
                },
              ),

          ],
        ),
      ),
    );
  }
}
