// lib/view_models/cadastro_view_model.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aqua_conecta/models/user_model.dart';
import 'package:aqua_conecta/models/database_model.dart';

class CadastroViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  bool showPassword = true;

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
      OurDatabase().createUser(
        nome: nomeController.text,
        email: emailController.text,
        endereco:  adressController.text,
      );

      //await FirebaseFirestore.instance.collection('usuários/${emailController.text}/conta').doc('informacoes').set({
      //  'nomeUsuario': nomeController.text,
      //  'email': emailController.text,
      //});

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
            content: Text('Senha fraca. Tente novamente'),
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
}
