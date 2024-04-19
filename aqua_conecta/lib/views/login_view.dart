import 'package:flutter/material.dart';
import 'package:aqua_conecta/components/large_button.dart';
import 'package:aqua_conecta/routes.dart';

class LoginView extends StatefulWidget {

  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _showPassword = true;
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
            const Text('Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Color.fromRGBO(113, 153, 213, 1),
                fontFamily: 'Roboto',
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 87,
              height: 120,
              child: Image.asset("assets/images/logo_app.png"),
            ),
            const SizedBox(
              height: 60,
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
              height: 20,
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
                //autofocus: true,
                //controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: _showPassword,
                decoration:  InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      _showPassword == true ? Icons.visibility_off : Icons.visibility,
                      color: Color.fromRGBO(113, 153, 213, 1),
                    ),
                    onTap: (){
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  labelText: "Senha",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/esqueciSenhaEnviar');
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            LargeButton(
              texto: 'Entrar',
              onPressed: () {
                //login();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cadastro');
                },
                child: const Text(
                  "Cadastre-se",
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
        