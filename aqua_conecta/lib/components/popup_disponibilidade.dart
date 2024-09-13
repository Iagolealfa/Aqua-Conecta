import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../view_models/location_controller.dart'; // Sua classe DispAgua
import 'package:provider/provider.dart';
import 'package:aqua_conecta/view_models/login_view_model.dart';
import '../services/location_geocoder.dart';

class PopupAgua extends StatelessWidget {
  final GetLocation dispAgua;

  const PopupAgua({Key? key, required this.dispAgua}) : super(key: key);

  Future<void> _handleClick(BuildContext context, bool resposta) async {
    final GeocodingService _geocodingService = GeocodingService();
    if (resposta) {
      await dispAgua.getPosition();
    }

    DateTime dataHoraAtual = DateTime.now();
    String dataHoraFormatada =
        DateFormat('dd/MM/yyyy HH:mm:ss').format(dataHoraAtual);

    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final String? userEmail = loginViewModel.userId;

    if (userEmail != null) {
      try {
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance
                .collection('usuários')
                .doc(userEmail)
                .get();

        final String? userName = userDoc.data()?['nome'];
        String endereco = await _geocodingService.getAddressFromCoordinates(
            dispAgua.lat, dispAgua.long);
        if (userName != null) {
          await FirebaseFirestore.instance.collection('disponibilidade').add({
            'resposta': resposta,
            'latitude': dispAgua.lat,
            'longitude': dispAgua.long,
            'data': dataHoraFormatada,
            'usuario': userEmail,
            'nome': userName,
            'endereco': endereco
          });
        } else {
          print('O campo "nome" não foi encontrado no documento do usuário.');
        }
      } catch (e) {
        print(
            'Erro ao buscar o documento do usuário ou adicionar a disponibilidade: $e');
      }
    } else {
      print('Usuário não logado ou ID do usuário não encontrado.');
    }

    Navigator.of(context).pop({
      'resposta': resposta,
      'latitude': dispAgua.lat,
      'longitude': dispAgua.long,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.help_outline,
            color: Colors.blue,
            size: 50,
          ),
          SizedBox(height: 16.0),
          Text(
            "Tem água na sua casa?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            "Informe se há água disponível",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Cor de fundo
                  side: BorderSide(color: Colors.blue), // Borda azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => _handleClick(context, true),
                child: Text(
                  "Sim",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor de fundo azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => _handleClick(context, false),
                child: Text(
                  "Não",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
