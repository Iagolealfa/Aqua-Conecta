import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqua_conecta/models/database_model.dart';

class CadastroViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;

  Future<void> cadastrar(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senhas não coincidem!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user!.updateDisplayName(nomeController.text);

      // Adiciona o usuário ao banco de dados
      await OurDatabase().createUser(
        nome: nomeController.text,
        email: emailController.text,
        endereco: adressController.text,
      );

      // Limpa todos os campos
      nomeController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      adressController.clear();

      Navigator.pushReplacementNamed(context, '/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado.'),
          backgroundColor: Colors.blueAccent,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha fraca. A senha deve ter no mínimo 6 caracteres.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email já foi cadastrado'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }
}
