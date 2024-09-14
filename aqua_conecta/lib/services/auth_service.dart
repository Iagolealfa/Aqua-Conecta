import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  String? getUserName() {
    return usuario?.displayName;
  }

  Future<void> registrar(String email, String senha, String nome) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualizar o perfil do usuário com o nome
      await userCredential.user?.updateDisplayName(nome);

      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já cadastrado');
      }
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      List<String> signInMethods =
          await _auth.fetchSignInMethodsForEmail(email);

      if (signInMethods.isEmpty) {
        throw 'Nenhum usuário encontrado com esse email.';
      } else {
        await _auth.sendPasswordResetEmail(email: email);
      }
    } on FirebaseAuthException {
      throw 'Erro ao enviar email. Verifique o email digitado';
    } catch (e) {
      throw 'Ocorreu um erro ao processar a solicitação';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _getUser();
  }
}
