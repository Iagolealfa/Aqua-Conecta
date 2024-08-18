import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqua_conecta/views/home_view.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  String? userId;
  Future<void> login(BuildContext context) async {
    try {
      print(
          "Tentando fazer login com email: ${emailController.text} e senha: ${passwordController.text}");
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      userId = emailController.text;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Logado com sucesso',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blueAccent,
        ),
      );
    } on FirebaseAuthException catch (e) {
      print("Erro de autenticação: ${e.code} - ${e.message}");
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Email/Usuário não cadastrado';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Senha incorreta. Tente novamente';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email inválido';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Erro de rede. Verifique sua conexão com a internet.';
      } else {
        errorMessage = 'Erro ao fazer login. Tente novamente';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      print("Erro desconhecido: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erro desconhecido. Tente novamente',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
