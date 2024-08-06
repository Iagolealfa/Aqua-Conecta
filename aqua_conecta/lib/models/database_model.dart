// lib/models/database_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqua_conecta/models/user_model.dart';

class OurDatabase {
  final FirebaseFirestore docUser = FirebaseFirestore.instance;

  Future<void> createUser({
    required String nome,
    required String email,
    String? endereco, // Torne o endereço opcional
  }) async {
    final docUser = FirebaseFirestore.instance.collection('usuários').doc(email);

    final user = OurUser(
      id: docUser.id,
      nome: nome,
      email: email,
      imageURL: '',
      endereco: endereco ?? '', // Use uma string vazia se o endereço não for fornecido
    );

    final json = user.toJson();
    await docUser.set(json);
  }

  Future<void> updateUserImageURL(String imageUrl) async {
    final _user = FirebaseAuth.instance.currentUser;
    final docUser = FirebaseFirestore.instance
        .collection('usuários')
        .doc(_user?.email);
    docUser.update({
      'imageURL': imageUrl,
    });
  }

  Future<void> updateUserName(String nome) async {
    final _user = FirebaseAuth.instance.currentUser;
    final docUser = FirebaseFirestore.instance
        .collection('usuários')
        .doc(_user?.email);
    docUser.update({
      'nome': nome,
    });
  }
}
