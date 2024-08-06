// lib/models/user_model.dart
class OurUser {
  final String id;
  final String nome;
  final String email;
  final String imageURL;
  final String endereco; // Torne o endereço opcional

  OurUser({
    required this.id,
    required this.nome,
    required this.email,
    required this.imageURL,
    this.endereco = '', // Defina um valor padrão para o endereço
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
    'imageURL': imageURL,
    'endereco': endereco, // Inclua o endereço na conversão para JSON
  };

// Se houver um método fromJson, ajuste-o para lidar com endereço opcional
}
