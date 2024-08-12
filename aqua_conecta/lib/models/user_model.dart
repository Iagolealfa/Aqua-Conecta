// lib/models/user_model.dart
class OurUser {
  final String id;
  final String nome;
  final String email;
  final String imageURL;
  final String endereco;

  OurUser({
    required this.id,
    required this.nome,
    required this.email,
    required this.imageURL,
    required this.endereco,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
    'imageURL': imageURL,
    'endereco': endereco,
  };


}
