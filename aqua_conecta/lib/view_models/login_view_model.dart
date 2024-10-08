import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  Future<void> login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
        await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logado com sucesso'),
          backgroundColor: Colors.blueAccent,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email/Usuário não cadastrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha incorreta. Tente novamente'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email inválido'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro de rede. Verifique sua conexão com a internet.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciais inválidas. Verifique seu email e senha.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao fazer login. Tente novamente'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
