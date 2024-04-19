import 'package:flutter/material.dart';
import 'package:aqua_conecta/components/large_button.dart';
import 'package:aqua_conecta/routes.dart';

class EsqueciSenhaView extends StatefulWidget {

  const EsqueciSenhaView({super.key});

  @override
  _EsqueciSenhaViewState createState() => _EsqueciSenhaViewState();
}

class _EsqueciSenhaViewState extends State<EsqueciSenhaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: ListView(
          children: <Widget>[
            const Text('Esqueceu a senha?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Color.fromRGBO(113, 153, 213, 1),
                fontFamily: 'Roboto',
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text('Digite o email cadastrado',
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Colors.black,
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 327,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: TextFormField(
                //controller: _emailController,
                //autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 270,
            ),
            LargeButton(
              texto: 'Enviar',
              onPressed: () {
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: const Text(
                  "Lembrei da minha senha! Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
